import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavoritesRecord extends FirestoreRecord {
  FavoritesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "property_data" field.
  PropertyDataClassStruct? _propertyData;
  PropertyDataClassStruct get propertyData =>
      _propertyData ?? PropertyDataClassStruct();
  bool hasPropertyData() => _propertyData != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "is_deleted_by_user" field.
  bool? _isDeletedByUser;
  bool get isDeletedByUser => _isDeletedByUser ?? false;
  bool hasIsDeletedByUser() => _isDeletedByUser != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _propertyData = snapshotData['property_data'] is PropertyDataClassStruct
        ? snapshotData['property_data']
        : PropertyDataClassStruct.maybeFromMap(snapshotData['property_data']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _isDeletedByUser = snapshotData['is_deleted_by_user'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('favorites')
          : FirebaseFirestore.instance.collectionGroup('favorites');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('favorites').doc(id);

  static Stream<FavoritesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FavoritesRecord.fromSnapshot(s));

  static Future<FavoritesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FavoritesRecord.fromSnapshot(s));

  static FavoritesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FavoritesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FavoritesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FavoritesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FavoritesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FavoritesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFavoritesRecordData({
  String? id,
  PropertyDataClassStruct? propertyData,
  DateTime? createdAt,
  bool? isDeletedByUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'property_data': PropertyDataClassStruct().toMap(),
      'created_at': createdAt,
      'is_deleted_by_user': isDeletedByUser,
    }.withoutNulls,
  );

  // Handle nested data for "property_data" field.
  addPropertyDataClassStructData(firestoreData, propertyData, 'property_data');

  return firestoreData;
}

class FavoritesRecordDocumentEquality implements Equality<FavoritesRecord> {
  const FavoritesRecordDocumentEquality();

  @override
  bool equals(FavoritesRecord? e1, FavoritesRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.propertyData == e2?.propertyData &&
        e1?.createdAt == e2?.createdAt &&
        e1?.isDeletedByUser == e2?.isDeletedByUser;
  }

  @override
  int hash(FavoritesRecord? e) => const ListEquality()
      .hash([e?.id, e?.propertyData, e?.createdAt, e?.isDeletedByUser]);

  @override
  bool isValidKey(Object? o) => o is FavoritesRecord;
}
