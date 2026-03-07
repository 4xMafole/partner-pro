// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewOfferStruct extends FFFirebaseStruct {
  NewOfferStruct({
    String? id,
    String? status,
    String? createdTime,
    String? closingDate,
    PropertyDataClassStruct? property,
    PricingStruct? pricing,
    PartiesStruct? parties,
    FinancialsStruct? financials,
    ConditionsStruct? conditions,
    NewTitleCompanyStruct? titleCompany,
    List<NewAddendumsStruct>? addendums,
    List<UserFileStruct>? documents,
    bool? agentApproved,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _status = status,
        _createdTime = createdTime,
        _closingDate = closingDate,
        _property = property,
        _pricing = pricing,
        _parties = parties,
        _financials = financials,
        _conditions = conditions,
        _titleCompany = titleCompany,
        _addendums = addendums,
        _documents = documents,
        _agentApproved = agentApproved,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "created_time" field.
  String? _createdTime;
  String get createdTime => _createdTime ?? '';
  set createdTime(String? val) => _createdTime = val;

  bool hasCreatedTime() => _createdTime != null;

  // "closing_date" field.
  String? _closingDate;
  String get closingDate => _closingDate ?? '';
  set closingDate(String? val) => _closingDate = val;

  bool hasClosingDate() => _closingDate != null;

  // "property" field.
  PropertyDataClassStruct? _property;
  PropertyDataClassStruct get property =>
      _property ?? PropertyDataClassStruct();
  set property(PropertyDataClassStruct? val) => _property = val;

  void updateProperty(Function(PropertyDataClassStruct) updateFn) {
    updateFn(_property ??= PropertyDataClassStruct());
  }

  bool hasProperty() => _property != null;

  // "pricing" field.
  PricingStruct? _pricing;
  PricingStruct get pricing => _pricing ?? PricingStruct();
  set pricing(PricingStruct? val) => _pricing = val;

  void updatePricing(Function(PricingStruct) updateFn) {
    updateFn(_pricing ??= PricingStruct());
  }

  bool hasPricing() => _pricing != null;

  // "parties" field.
  PartiesStruct? _parties;
  PartiesStruct get parties => _parties ?? PartiesStruct();
  set parties(PartiesStruct? val) => _parties = val;

  void updateParties(Function(PartiesStruct) updateFn) {
    updateFn(_parties ??= PartiesStruct());
  }

  bool hasParties() => _parties != null;

  // "financials" field.
  FinancialsStruct? _financials;
  FinancialsStruct get financials => _financials ?? FinancialsStruct();
  set financials(FinancialsStruct? val) => _financials = val;

  void updateFinancials(Function(FinancialsStruct) updateFn) {
    updateFn(_financials ??= FinancialsStruct());
  }

  bool hasFinancials() => _financials != null;

  // "conditions" field.
  ConditionsStruct? _conditions;
  ConditionsStruct get conditions => _conditions ?? ConditionsStruct();
  set conditions(ConditionsStruct? val) => _conditions = val;

  void updateConditions(Function(ConditionsStruct) updateFn) {
    updateFn(_conditions ??= ConditionsStruct());
  }

  bool hasConditions() => _conditions != null;

  // "title_company" field.
  NewTitleCompanyStruct? _titleCompany;
  NewTitleCompanyStruct get titleCompany =>
      _titleCompany ?? NewTitleCompanyStruct();
  set titleCompany(NewTitleCompanyStruct? val) => _titleCompany = val;

  void updateTitleCompany(Function(NewTitleCompanyStruct) updateFn) {
    updateFn(_titleCompany ??= NewTitleCompanyStruct());
  }

  bool hasTitleCompany() => _titleCompany != null;

  // "addendums" field.
  List<NewAddendumsStruct>? _addendums;
  List<NewAddendumsStruct> get addendums => _addendums ?? const [];
  set addendums(List<NewAddendumsStruct>? val) => _addendums = val;

  void updateAddendums(Function(List<NewAddendumsStruct>) updateFn) {
    updateFn(_addendums ??= []);
  }

  bool hasAddendums() => _addendums != null;

  // "documents" field.
  List<UserFileStruct>? _documents;
  List<UserFileStruct> get documents => _documents ?? const [];
  set documents(List<UserFileStruct>? val) => _documents = val;

  void updateDocuments(Function(List<UserFileStruct>) updateFn) {
    updateFn(_documents ??= []);
  }

  bool hasDocuments() => _documents != null;

  // "agent_approved" field.
  bool? _agentApproved;
  bool get agentApproved => _agentApproved ?? false;
  set agentApproved(bool? val) => _agentApproved = val;

  bool hasAgentApproved() => _agentApproved != null;

  static NewOfferStruct fromMap(Map<String, dynamic> data) => NewOfferStruct(
        id: data['id'] as String?,
        status: data['status'] as String?,
        createdTime: data['created_time'] as String?,
        closingDate: data['closing_date'] as String?,
        property: data['property'] is PropertyDataClassStruct
            ? data['property']
            : PropertyDataClassStruct.maybeFromMap(data['property']),
        pricing: data['pricing'] is PricingStruct
            ? data['pricing']
            : PricingStruct.maybeFromMap(data['pricing']),
        parties: data['parties'] is PartiesStruct
            ? data['parties']
            : PartiesStruct.maybeFromMap(data['parties']),
        financials: data['financials'] is FinancialsStruct
            ? data['financials']
            : FinancialsStruct.maybeFromMap(data['financials']),
        conditions: data['conditions'] is ConditionsStruct
            ? data['conditions']
            : ConditionsStruct.maybeFromMap(data['conditions']),
        titleCompany: data['title_company'] is NewTitleCompanyStruct
            ? data['title_company']
            : NewTitleCompanyStruct.maybeFromMap(data['title_company']),
        addendums: getStructList(
          data['addendums'],
          NewAddendumsStruct.fromMap,
        ),
        documents: getStructList(
          data['documents'],
          UserFileStruct.fromMap,
        ),
        agentApproved: data['agent_approved'] as bool?,
      );

  static NewOfferStruct? maybeFromMap(dynamic data) =>
      data is Map ? NewOfferStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'status': _status,
        'created_time': _createdTime,
        'closing_date': _closingDate,
        'property': _property?.toMap(),
        'pricing': _pricing?.toMap(),
        'parties': _parties?.toMap(),
        'financials': _financials?.toMap(),
        'conditions': _conditions?.toMap(),
        'title_company': _titleCompany?.toMap(),
        'addendums': _addendums?.map((e) => e.toMap()).toList(),
        'documents': _documents?.map((e) => e.toMap()).toList(),
        'agent_approved': _agentApproved,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'created_time': serializeParam(
          _createdTime,
          ParamType.String,
        ),
        'closing_date': serializeParam(
          _closingDate,
          ParamType.String,
        ),
        'property': serializeParam(
          _property,
          ParamType.DataStruct,
        ),
        'pricing': serializeParam(
          _pricing,
          ParamType.DataStruct,
        ),
        'parties': serializeParam(
          _parties,
          ParamType.DataStruct,
        ),
        'financials': serializeParam(
          _financials,
          ParamType.DataStruct,
        ),
        'conditions': serializeParam(
          _conditions,
          ParamType.DataStruct,
        ),
        'title_company': serializeParam(
          _titleCompany,
          ParamType.DataStruct,
        ),
        'addendums': serializeParam(
          _addendums,
          ParamType.DataStruct,
          isList: true,
        ),
        'documents': serializeParam(
          _documents,
          ParamType.DataStruct,
          isList: true,
        ),
        'agent_approved': serializeParam(
          _agentApproved,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NewOfferStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewOfferStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        createdTime: deserializeParam(
          data['created_time'],
          ParamType.String,
          false,
        ),
        closingDate: deserializeParam(
          data['closing_date'],
          ParamType.String,
          false,
        ),
        property: deserializeStructParam(
          data['property'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyDataClassStruct.fromSerializableMap,
        ),
        pricing: deserializeStructParam(
          data['pricing'],
          ParamType.DataStruct,
          false,
          structBuilder: PricingStruct.fromSerializableMap,
        ),
        parties: deserializeStructParam(
          data['parties'],
          ParamType.DataStruct,
          false,
          structBuilder: PartiesStruct.fromSerializableMap,
        ),
        financials: deserializeStructParam(
          data['financials'],
          ParamType.DataStruct,
          false,
          structBuilder: FinancialsStruct.fromSerializableMap,
        ),
        conditions: deserializeStructParam(
          data['conditions'],
          ParamType.DataStruct,
          false,
          structBuilder: ConditionsStruct.fromSerializableMap,
        ),
        titleCompany: deserializeStructParam(
          data['title_company'],
          ParamType.DataStruct,
          false,
          structBuilder: NewTitleCompanyStruct.fromSerializableMap,
        ),
        addendums: deserializeStructParam<NewAddendumsStruct>(
          data['addendums'],
          ParamType.DataStruct,
          true,
          structBuilder: NewAddendumsStruct.fromSerializableMap,
        ),
        documents: deserializeStructParam<UserFileStruct>(
          data['documents'],
          ParamType.DataStruct,
          true,
          structBuilder: UserFileStruct.fromSerializableMap,
        ),
        agentApproved: deserializeParam(
          data['agent_approved'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'NewOfferStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NewOfferStruct &&
        id == other.id &&
        status == other.status &&
        createdTime == other.createdTime &&
        closingDate == other.closingDate &&
        property == other.property &&
        pricing == other.pricing &&
        parties == other.parties &&
        financials == other.financials &&
        conditions == other.conditions &&
        titleCompany == other.titleCompany &&
        listEquality.equals(addendums, other.addendums) &&
        listEquality.equals(documents, other.documents) &&
        agentApproved == other.agentApproved;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        status,
        createdTime,
        closingDate,
        property,
        pricing,
        parties,
        financials,
        conditions,
        titleCompany,
        addendums,
        documents,
        agentApproved
      ]);
}

NewOfferStruct createNewOfferStruct({
  String? id,
  String? status,
  String? createdTime,
  String? closingDate,
  PropertyDataClassStruct? property,
  PricingStruct? pricing,
  PartiesStruct? parties,
  FinancialsStruct? financials,
  ConditionsStruct? conditions,
  NewTitleCompanyStruct? titleCompany,
  bool? agentApproved,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NewOfferStruct(
      id: id,
      status: status,
      createdTime: createdTime,
      closingDate: closingDate,
      property:
          property ?? (clearUnsetFields ? PropertyDataClassStruct() : null),
      pricing: pricing ?? (clearUnsetFields ? PricingStruct() : null),
      parties: parties ?? (clearUnsetFields ? PartiesStruct() : null),
      financials: financials ?? (clearUnsetFields ? FinancialsStruct() : null),
      conditions: conditions ?? (clearUnsetFields ? ConditionsStruct() : null),
      titleCompany:
          titleCompany ?? (clearUnsetFields ? NewTitleCompanyStruct() : null),
      agentApproved: agentApproved,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NewOfferStruct? updateNewOfferStruct(
  NewOfferStruct? newOffer, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    newOffer
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNewOfferStructData(
  Map<String, dynamic> firestoreData,
  NewOfferStruct? newOffer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (newOffer == null) {
    return;
  }
  if (newOffer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && newOffer.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final newOfferData = getNewOfferFirestoreData(newOffer, forFieldValue);
  final nestedData = newOfferData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = newOffer.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNewOfferFirestoreData(
  NewOfferStruct? newOffer, [
  bool forFieldValue = false,
]) {
  if (newOffer == null) {
    return {};
  }
  final firestoreData = mapToFirestore(newOffer.toMap());

  // Handle nested data for "property" field.
  addPropertyDataClassStructData(
    firestoreData,
    newOffer.hasProperty() ? newOffer.property : null,
    'property',
    forFieldValue,
  );

  // Handle nested data for "pricing" field.
  addPricingStructData(
    firestoreData,
    newOffer.hasPricing() ? newOffer.pricing : null,
    'pricing',
    forFieldValue,
  );

  // Handle nested data for "parties" field.
  addPartiesStructData(
    firestoreData,
    newOffer.hasParties() ? newOffer.parties : null,
    'parties',
    forFieldValue,
  );

  // Handle nested data for "financials" field.
  addFinancialsStructData(
    firestoreData,
    newOffer.hasFinancials() ? newOffer.financials : null,
    'financials',
    forFieldValue,
  );

  // Handle nested data for "conditions" field.
  addConditionsStructData(
    firestoreData,
    newOffer.hasConditions() ? newOffer.conditions : null,
    'conditions',
    forFieldValue,
  );

  // Handle nested data for "title_company" field.
  addNewTitleCompanyStructData(
    firestoreData,
    newOffer.hasTitleCompany() ? newOffer.titleCompany : null,
    'title_company',
    forFieldValue,
  );

  // Add any Firestore field values
  newOffer.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNewOfferListFirestoreData(
  List<NewOfferStruct>? newOffers,
) =>
    newOffers?.map((e) => getNewOfferFirestoreData(e, true)).toList() ?? [];
