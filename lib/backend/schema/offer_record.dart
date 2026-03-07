import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OfferRecord extends FirestoreRecord {
  OfferRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "property" field.
  PropertyStruct? _property;
  PropertyStruct get property => _property ?? PropertyStruct();
  bool hasProperty() => _property != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_time" field.
  String? _createdTime;
  String get createdTime => _createdTime ?? '';
  bool hasCreatedTime() => _createdTime != null;

  // "closing_date" field.
  String? _closingDate;
  String get closingDate => _closingDate ?? '';
  bool hasClosingDate() => _closingDate != null;

  // "pricing" field.
  PricingStruct? _pricing;
  PricingStruct get pricing => _pricing ?? PricingStruct();
  bool hasPricing() => _pricing != null;

  // "parties" field.
  PartiesStruct? _parties;
  PartiesStruct get parties => _parties ?? PartiesStruct();
  bool hasParties() => _parties != null;

  // "financials" field.
  FinancialsStruct? _financials;
  FinancialsStruct get financials => _financials ?? FinancialsStruct();
  bool hasFinancials() => _financials != null;

  // "conditions" field.
  ConditionsStruct? _conditions;
  ConditionsStruct get conditions => _conditions ?? ConditionsStruct();
  bool hasConditions() => _conditions != null;

  // "title_company" field.
  NewTitleCompanyStruct? _titleCompany;
  NewTitleCompanyStruct get titleCompany =>
      _titleCompany ?? NewTitleCompanyStruct();
  bool hasTitleCompany() => _titleCompany != null;

  // "addendums" field.
  NewAddendumsStruct? _addendums;
  NewAddendumsStruct get addendums => _addendums ?? NewAddendumsStruct();
  bool hasAddendums() => _addendums != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _property = snapshotData['property'] is PropertyStruct
        ? snapshotData['property']
        : PropertyStruct.maybeFromMap(snapshotData['property']);
    _status = snapshotData['status'] as String?;
    _createdTime = snapshotData['created_time'] as String?;
    _closingDate = snapshotData['closing_date'] as String?;
    _pricing = snapshotData['pricing'] is PricingStruct
        ? snapshotData['pricing']
        : PricingStruct.maybeFromMap(snapshotData['pricing']);
    _parties = snapshotData['parties'] is PartiesStruct
        ? snapshotData['parties']
        : PartiesStruct.maybeFromMap(snapshotData['parties']);
    _financials = snapshotData['financials'] is FinancialsStruct
        ? snapshotData['financials']
        : FinancialsStruct.maybeFromMap(snapshotData['financials']);
    _conditions = snapshotData['conditions'] is ConditionsStruct
        ? snapshotData['conditions']
        : ConditionsStruct.maybeFromMap(snapshotData['conditions']);
    _titleCompany = snapshotData['title_company'] is NewTitleCompanyStruct
        ? snapshotData['title_company']
        : NewTitleCompanyStruct.maybeFromMap(snapshotData['title_company']);
    _addendums = snapshotData['addendums'] is NewAddendumsStruct
        ? snapshotData['addendums']
        : NewAddendumsStruct.maybeFromMap(snapshotData['addendums']);
    _id = snapshotData['id'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('offer')
          : FirebaseFirestore.instance.collectionGroup('offer');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('offer').doc(id);

  static Stream<OfferRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OfferRecord.fromSnapshot(s));

  static Future<OfferRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OfferRecord.fromSnapshot(s));

  static OfferRecord fromSnapshot(DocumentSnapshot snapshot) => OfferRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OfferRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OfferRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OfferRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OfferRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOfferRecordData({
  PropertyStruct? property,
  String? status,
  String? createdTime,
  String? closingDate,
  PricingStruct? pricing,
  PartiesStruct? parties,
  FinancialsStruct? financials,
  ConditionsStruct? conditions,
  NewTitleCompanyStruct? titleCompany,
  NewAddendumsStruct? addendums,
  String? id,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'property': PropertyStruct().toMap(),
      'status': status,
      'created_time': createdTime,
      'closing_date': closingDate,
      'pricing': PricingStruct().toMap(),
      'parties': PartiesStruct().toMap(),
      'financials': FinancialsStruct().toMap(),
      'conditions': ConditionsStruct().toMap(),
      'title_company': NewTitleCompanyStruct().toMap(),
      'addendums': NewAddendumsStruct().toMap(),
      'id': id,
    }.withoutNulls,
  );

  // Handle nested data for "property" field.
  addPropertyStructData(firestoreData, property, 'property');

  // Handle nested data for "pricing" field.
  addPricingStructData(firestoreData, pricing, 'pricing');

  // Handle nested data for "parties" field.
  addPartiesStructData(firestoreData, parties, 'parties');

  // Handle nested data for "financials" field.
  addFinancialsStructData(firestoreData, financials, 'financials');

  // Handle nested data for "conditions" field.
  addConditionsStructData(firestoreData, conditions, 'conditions');

  // Handle nested data for "title_company" field.
  addNewTitleCompanyStructData(firestoreData, titleCompany, 'title_company');

  // Handle nested data for "addendums" field.
  addNewAddendumsStructData(firestoreData, addendums, 'addendums');

  return firestoreData;
}

class OfferRecordDocumentEquality implements Equality<OfferRecord> {
  const OfferRecordDocumentEquality();

  @override
  bool equals(OfferRecord? e1, OfferRecord? e2) {
    return e1?.property == e2?.property &&
        e1?.status == e2?.status &&
        e1?.createdTime == e2?.createdTime &&
        e1?.closingDate == e2?.closingDate &&
        e1?.pricing == e2?.pricing &&
        e1?.parties == e2?.parties &&
        e1?.financials == e2?.financials &&
        e1?.conditions == e2?.conditions &&
        e1?.titleCompany == e2?.titleCompany &&
        e1?.addendums == e2?.addendums &&
        e1?.id == e2?.id;
  }

  @override
  int hash(OfferRecord? e) => const ListEquality().hash([
        e?.property,
        e?.status,
        e?.createdTime,
        e?.closingDate,
        e?.pricing,
        e?.parties,
        e?.financials,
        e?.conditions,
        e?.titleCompany,
        e?.addendums,
        e?.id
      ]);

  @override
  bool isValidKey(Object? o) => o is OfferRecord;
}
