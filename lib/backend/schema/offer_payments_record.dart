import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OfferPaymentsRecord extends FirestoreRecord {
  OfferPaymentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "propertyID" field.
  String? _propertyID;
  String get propertyID => _propertyID ?? '';
  bool hasPropertyID() => _propertyID != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "paymentID" field.
  String? _paymentID;
  String get paymentID => _paymentID ?? '';
  bool hasPaymentID() => _paymentID != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _propertyID = snapshotData['propertyID'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _paymentID = snapshotData['paymentID'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('offer_payments');

  static Stream<OfferPaymentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OfferPaymentsRecord.fromSnapshot(s));

  static Future<OfferPaymentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OfferPaymentsRecord.fromSnapshot(s));

  static OfferPaymentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OfferPaymentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OfferPaymentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OfferPaymentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OfferPaymentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OfferPaymentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOfferPaymentsRecordData({
  DocumentReference? userRef,
  String? propertyID,
  DateTime? createdAt,
  String? paymentID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'propertyID': propertyID,
      'created_at': createdAt,
      'paymentID': paymentID,
    }.withoutNulls,
  );

  return firestoreData;
}

class OfferPaymentsRecordDocumentEquality
    implements Equality<OfferPaymentsRecord> {
  const OfferPaymentsRecordDocumentEquality();

  @override
  bool equals(OfferPaymentsRecord? e1, OfferPaymentsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.propertyID == e2?.propertyID &&
        e1?.createdAt == e2?.createdAt &&
        e1?.paymentID == e2?.paymentID;
  }

  @override
  int hash(OfferPaymentsRecord? e) => const ListEquality()
      .hash([e?.userRef, e?.propertyID, e?.createdAt, e?.paymentID]);

  @override
  bool isValidKey(Object? o) => o is OfferPaymentsRecord;
}
