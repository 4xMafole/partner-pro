import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionsRecord extends FirestoreRecord {
  SubscriptionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created" field.
  DateTime? _created;
  DateTime? get created => _created;
  bool hasCreated() => _created != null;

  // "current_period_end" field.
  DateTime? _currentPeriodEnd;
  DateTime? get currentPeriodEnd => _currentPeriodEnd;
  bool hasCurrentPeriodEnd() => _currentPeriodEnd != null;

  // "items" field.
  List<SubscriptionItemStruct>? _items;
  List<SubscriptionItemStruct> get items => _items ?? const [];
  bool hasItems() => _items != null;

  // "current_period_start" field.
  DateTime? _currentPeriodStart;
  DateTime? get currentPeriodStart => _currentPeriodStart;
  bool hasCurrentPeriodStart() => _currentPeriodStart != null;

  // "cancel_at_period_end" field.
  bool? _cancelAtPeriodEnd;
  bool get cancelAtPeriodEnd => _cancelAtPeriodEnd ?? false;
  bool hasCancelAtPeriodEnd() => _cancelAtPeriodEnd != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _status = snapshotData['status'] as String?;
    _created = snapshotData['created'] as DateTime?;
    _currentPeriodEnd = snapshotData['current_period_end'] as DateTime?;
    _items = getStructList(
      snapshotData['items'],
      SubscriptionItemStruct.fromMap,
    );
    _currentPeriodStart = snapshotData['current_period_start'] as DateTime?;
    _cancelAtPeriodEnd = snapshotData['cancel_at_period_end'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('subscriptions')
          : FirebaseFirestore.instance.collectionGroup('subscriptions');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('subscriptions').doc(id);

  static Stream<SubscriptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionsRecord.fromSnapshot(s));

  static Future<SubscriptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubscriptionsRecord.fromSnapshot(s));

  static SubscriptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubscriptionsRecordData({
  String? status,
  DateTime? created,
  DateTime? currentPeriodEnd,
  DateTime? currentPeriodStart,
  bool? cancelAtPeriodEnd,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'status': status,
      'created': created,
      'current_period_end': currentPeriodEnd,
      'current_period_start': currentPeriodStart,
      'cancel_at_period_end': cancelAtPeriodEnd,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionsRecordDocumentEquality
    implements Equality<SubscriptionsRecord> {
  const SubscriptionsRecordDocumentEquality();

  @override
  bool equals(SubscriptionsRecord? e1, SubscriptionsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.status == e2?.status &&
        e1?.created == e2?.created &&
        e1?.currentPeriodEnd == e2?.currentPeriodEnd &&
        listEquality.equals(e1?.items, e2?.items) &&
        e1?.currentPeriodStart == e2?.currentPeriodStart &&
        e1?.cancelAtPeriodEnd == e2?.cancelAtPeriodEnd;
  }

  @override
  int hash(SubscriptionsRecord? e) => const ListEquality().hash([
        e?.status,
        e?.created,
        e?.currentPeriodEnd,
        e?.items,
        e?.currentPeriodStart,
        e?.cancelAtPeriodEnd
      ]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionsRecord;
}
