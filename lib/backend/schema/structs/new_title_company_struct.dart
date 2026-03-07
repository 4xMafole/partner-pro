// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewTitleCompanyStruct extends FFFirebaseStruct {
  NewTitleCompanyStruct({
    String? id,
    String? companyName,
    String? phoneNumber,
    AgentStruct? agent,
    String? choice,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _companyName = companyName,
        _phoneNumber = phoneNumber,
        _agent = agent,
        _choice = choice,
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

  // "agent" field.
  AgentStruct? _agent;
  AgentStruct get agent => _agent ?? AgentStruct();
  set agent(AgentStruct? val) => _agent = val;

  void updateAgent(Function(AgentStruct) updateFn) {
    updateFn(_agent ??= AgentStruct());
  }

  bool hasAgent() => _agent != null;

  // "choice" field.
  String? _choice;
  String get choice => _choice ?? '';
  set choice(String? val) => _choice = val;

  bool hasChoice() => _choice != null;

  static NewTitleCompanyStruct fromMap(Map<String, dynamic> data) =>
      NewTitleCompanyStruct(
        id: data['id'] as String?,
        companyName: data['company_name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        agent: data['agent'] is AgentStruct
            ? data['agent']
            : AgentStruct.maybeFromMap(data['agent']),
        choice: data['choice'] as String?,
      );

  static NewTitleCompanyStruct? maybeFromMap(dynamic data) => data is Map
      ? NewTitleCompanyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'company_name': _companyName,
        'phone_number': _phoneNumber,
        'agent': _agent?.toMap(),
        'choice': _choice,
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
        'agent': serializeParam(
          _agent,
          ParamType.DataStruct,
        ),
        'choice': serializeParam(
          _choice,
          ParamType.String,
        ),
      }.withoutNulls;

  static NewTitleCompanyStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewTitleCompanyStruct(
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
        agent: deserializeStructParam(
          data['agent'],
          ParamType.DataStruct,
          false,
          structBuilder: AgentStruct.fromSerializableMap,
        ),
        choice: deserializeParam(
          data['choice'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NewTitleCompanyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewTitleCompanyStruct &&
        id == other.id &&
        companyName == other.companyName &&
        phoneNumber == other.phoneNumber &&
        agent == other.agent &&
        choice == other.choice;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, companyName, phoneNumber, agent, choice]);
}

NewTitleCompanyStruct createNewTitleCompanyStruct({
  String? id,
  String? companyName,
  String? phoneNumber,
  AgentStruct? agent,
  String? choice,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NewTitleCompanyStruct(
      id: id,
      companyName: companyName,
      phoneNumber: phoneNumber,
      agent: agent ?? (clearUnsetFields ? AgentStruct() : null),
      choice: choice,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NewTitleCompanyStruct? updateNewTitleCompanyStruct(
  NewTitleCompanyStruct? newTitleCompany, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    newTitleCompany
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNewTitleCompanyStructData(
  Map<String, dynamic> firestoreData,
  NewTitleCompanyStruct? newTitleCompany,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (newTitleCompany == null) {
    return;
  }
  if (newTitleCompany.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && newTitleCompany.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final newTitleCompanyData =
      getNewTitleCompanyFirestoreData(newTitleCompany, forFieldValue);
  final nestedData =
      newTitleCompanyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = newTitleCompany.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNewTitleCompanyFirestoreData(
  NewTitleCompanyStruct? newTitleCompany, [
  bool forFieldValue = false,
]) {
  if (newTitleCompany == null) {
    return {};
  }
  final firestoreData = mapToFirestore(newTitleCompany.toMap());

  // Handle nested data for "agent" field.
  addAgentStructData(
    firestoreData,
    newTitleCompany.hasAgent() ? newTitleCompany.agent : null,
    'agent',
    forFieldValue,
  );

  // Add any Firestore field values
  newTitleCompany.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNewTitleCompanyListFirestoreData(
  List<NewTitleCompanyStruct>? newTitleCompanys,
) =>
    newTitleCompanys
        ?.map((e) => getNewTitleCompanyFirestoreData(e, true))
        .toList() ??
    [];
