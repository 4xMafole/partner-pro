/// Mock implementations for Firebase Authentication
///
/// Provides mock classes for testing Firebase Auth functionality
/// without requiring actual Firebase connections.
library;

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:mocktail/mocktail.dart';

class FakeAuthCredential extends Fake implements fb.AuthCredential {}

/// Call this in setUpAll to register fallback values for mocktail
void registerAuthFallbackValues() {
  registerFallbackValue(FakeAuthCredential());
}

// ══════════════════════════════════════════════════════════════════════════════
// Mock Firebase Auth
// ══════════════════════════════════════════════════════════════════════════════

class MockFirebaseAuth extends Mock implements fb.FirebaseAuth {
  final StreamController<fb.User?> _authStateController =
      StreamController<fb.User?>.broadcast();
  final StreamController<fb.User?> _userChangesController =
      StreamController<fb.User?>.broadcast();
  final StreamController<fb.User?> _idTokenController =
      StreamController<fb.User?>.broadcast();

  fb.User? _currentUser;

  MockFirebaseAuth({fb.User? currentUser}) : _currentUser = currentUser {
    when(() => this.currentUser).thenAnswer((_) => _currentUser);
    when(() => authStateChanges())
        .thenAnswer((_) => _authStateController.stream);
    when(() => userChanges()).thenAnswer((_) => _userChangesController.stream);
    when(() => idTokenChanges()).thenAnswer((_) => _idTokenController.stream);
  }

  /// Simulates user sign-in
  void signInUser(fb.User user) {
    _currentUser = user;
    _authStateController.add(user);
    _userChangesController.add(user);
    _idTokenController.add(user);
  }

  /// Simulates user sign-out
  void signOutUser() {
    _currentUser = null;
    _authStateController.add(null);
    _userChangesController.add(null);
    _idTokenController.add(null);
  }

  /// Dispose streams
  void dispose() {
    _authStateController.close();
    _userChangesController.close();
    _idTokenController.close();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Mock User Credential
// ══════════════════════════════════════════════════════════════════════════════

class MockUserCredential extends Mock implements fb.UserCredential {
  MockUserCredential({
    required fb.User user,
    fb.AdditionalUserInfo? additionalUserInfo,
  }) {
    when(() => this.user).thenReturn(user);
    when(() => this.additionalUserInfo).thenReturn(additionalUserInfo);
    when(() => credential).thenReturn(null);
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Mock Firebase User
// ══════════════════════════════════════════════════════════════════════════════

class MockFirebaseUser extends Mock implements fb.User {
  MockFirebaseUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    bool emailVerified = false,
    bool isAnonymous = false,
  }) {
    // Create nested mocks first to avoid nested when() calls
    final mockMetadata = MockUserMetadata();
    final mockIdTokenResult = MockIdTokenResult();

    when(() => this.uid).thenReturn(uid);
    when(() => this.email).thenReturn(email);
    when(() => this.displayName).thenReturn(displayName);
    when(() => this.photoURL).thenReturn(photoURL);
    when(() => this.phoneNumber).thenReturn(phoneNumber);
    when(() => this.emailVerified).thenReturn(emailVerified);
    when(() => this.isAnonymous).thenReturn(isAnonymous);
    when(() => metadata).thenReturn(mockMetadata);
    when(() => providerData).thenReturn([]);
    when(() => refreshToken).thenReturn('mock_refresh_token');
    when(() => tenantId).thenReturn(null);

    // Setup common methods
    when(() => delete()).thenAnswer((_) async {});
    when(() => reload()).thenAnswer((_) async {});
    when(() => getIdToken(any())).thenAnswer((_) async => 'mock_id_token');
    when(() => getIdTokenResult(any()))
        .thenAnswer((_) async => mockIdTokenResult);
    when(() => sendEmailVerification()).thenAnswer((_) async {});
    when(() => updateEmail(any())).thenAnswer((_) async {});
    when(() => updatePassword(any())).thenAnswer((_) async {});
    when(() => updateProfile(
          displayName: any(named: 'displayName'),
          photoURL: any(named: 'photoURL'),
        )).thenAnswer((_) async {});
    when(() => verifyBeforeUpdateEmail(any())).thenAnswer((_) async {});
    when(() => reauthenticateWithCredential(any()))
        .thenAnswer((_) async => MockUserCredential(user: this));
    when(() => linkWithCredential(any()))
        .thenAnswer((_) async => MockUserCredential(user: this));
    when(() => unlink(any())).thenAnswer((_) async => this);
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Supporting Mock Classes
// ══════════════════════════════════════════════════════════════════════════════

class MockUserMetadata extends Mock implements fb.UserMetadata {
  MockUserMetadata() {
    when(() => creationTime).thenReturn(DateTime.now());
    when(() => lastSignInTime).thenReturn(DateTime.now());
  }
}

class MockIdTokenResult extends Mock implements fb.IdTokenResult {
  MockIdTokenResult() {
    when(() => token).thenReturn('mock_id_token');
    when(() => expirationTime)
        .thenReturn(DateTime.now().add(const Duration(hours: 1)));
    when(() => authTime).thenReturn(DateTime.now());
    when(() => issuedAtTime).thenReturn(DateTime.now());
    when(() => signInProvider).thenReturn('password');
    when(() => claims).thenReturn({});
  }
}

class MockAuthCredential extends Mock implements fb.AuthCredential {
  MockAuthCredential() {
    when(() => providerId).thenReturn('password');
    when(() => signInMethod).thenReturn('password');
  }
}

class MockConfirmationResult extends Mock implements fb.ConfirmationResult {
  MockConfirmationResult({required String verificationId}) {
    when(() => this.verificationId).thenReturn(verificationId);
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Factory Methods
// ══════════════════════════════════════════════════════════════════════════════

/// Creates a standard test user
fb.User createTestUser({
  String uid = 'test_user_123',
  String email = 'test@example.com',
  String displayName = 'Test User',
  bool emailVerified = true,
}) {
  return MockFirebaseUser(
    uid: uid,
    email: email,
    displayName: displayName,
    emailVerified: emailVerified,
  );
}

/// Creates a test user credential
fb.UserCredential createTestUserCredential({
  String uid = 'test_user_123',
  String email = 'test@example.com',
  String displayName = 'Test User',
}) {
  final user = createTestUser(
    uid: uid,
    email: email,
    displayName: displayName,
  );
  return MockUserCredential(user: user);
}

// ══════════════════════════════════════════════════════════════════════════════
// Helper Functions
// ══════════════════════════════════════════════════════════════════════════════

/// Simulates a Firebase Auth exception
fb.FirebaseAuthException createAuthException({
  required String code,
  String? message,
}) {
  return fb.FirebaseAuthException(
    code: code,
    message: message,
  );
}
