// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AgentStruct extends FFFirebaseStruct {
  AgentStruct({
    String? id,
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static AgentStruct fromMap(Map<String, dynamic> data) => AgentStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
      );

  static AgentStruct? maybeFromMap(dynamic data) =>
      data is Map ? AgentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static AgentStruct fromSerializableMap(Map<String, dynamic> data) =>
      AgentStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AgentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AgentStruct && id == other.id && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name]);
}

AgentStruct createAgentStruct({
  String? id,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AgentStruct(
      id: id,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AgentStruct? updateAgentStruct(
  AgentStruct? agent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    agent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAgentStructData(
  Map<String, dynamic> firestoreData,
  AgentStruct? agent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (agent == null) {
    return;
  }
  if (agent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && agent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final agentData = getAgentFirestoreData(agent, forFieldValue);
  final nestedData = agentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = agent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAgentFirestoreData(
  AgentStruct? agent, [
  bool forFieldValue = false,
]) {
  if (agent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(agent.toMap());

  // Add any Firestore field values
  agent.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAgentListFirestoreData(
  List<AgentStruct>? agents,
) =>
    agents?.map((e) => getAgentFirestoreData(e, true)).toList() ?? [];
