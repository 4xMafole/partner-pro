// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TitleCompanyStruct extends FFFirebaseStruct {
  TitleCompanyStruct({
    String? id,
    String? companyName,
    String? phoneNumber,
    String? email,
    String? choice,
    BuyerStruct? agent,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _companyName = companyName,
        _phoneNumber = phoneNumber,
        _email = email,
        _choice = choice,
        _agent = agent,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  set companyName(String? val) => _companyName = val;

  bool hasCompanyName() => _companyName != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "choice" field.
  String? _choice;
  String get choice => _choice ?? '';
  set choice(String? val) => _choice = val;

  bool hasChoice() => _choice != null;

  // "agent" field.
  BuyerStruct? _agent;
  BuyerStruct get agent => _agent ?? BuyerStruct();
  set agent(BuyerStruct? val) => _agent = val;

  void updateAgent(Function(BuyerStruct) updateFn) {
    updateFn(_agent ??= BuyerStruct());
  }

  bool hasAgent() => _agent != null;

  static TitleCompanyStruct fromMap(Map<String, dynamic> data) =>
      TitleCompanyStruct(
        id: data['id'] as String?,
        companyName: data['company_name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        email: data['email'] as String?,
        choice: data['choice'] as String?,
        agent: data['agent'] is BuyerStruct
            ? data['agent']
            : BuyerStruct.maybeFromMap(data['agent']),
      );

  static TitleCompanyStruct? maybeFromMap(dynamic data) => data is Map
      ? TitleCompanyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'company_name': _companyName,
        'phone_number': _phoneNumber,
        'email': _email,
        'choice': _choice,
        'agent': _agent?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'company_name': serializeParam(
          _companyName,
          ParamType.String,
        ),
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'choice': serializeParam(
          _choice,
          ParamType.String,
        ),
        'agent': serializeParam(
          _agent,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static TitleCompanyStruct fromSerializableMap(Map<String, dynamic> data) =>
      TitleCompanyStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        companyName: deserializeParam(
          data['company_name'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        choice: deserializeParam(
          data['choice'],
          ParamType.String,
          false,
        ),
        agent: deserializeStructParam(
          data['agent'],
          ParamType.DataStruct,
          false,
          structBuilder: BuyerStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TitleCompanyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TitleCompanyStruct &&
        id == other.id &&
        companyName == other.companyName &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        choice == other.choice &&
        agent == other.agent;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, companyName, phoneNumber, email, choice, agent]);
}

TitleCompanyStruct createTitleCompanyStruct({
  String? id,
  String? companyName,
  String? phoneNumber,
  String? email,
  String? choice,
  BuyerStruct? agent,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TitleCompanyStruct(
      id: id,
      companyName: companyName,
      phoneNumber: phoneNumber,
      email: email,
      choice: choice,
      agent: agent ?? (clearUnsetFields ? BuyerStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TitleCompanyStruct? updateTitleCompanyStruct(
  TitleCompanyStruct? titleCompany, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    titleCompany
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTitleCompanyStructData(
  Map<String, dynamic> firestoreData,
  TitleCompanyStruct? titleCompany,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (titleCompany == null) {
    return;
  }
  if (titleCompany.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && titleCompany.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final titleCompanyData =
      getTitleCompanyFirestoreData(titleCompany, forFieldValue);
  final nestedData =
      titleCompanyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = titleCompany.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTitleCompanyFirestoreData(
  TitleCompanyStruct? titleCompany, [
  bool forFieldValue = false,
]) {
  if (titleCompany == null) {
    return {};
  }
  final firestoreData = mapToFirestore(titleCompany.toMap());

  // Handle nested data for "agent" field.
  addBuyerStructData(
    firestoreData,
    titleCompany.hasAgent() ? titleCompany.agent : null,
    'agent',
    forFieldValue,
  );

  // Add any Firestore field values
  titleCompany.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTitleCompanyListFirestoreData(
  List<TitleCompanyStruct>? titleCompanys,
) =>
    titleCompanys?.map((e) => getTitleCompanyFirestoreData(e, true)).toList() ??
    [];
