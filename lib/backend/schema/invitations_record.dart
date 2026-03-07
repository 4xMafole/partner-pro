import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationsRecord extends FirestoreRecord {
  InvitationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "invitations" field.
  InvitationTypeStruct? _invitations;
  InvitationTypeStruct get invitations =>
      _invitations ?? InvitationTypeStruct();
  bool hasInvitations() => _invitations != null;

  void _initializeFields() {
    _invitations = snapshotData['invitations'] is InvitationTypeStruct
        ? snapshotData['invitations']
        : InvitationTypeStruct.maybeFromMap(snapshotData['invitations']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invitations');

  static Stream<InvitationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvitationsRecord.fromSnapshot(s));

  static Future<InvitationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InvitationsRecord.fromSnapshot(s));

  static InvitationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvitationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvitationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvitationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvitationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvitationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInvitationsRecordData({
  InvitationTypeStruct? invitations,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'invitations': InvitationTypeStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "invitations" field.
  addInvitationTypeStructData(firestoreData, invitations, 'invitations');

  return firestoreData;
}

class InvitationsRecordDocumentEquality implements Equality<InvitationsRecord> {
  const InvitationsRecordDocumentEquality();

  @override
  bool equals(InvitationsRecord? e1, InvitationsRecord? e2) {
    return e1?.invitations == e2?.invitations;
  }

  @override
  int hash(InvitationsRecord? e) => const ListEquality().hash([e?.invitations]);

  @override
  bool isValidKey(Object? o) => o is InvitationsRecord;
}
