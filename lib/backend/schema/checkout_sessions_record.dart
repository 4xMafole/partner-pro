import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckoutSessionsRecord extends FirestoreRecord {
  CheckoutSessionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  bool hasPrice() => _price != null;

  // "success_url" field.
  String? _successUrl;
  String get successUrl => _successUrl ?? '';
  bool hasSuccessUrl() => _successUrl != null;

  // "cancel_url" field.
  String? _cancelUrl;
  String get cancelUrl => _cancelUrl ?? '';
  bool hasCancelUrl() => _cancelUrl != null;

  // "client" field.
  String? _client;
  String get client => _client ?? '';
  bool hasClient() => _client != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _price = snapshotData['price'] as String?;
    _successUrl = snapshotData['success_url'] as String?;
    _cancelUrl = snapshotData['cancel_url'] as String?;
    _client = snapshotData['client'] as String?;
    _status = snapshotData['status'] as String?;
    _url = snapshotData['url'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('checkout_sessions')
          : FirebaseFirestore.instance.collectionGroup('checkout_sessions');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('checkout_sessions').doc(id);

  static Stream<CheckoutSessionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckoutSessionsRecord.fromSnapshot(s));

  static Future<CheckoutSessionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => CheckoutSessionsRecord.fromSnapshot(s));

  static CheckoutSessionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckoutSessionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CheckoutSessionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CheckoutSessionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CheckoutSessionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckoutSessionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCheckoutSessionsRecordData({
  String? price,
  String? successUrl,
  String? cancelUrl,
  String? client,
  String? status,
  String? url,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'price': price,
      'success_url': successUrl,
      'cancel_url': cancelUrl,
      'client': client,
      'status': status,
      'url': url,
    }.withoutNulls,
  );

  return firestoreData;
}

class CheckoutSessionsRecordDocumentEquality
    implements Equality<CheckoutSessionsRecord> {
  const CheckoutSessionsRecordDocumentEquality();

  @override
  bool equals(CheckoutSessionsRecord? e1, CheckoutSessionsRecord? e2) {
    return e1?.price == e2?.price &&
        e1?.successUrl == e2?.successUrl &&
        e1?.cancelUrl == e2?.cancelUrl &&
        e1?.client == e2?.client &&
        e1?.status == e2?.status &&
        e1?.url == e2?.url;
  }

  @override
  int hash(CheckoutSessionsRecord? e) => const ListEquality().hash(
      [e?.price, e?.successUrl, e?.cancelUrl, e?.client, e?.status, e?.url]);

  @override
  bool isValidKey(Object? o) => o is CheckoutSessionsRecord;
}
