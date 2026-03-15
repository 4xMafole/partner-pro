/// Test helpers and utilities for PartnerPro tests
///
/// Provides common mocks, builders, and utilities used across test files.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';

// ══════════════════════════════════════════════════════════════════════════════
// Mock Classes
// ══════════════════════════════════════════════════════════════════════════════

class MockFirebaseAuth extends Mock implements fb.FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredential extends Mock implements fb.UserCredential {}

class MockUser extends Mock implements fb.User {}

class MockCollectionReference<T> extends Mock
    implements CollectionReference<T> {}

class MockDocumentReference<T> extends Mock implements DocumentReference<T> {}

class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}

class MockQuerySnapshot<T> extends Mock implements QuerySnapshot<T> {}

class MockBuildContext extends Mock implements BuildContext {}

// ══════════════════════════════════════════════════════════════════════════════
// Test Data Builders
// ══════════════════════════════════════════════════════════════════════════════

/// Creates a mock Firebase User with default test data
MockUser createMockUser({
  String uid = 'test_uid_123',
  String email = 'test@example.com',
  String displayName = 'Test User',
  String? photoURL,
  String? phoneNumber,
  bool emailVerified = true,
}) {
  final user = MockUser();
  when(() => user.uid).thenReturn(uid);
  when(() => user.email).thenReturn(email);
  when(() => user.displayName).thenReturn(displayName);
  when(() => user.photoURL).thenReturn(photoURL);
  when(() => user.phoneNumber).thenReturn(phoneNumber);
  when(() => user.emailVerified).thenReturn(emailVerified);
  when(() => user.delete()).thenAnswer((_) async => {});
  when(() => user.updateEmail(any())).thenAnswer((_) async => {});
  when(() => user.updatePassword(any())).thenAnswer((_) async => {});
  when(() => user.sendEmailVerification()).thenAnswer((_) async => {});
  when(() => user.reload()).thenAnswer((_) async => {});
  return user;
}

/// Creates a mock UserCredential with a mock User
MockUserCredential createMockUserCredential({
  String uid = 'test_uid_123',
  String email = 'test@example.com',
  String displayName = 'Test User',
}) {
  final userCred = MockUserCredential();
  final user = createMockUser(
    uid: uid,
    email: email,
    displayName: displayName,
  );
  when(() => userCred.user).thenReturn(user);
  return userCred;
}

// ══════════════════════════════════════════════════════════════════════════════
// Test Utilities
// ══════════════════════════════════════════════════════════════════════════════

/// Pumps a widget with MaterialApp wrapper for testing
Future<void> pumpTestWidget(
  WidgetTester tester,
  Widget widget, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(body: widget),
    ),
  );
}

/// Waits for all pending timers and microtasks
Future<void> pumpAndSettleAll(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 100));
}

/// Finds a widget by text and taps it
Future<void> tapByText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

/// Finds a widget by key and taps it
Future<void> tapByKey(WidgetTester tester, Key key) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

/// Enters text into a TextField by key
Future<void> enterText(
  WidgetTester tester,
  Key key,
  String text,
) async {
  await tester.enterText(find.byKey(key), text);
  await tester.pump();
}

// ══════════════════════════════════════════════════════════════════════════════
// Matchers
// ══════════════════════════════════════════════════════════════════════════════

/// Finds a SnackBar with specific text
Finder findSnackBarWithText(String text) {
  return find.descendant(
    of: find.byType(SnackBar),
    matching: find.text(text),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// Setup/Teardown Helpers
// ══════════════════════════════════════════════════════════════════════════════

/// Registers fallback values for mocktail
void registerFallbackValues() {
  registerFallbackValue(MockBuildContext());
  registerFallbackValue(const Duration(seconds: 0));
}
