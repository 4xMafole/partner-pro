import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShowamiRecord extends FirestoreRecord {
  ShowamiRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "showami" field.
  ShowamiStruct? _showami;
  ShowamiStruct get showami => _showami ?? ShowamiStruct();
  bool hasShowami() => _showami != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _showami = snapshotData['showami'] is ShowamiStruct
        ? snapshotData['showami']
        : ShowamiStruct.maybeFromMap(snapshotData['showami']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('showami')
          : FirebaseFirestore.instance.collectionGroup('showami');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('showami').doc(id);

  static Stream<ShowamiRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ShowamiRecord.fromSnapshot(s));

  static Future<ShowamiRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ShowamiRecord.fromSnapshot(s));

  static ShowamiRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ShowamiRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ShowamiRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ShowamiRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ShowamiRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ShowamiRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createShowamiRecordData({
  ShowamiStruct? showami,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'showami': ShowamiStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "showami" field.
  addShowamiStructData(firestoreData, showami, 'showami');

  return firestoreData;
}

class ShowamiRecordDocumentEquality implements Equality<ShowamiRecord> {
  const ShowamiRecordDocumentEquality();

  @override
  bool equals(ShowamiRecord? e1, ShowamiRecord? e2) {
    return e1?.showami == e2?.showami;
  }

  @override
  int hash(ShowamiRecord? e) => const ListEquality().hash([e?.showami]);

  @override
  bool isValidKey(Object? o) => o is ShowamiRecord;
}
