import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RelationshipsRecord extends FirestoreRecord {
  RelationshipsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "relationship" field.
  RelationshipTypeStruct? _relationship;
  RelationshipTypeStruct get relationship =>
      _relationship ?? RelationshipTypeStruct();
  bool hasRelationship() => _relationship != null;

  void _initializeFields() {
    _relationship = snapshotData['relationship'] is RelationshipTypeStruct
        ? snapshotData['relationship']
        : RelationshipTypeStruct.maybeFromMap(snapshotData['relationship']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('relationships');

  static Stream<RelationshipsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RelationshipsRecord.fromSnapshot(s));

  static Future<RelationshipsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RelationshipsRecord.fromSnapshot(s));

  static RelationshipsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RelationshipsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RelationshipsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RelationshipsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RelationshipsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RelationshipsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRelationshipsRecordData({
  RelationshipTypeStruct? relationship,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'relationship': RelationshipTypeStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "relationship" field.
  addRelationshipTypeStructData(firestoreData, relationship, 'relationship');

  return firestoreData;
}

class RelationshipsRecordDocumentEquality
    implements Equality<RelationshipsRecord> {
  const RelationshipsRecordDocumentEquality();

  @override
  bool equals(RelationshipsRecord? e1, RelationshipsRecord? e2) {
    return e1?.relationship == e2?.relationship;
  }

  @override
  int hash(RelationshipsRecord? e) =>
      const ListEquality().hash([e?.relationship]);

  @override
  bool isValidKey(Object? o) => o is RelationshipsRecord;
}
