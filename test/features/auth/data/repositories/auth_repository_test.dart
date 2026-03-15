/// Unit tests for AuthRepository
///
/// Tests the repository layer for authentication functionality.
library;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:partner_pro/features/auth/data/repositories/auth_repository.dart';
import 'package:partner_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partner_pro/features/auth/data/models/user_model.dart';
import 'package:partner_pro/core/error/exceptions.dart';
import 'package:partner_pro/core/error/failures.dart';

import '../../../../mocks/mock_firebase_auth.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class FakeUserModel extends Fake implements UserModel {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerAuthFallbackValues();
    registerFallbackValue(FakeUserModel());
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepository - signInWithEmail', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    final testUser = UserModel(
      uid: 'test_uid_123',
      email: testEmail,
      displayName: 'Test User',
      role: 'buyer',
    );

    test('should return UserModel when sign-in is successful', () async {
      // Arrange
      final mockCred = createTestUserCredential(
        uid: 'test_uid_123',
        email: testEmail,
      );
      when(() => mockRemoteDataSource.signInWithEmail(testEmail, testPassword))
          .thenAnswer((_) async => mockCred);
      when(() => mockRemoteDataSource.getUserProfile('test_uid_123'))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await repository.signInWithEmail(testEmail, testPassword);

      // Assert
      expect(result, isA<Right<Failure, UserModel>>());
      result.fold(
        (failure) => fail('Should return success'),
        (user) {
          expect(user.uid, 'test_uid_123');
          expect(user.email, testEmail);
          expect(repository.cachedUser, user);
        },
      );
      verify(() =>
              mockRemoteDataSource.signInWithEmail(testEmail, testPassword))
          .called(1);
      verify(() => mockRemoteDataSource.getUserProfile('test_uid_123'))
          .called(1);
    });

    test('should return AuthFailure when sign-in throws AuthException',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.signInWithEmail(testEmail, testPassword))
          .thenThrow(AuthException(message: 'Invalid credentials'));

      // Act
      final result = await repository.signInWithEmail(testEmail, testPassword);

      // Assert
      expect(result, isA<Left<Failure, UserModel>>());
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          expect((failure as AuthFailure).message, 'Invalid credentials');
        },
        (user) => fail('Should return failure'),
      );
    });

    test('should return AuthFailure when user profile is not found', () async {
      // Arrange
      final mockCred = createTestUserCredential(
        uid: 'test_uid_123',
        email: testEmail,
      );
      when(() => mockRemoteDataSource.signInWithEmail(testEmail, testPassword))
          .thenAnswer((_) async => mockCred);
      when(() => mockRemoteDataSource.getUserProfile('test_uid_123'))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.signInWithEmail(testEmail, testPassword);

      // Assert
      expect(result, isA<Left<Failure, UserModel>>());
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          expect((failure as AuthFailure).message, 'User profile not found');
        },
        (user) => fail('Should return failure'),
      );
    });
  });

  group('AuthRepository - registerWithEmail', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testFirstName = 'Test';
    const testLastName = 'User';
    final testUser = UserModel(
      uid: 'test_uid_123',
      email: testEmail,
      displayName: '$testFirstName $testLastName',
      firstName: testFirstName,
      lastName: testLastName,
      role: null,
    );

    test(
        'should create user profile and return UserModel on successful registration',
        () async {
      // Arrange
      final mockCred = createTestUserCredential(
        uid: 'test_uid_123',
        email: testEmail,
      );
      when(() =>
              mockRemoteDataSource.registerWithEmail(testEmail, testPassword))
          .thenAnswer((_) async => mockCred);
      when(() => mockRemoteDataSource.createUserProfile(any()))
          .thenAnswer((_) async {});
      when(() => mockRemoteDataSource.getUserProfile('test_uid_123'))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await repository.registerWithEmail(
        testEmail,
        testPassword,
        testFirstName,
        testLastName,
      );

      // Assert
      expect(result, isA<Right<Failure, UserModel>>());
      result.fold(
        (failure) => fail('Should return success'),
        (user) {
          expect(user.uid, 'test_uid_123');
          expect(user.email, testEmail);
          expect(user.firstName, testFirstName);
          expect(user.lastName, testLastName);
        },
      );
      verify(() =>
              mockRemoteDataSource.registerWithEmail(testEmail, testPassword))
          .called(1);
      verify(() => mockRemoteDataSource.createUserProfile(any())).called(1);
    });

    test('should return AuthFailure when registration throws AuthException',
        () async {
      // Arrange
      when(() =>
              mockRemoteDataSource.registerWithEmail(testEmail, testPassword))
          .thenThrow(AuthException(message: 'Email already in use'));

      // Act
      final result = await repository.registerWithEmail(
        testEmail,
        testPassword,
        testFirstName,
        testLastName,
      );

      // Assert
      expect(result, isA<Left<Failure, UserModel>>());
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          expect((failure as AuthFailure).message, 'Email already in use');
        },
        (user) => fail('Should return failure'),
      );
    });
  });

  group('AuthRepository - signInWithGoogle', () {
    final testUser = UserModel(
      uid: 'google_uid_123',
      email: 'test@gmail.com',
      displayName: 'Google User',
      role: 'buyer',
    );

    test('should return UserModel on successful Google sign-in', () async {
      // Arrange
      final mockCred = createTestUserCredential(
        uid: 'google_uid_123',
        email: 'test@gmail.com',
      );
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => mockCred);
      when(() => mockRemoteDataSource.getUserProfile('google_uid_123'))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await repository.signInWithGoogle();

      // Assert
      expect(result, isA<Right<Failure, UserModel>>());
      result.fold(
        (failure) => fail('Should return success'),
        (user) {
          expect(user.uid, 'google_uid_123');
          expect(user.email, 'test@gmail.com');
        },
      );
    });

    test('should create profile for new Google user', () async {
      // Arrange
      final mockCred = createTestUserCredential(
        uid: 'google_uid_123',
        email: 'test@gmail.com',
      );
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => mockCred);
      when(() => mockRemoteDataSource.getUserProfile('google_uid_123'))
          .thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.createUserProfile(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.signInWithGoogle();

      // Assert
      expect(result, isA<Right<Failure, UserModel>>());
      verify(() => mockRemoteDataSource.createUserProfile(any())).called(1);
    });
  });

  group('AuthRepository - signOut', () {
    test('should sign out user and clear cached user', () async {
      // Arrange
      repository.cachedUser; // Set a cached user
      when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async {});

      // Act
      final result = await repository.signOut();

      // Assert
      expect(result, isA<Right<Failure, void>>());
      expect(repository.cachedUser, isNull);
      verify(() => mockRemoteDataSource.signOut()).called(1);
    });
  });

  group('AuthRepository - sendPasswordResetEmail', () {
    const testEmail = 'test@example.com';

    test('should send password reset email successfully', () async {
      // Arrange
      when(() => mockRemoteDataSource.sendPasswordResetEmail(testEmail))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.sendPasswordResetEmail(testEmail);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(() => mockRemoteDataSource.sendPasswordResetEmail(testEmail))
          .called(1);
    });

    test('should return AuthFailure when email sending fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.sendPasswordResetEmail(testEmail))
          .thenThrow(AuthException(message: 'User not found'));

      // Act
      final result = await repository.sendPasswordResetEmail(testEmail);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          expect((failure as AuthFailure).message, 'User not found');
        },
        (_) => fail('Should return failure'),
      );
    });
  });

  group('AuthRepository - updateUserRole', () {
    const testUid = 'test_uid_123';
    const testRole = 'agent';

    test('should update user role successfully', () async {
      // Arrange
      when(() => mockRemoteDataSource.updateUserProfile(testUid, any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.updateUserRole(testUid, testRole);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(() => mockRemoteDataSource.updateUserProfile(testUid, any()))
          .called(1);
    });
  });

  group('AuthRepository - authStateChanges', () {
    test('should emit user when auth state changes', () async {
      // Arrange
      final testFirebaseUser = createTestUser(
        uid: 'test_uid_123',
        email: 'test@example.com',
      );
      final testUserModel = UserModel(
        uid: 'test_uid_123',
        email: 'test@example.com',
        displayName: 'Test User',
        role: 'buyer',
      );

      when(() => mockRemoteDataSource.authStateChanges)
          .thenAnswer((_) => Stream.value(testFirebaseUser));
      when(() => mockRemoteDataSource.getUserProfile('test_uid_123'))
          .thenAnswer((_) async => testUserModel);

      // Act & Assert
      expect(
        repository.authStateChanges,
        emitsInOrder([testUserModel]),
      );
    });

    test('should emit null when user signs out', () async {
      // Arrange
      when(() => mockRemoteDataSource.authStateChanges)
          .thenAnswer((_) => Stream.value(null));

      // Act & Assert
      expect(repository.authStateChanges, emitsInOrder([null]));
      await Future.delayed(const Duration(milliseconds: 100));
      expect(repository.cachedUser, isNull);
    });
  });
}
