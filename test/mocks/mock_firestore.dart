/// Mock implementations for Cloud Firestore
///
/// Provides mock classes for testing Firestore functionality
/// without requiring actual Firestore connections.
/// Uses Fake pattern to avoid nested when() issues with mocktail.
library;

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

//
// Mock Firestore
//

class MockFirebaseFirestore extends Fake implements FirebaseFirestore {
  final Map<String, Map<String, Map<String, dynamic>>> _store = {};

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    _store[collectionPath] ??= {};
    return FakeCollectionReference(collectionPath, this);
  }

  void addDocument(
      String collectionPath, String docId, Map<String, dynamic> data) {
    _store[collectionPath] ??= {};
    _store[collectionPath]![docId] = Map<String, dynamic>.from(data);
  }

  Map<String, dynamic>? getDocument(String collectionPath, String docId) {
    return _store[collectionPath]?[docId];
  }

  void removeDocument(String collectionPath, String docId) {
    _store[collectionPath]?.remove(docId);
  }

  void clear() {
    _store.clear();
  }
}

//
// Fake Collection Reference
//

class FakeCollectionReference extends Fake
    implements CollectionReference<Map<String, dynamic>> {
  @override
  final String path;
  final MockFirebaseFirestore _firestore;

  FakeCollectionReference(this.path, this._firestore);

  @override
  DocumentReference<Map<String, dynamic>> doc([String? docPath]) {
    return FakeDocumentReference(
        '$path/$docPath', docPath ?? '', path, _firestore);
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> add(
      Map<String, dynamic> data) async {
    final docId = DateTime.now().millisecondsSinceEpoch.toString();
    _firestore.addDocument(path, docId, data);
    return FakeDocumentReference('$path/$docId', docId, path, _firestore);
  }
}

//
// Fake Document Reference
//

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {
  @override
  final String path;
  @override
  final String id;
  final String _collectionPath;
  final MockFirebaseFirestore _firestore;

  FakeDocumentReference(
      this.path, this.id, this._collectionPath, this._firestore);

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get(
      [GetOptions? options]) async {
    final data = _firestore.getDocument(_collectionPath, id);
    return FakeDocumentSnapshot(id, data, data != null);
  }

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) async {
    _firestore.addDocument(_collectionPath, id, data);
  }

  @override
  Future<void> update(Map<Object, Object?> data) async {
    final existing = _firestore.getDocument(_collectionPath, id) ?? {};
    final updates = data.map((k, v) => MapEntry(k.toString(), v));
    _firestore.addDocument(_collectionPath, id, {...existing, ...updates});
  }

  @override
  Future<void> delete() async {
    _firestore.removeDocument(_collectionPath, id);
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
    ListenSource source = ListenSource.defaultSource,
  }) {
    final data = _firestore.getDocument(_collectionPath, id);
    return Stream.value(FakeDocumentSnapshot(id, data, data != null));
  }
}

//
// Fake Document Snapshot
//

class FakeDocumentSnapshot extends Fake
    implements DocumentSnapshot<Map<String, dynamic>> {
  @override
  final String id;
  final Map<String, dynamic>? _data;
  final bool _exists;

  FakeDocumentSnapshot(this.id, this._data, this._exists);

  @override
  bool get exists => _exists;

  @override
  Map<String, dynamic>? data() => _data;

  @override
  dynamic get(Object field) {
    if (_data != null && field is String) {
      return _data[field];
    }
    return null;
  }
}

//
// Factory Methods
//

/// Creates a Firestore instance with pre-populated test data
MockFirebaseFirestore createTestFirestore({
  Map<String, Map<String, Map<String, dynamic>>>? initialData,
}) {
  final firestore = MockFirebaseFirestore();

  if (initialData != null) {
    initialData.forEach((collectionPath, documents) {
      documents.forEach((docId, data) {
        firestore.addDocument(collectionPath, docId, data);
      });
    });
  }

  return firestore;
}

/// Creates test user document data
Map<String, dynamic> createTestUserData({
  String uid = 'test_user_123',
  String email = 'test@example.com',
  String displayName = 'Test User',
  String? photoUrl,
  String? phoneNumber,
  String role = 'buyer',
}) {
  return {
    'uid': uid,
    'email': email,
    'display_name': displayName,
    if (photoUrl != null) 'photo_url': photoUrl,
    if (phoneNumber != null) 'phone_number': phoneNumber,
    'role': role,
    'created_time': Timestamp.now(),
  };
}
