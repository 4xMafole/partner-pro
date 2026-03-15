/// Unit tests for AuthBloc
///
/// Tests the BLoC layer for authentication state management.
library;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'package:partner_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:partner_pro/features/auth/data/repositories/auth_repository.dart';
import 'package:partner_pro/features/auth/data/models/user_model.dart';
import 'package:partner_pro/core/error/failures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc bloc;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    bloc = AuthBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('AuthBloc - SignInWithEmail', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    final testUser = UserModel(
      uid: 'test_uid_123',
      email: testEmail,
      displayName: 'Test User',
      role: 'buyer',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when sign-in succeeds',
      build: () {
        when(() => mockRepository.signInWithEmail(testEmail, testPassword))
            .thenAnswer((_) async => Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.signInWithEmail(
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: testUser),
      ],
      verify: (_) {
        verify(() => mockRepository.signInWithEmail(testEmail, testPassword))
            .called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when sign-in fails',
      build: () {
        when(() => mockRepository.signInWithEmail(testEmail, testPassword))
            .thenAnswer(
          (_) async => const Left(AuthFailure(message: 'Invalid credentials')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.signInWithEmail(
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Invalid credentials'),
      ],
    );
  });

  group('AuthBloc - RegisterWithEmail', () {
    const testEmail = 'new@example.com';
    const testPassword = 'password123';
    const testFirstName = 'New';
    const testLastName = 'User';
    final testUser = UserModel(
      uid: 'new_uid_123',
      email: testEmail,
      displayName: '$testFirstName $testLastName',
      firstName: testFirstName,
      lastName: testLastName,
      role: null,
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when registration succeeds',
      build: () {
        when(() => mockRepository.registerWithEmail(
              testEmail,
              testPassword,
              testFirstName,
              testLastName,
            )).thenAnswer((_) async => Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.registerWithEmail(
          email: testEmail,
          password: testPassword,
          firstName: testFirstName,
          lastName: testLastName,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when registration fails with email already in use',
      build: () {
        when(() => mockRepository.registerWithEmail(
              testEmail,
              testPassword,
              testFirstName,
              testLastName,
            )).thenAnswer(
          (_) async => const Left(
            AuthFailure(message: 'Email already in use'),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.registerWithEmail(
          email: testEmail,
          password: testPassword,
          firstName: testFirstName,
          lastName: testLastName,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Email already in use'),
      ],
    );
  });

  group('AuthBloc - SignInWithGoogle', () {
    final testUser = UserModel(
      uid: 'google_uid_123',
      email: 'test@gmail.com',
      displayName: 'Google User',
      role: 'buyer',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when Google sign-in succeeds',
      build: () {
        when(() => mockRepository.signInWithGoogle())
            .thenAnswer((_) async => Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.signInWithGoogle()),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when Google sign-in is cancelled',
      build: () {
        when(() => mockRepository.signInWithGoogle()).thenAnswer(
          (_) async => const Left(
            AuthFailure(message: 'Google sign-in cancelled'),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.signInWithGoogle()),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Google sign-in cancelled'),
      ],
    );
  });

  group('AuthBloc - SignInWithApple', () {
    final testUser = UserModel(
      uid: 'apple_uid_123',
      email: 'test@icloud.com',
      displayName: 'Apple User',
      role: 'buyer',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when Apple sign-in succeeds',
      build: () {
        when(() => mockRepository.signInWithApple())
            .thenAnswer((_) async => Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.signInWithApple()),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: testUser),
      ],
    );
  });

  group('AuthBloc - SignOut', () {
    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] when sign-out succeeds',
      build: () {
        when(() => mockRepository.signOut())
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.signOut()),
      expect: () => [
        const AuthState.unauthenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] even when sign-out fails',
      build: () {
        when(() => mockRepository.signOut()).thenAnswer(
          (_) async => const Left(AuthFailure(message: 'Sign-out failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.signOut()),
      expect: () => [
        const AuthState.unauthenticated(),
      ],
    );
  });

  group('AuthBloc - SendPasswordReset', () {
    const testEmail = 'test@example.com';

    blocTest<AuthBloc, AuthState>(
      'emits [loading, passwordResetSent] when password reset email sent',
      build: () {
        when(() => mockRepository.sendPasswordResetEmail(testEmail))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.sendPasswordReset(email: testEmail),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.passwordResetSent(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when password reset fails',
      build: () {
        when(() => mockRepository.sendPasswordResetEmail(testEmail)).thenAnswer(
          (_) async => const Left(AuthFailure(message: 'User not found')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const AuthEvent.sendPasswordReset(email: testEmail),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'User not found'),
      ],
    );
  });

  group('AuthBloc - UpdateRole', () {
    const testRole = 'agent';
    final testUser = UserModel(
      uid: 'test_uid_123',
      email: 'test@example.com',
      displayName: 'Test User',
      role: null,
    );
    final updatedUser = testUser.copyWith(role: testRole, isNewUser: false);

    blocTest<AuthBloc, AuthState>(
      'emits [authenticated] with updated role',
      build: () {
        when(() => mockRepository.updateUserRole(testUser.uid, testRole))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () => AuthState.authenticated(user: testUser),
      act: (bloc) => bloc.add(const AuthEvent.updateRole(role: testRole)),
      expect: () => [
        AuthState.authenticated(user: updatedUser),
      ],
    );
  });

  group('AuthBloc - CheckRequested', () {
    final testUser = UserModel(
      uid: 'test_uid_123',
      email: 'test@example.com',
      displayName: 'Test User',
      role: 'buyer',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when user exists in stream',
      build: () {
        when(() => mockRepository.authStateChanges)
            .thenAnswer((_) => Stream.value(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.checkRequested()),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when no user in stream',
      build: () {
        when(() => mockRepository.authStateChanges)
            .thenAnswer((_) => Stream.value(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.checkRequested()),
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ],
    );
  });
}
