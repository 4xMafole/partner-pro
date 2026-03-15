/// Unit tests for AuthRemoteDataSource
///
/// Tests the data source layer for Firebase authentication.
library;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:partner_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partner_pro/features/auth/data/models/user_model.dart';
import 'package:partner_pro/core/error/exceptions.dart';

import '../../../../mocks/mock_firebase_auth.dart';
import '../../../../mocks/mock_firestore.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUpAll(() {
    registerAuthFallbackValues();
  });

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = createTestFirestore();
    dataSource = AuthRemoteDataSourceImpl(mockAuth, mockFirestore);
  });

  group('AuthRemoteDataSource - signInWithEmail', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('should return UserCredential on successful sign-in', () async {
      // Arrange
      final mockCred = createTestUserCredential(email: testEmail);
      when(() => mockAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => mockCred);

      // Act
      final result = await dataSource.signInWithEmail(testEmail, testPassword);

      // Assert
      expect(result, mockCred);
      expect(result.user?.email, testEmail);
      verify(() => mockAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).called(1);
    });

    test('should throw AuthException on wrong-password error', () async {
      // Arrange
      when(() => mockAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenThrow(createAuthException(code: 'wrong-password'));

      // Act & Assert
      expect(
        () => dataSource.signInWithEmail(testEmail, testPassword),
        throwsA(isA<AuthException>().having(
          (e) => e.message,
          'message',
          contains('Incorrect password'),
        )),
      );
    });

    test('should throw AuthException on user-not-found error', () async {
      // Arrange
      when(() => mockAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenThrow(createAuthException(code: 'user-not-found'));

      // Act & Assert
      expect(
        () => dataSource.signInWithEmail(testEmail, testPassword),
        throwsA(isA<AuthException>().having(
          (e) => e.message,
          'message',
          contains('No account found'),
        )),
      );
    });

    test('should throw AuthException on invalid-email error', () async {
      // Arrange
      when(() => mockAuth.signInWithEmailAndPassword(
            email: 'invalid-email',
            password: testPassword,
          )).thenThrow(createAuthException(code: 'invalid-email'));

      // Act & Assert
      expect(
        () => dataSource.signInWithEmail('invalid-email', testPassword),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('AuthRemoteDataSource - registerWithEmail', () {
    const testEmail = 'new@example.com';
    const testPassword = 'password123';

    test('should return UserCredential on successful registration', () async {
      // Arrange
      final mockCred = createTestUserCredential(email: testEmail);
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => mockCred);

      // Act
      final result =
          await dataSource.registerWithEmail(testEmail, testPassword);

      // Assert
      expect(result, mockCred);
      verify(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).called(1);
    });

    test('should throw AuthException on email-already-in-use error', () async {
      // Arrange
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenThrow(createAuthException(code: 'email-already-in-use'));

      // Act & Assert
      expect(
        () => dataSource.registerWithEmail(testEmail, testPassword),
        throwsA(isA<AuthException>().having(
          (e) => e.message,
          'message',
          contains('already exists'),
        )),
      );
    });

    test('should throw AuthException on weak-password error', () async {
      // Arrange
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: '123',
          )).thenThrow(createAuthException(code: 'weak-password'));

      // Act & Assert
      expect(
        () => dataSource.registerWithEmail(testEmail, '123'),
        throwsA(isA<AuthException>().having(
          (e) => e.message,
          'message',
          contains('too weak'),
        )),
      );
    });
  });

  group('AuthRemoteDataSource - signOut', () {
    test('should call Firebase signOut',
        skip:
            'GoogleSignIn requires platform binding - test in integration tests',
        () async {
      // Arrange
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      // Act
      await dataSource.signOut();

      // Assert
      verify(() => mockAuth.signOut()).called(1);
    });
  });

  group('AuthRemoteDataSource - sendPasswordResetEmail', () {
    const testEmail = 'test@example.com';

    test('should send password reset email', () async {
      // Arrange
      when(() => mockAuth.sendPasswordResetEmail(email: testEmail))
          .thenAnswer((_) async {});

      // Act
      await dataSource.sendPasswordResetEmail(testEmail);

      // Assert
      verify(() => mockAuth.sendPasswordResetEmail(email: testEmail)).called(1);
    });

    test('should throw AuthException on user-not-found error', () async {
      // Arrange
      when(() => mockAuth.sendPasswordResetEmail(email: testEmail))
          .thenThrow(createAuthException(code: 'user-not-found'));

      // Act & Assert
      expect(
        () => dataSource.sendPasswordResetEmail(testEmail),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('AuthRemoteDataSource - getUserProfile', () {
    const testUid = 'test_uid_123';
    final testUserData = createTestUserData(
      uid: testUid,
      email: 'test@example.com',
      displayName: 'Test User',
      role: 'buyer',
    );

    test('should return UserModel when profile exists', () async {
      // Arrange
      mockFirestore.addDocument('users', testUid, testUserData);

      // Act
      final result = await dataSource.getUserProfile(testUid);

      // Assert
      expect(result, isNotNull);
      expect(result?.uid, testUid);
      expect(result?.email, 'test@example.com');
      expect(result?.role, 'buyer');
    });

    test('should return null when profile does not exist', () async {
      // Act
      final result = await dataSource.getUserProfile('non_existent_uid');

      // Assert
      expect(result, isNull);
    });
  });

  group('AuthRemoteDataSource - createUserProfile', () {
    final testUser = UserModel(
      uid: 'new_user_123',
      email: 'new@example.com',
      displayName: 'New User',
      firstName: 'New',
      lastName: 'User',
      role: null,
    );

    test('should create user profile in Firestore', () async {
      // Act
      await dataSource.createUserProfile(testUser);

      // Assert
      final storedData = mockFirestore.getDocument('users', testUser.uid);
      expect(storedData, isNotNull);
      expect(storedData?['email'], testUser.email);
      expect(storedData?['displayName'], testUser.displayName);
    });
  });

  group('AuthRemoteDataSource - updateUserProfile', () {
    const testUid = 'test_uid_123';
    final initialData = createTestUserData(
      uid: testUid,
      role: 'buyer',
    );

    test('should update user profile fields', () async {
      // Arrange
      mockFirestore.addDocument('users', testUid, initialData);

      // Act
      await dataSource.updateUserProfile(testUid, {'role': 'agent'});

      // Assert
      final updatedData = mockFirestore.getDocument('users', testUid);
      expect(updatedData?['role'], 'agent');
    });
  });

  group('AuthRemoteDataSource - authStateChanges', () {
    test('should emit user when signed in', () async {
      // Arrange
      final testUser = createTestUser();

      // Start listening before emitting (broadcast stream)
      final future = expectLater(
        dataSource.authStateChanges,
        emitsInOrder([testUser]),
      );

      // Act
      mockAuth.signInUser(testUser);

      // Assert
      await future;
    });

    test('should emit null when signed out', () async {
      // Arrange
      final testUser = createTestUser();

      // Start listening before emitting (broadcast stream)
      final future = expectLater(
        dataSource.authStateChanges,
        emitsInOrder([testUser, null]),
      );

      // Act
      mockAuth.signInUser(testUser);
      mockAuth.signOutUser();

      // Assert
      await future;
    });
  });

  group('AuthRemoteDataSource - currentUser', () {
    test('should return current user when signed in', () {
      // Arrange
      final testUser = createTestUser();
      mockAuth.signInUser(testUser);

      // Act
      final result = dataSource.currentUser;

      // Assert
      expect(result, testUser);
    });

    test('should return null when not signed in', () {
      // Act
      final result = dataSource.currentUser;

      // Assert
      expect(result, isNull);
    });
  });
}
