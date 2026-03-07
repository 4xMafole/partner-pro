// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RelationshipTypeStruct extends FFFirebaseStruct {
  RelationshipTypeStruct({
    String? agentUid,
    String? subjectUid,
    String? type,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _agentUid = agentUid,
        _subjectUid = subjectUid,
        _type = type,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "agentUid" field.
  String? _agentUid;
  String get agentUid => _agentUid ?? '';
  set agentUid(String? val) => _agentUid = val;

  bool hasAgentUid() => _agentUid != null;

  // "subjectUid" field.
  String? _subjectUid;
  String get subjectUid => _subjectUid ?? '';
  set subjectUid(String? val) => _subjectUid = val;

  bool hasSubjectUid() => _subjectUid != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static RelationshipTypeStruct fromMap(Map<String, dynamic> data) =>
      RelationshipTypeStruct(
        agentUid: data['agentUid'] as String?,
        subjectUid: data['subjectUid'] as String?,
        type: data['type'] as String?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static RelationshipTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? RelationshipTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'agentUid': _agentUid,
        'subjectUid': _subjectUid,
        'type': _type,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'agentUid': serializeParam(
          _agentUid,
          ParamType.String,
        ),
        'subjectUid': serializeParam(
          _subjectUid,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static RelationshipTypeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RelationshipTypeStruct(
        agentUid: deserializeParam(
          data['agentUid'],
          ParamType.String,
          false,
        ),
        subjectUid: deserializeParam(
          data['subjectUid'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'RelationshipTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RelationshipTypeStruct &&
        agentUid == other.agentUid &&
        subjectUid == other.subjectUid &&
        type == other.type &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([agentUid, subjectUid, type, createdAt]);
}

RelationshipTypeStruct createRelationshipTypeStruct({
  String? agentUid,
  String? subjectUid,
  String? type,
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RelationshipTypeStruct(
      agentUid: agentUid,
      subjectUid: subjectUid,
      type: type,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RelationshipTypeStruct? updateRelationshipTypeStruct(
  RelationshipTypeStruct? relationshipType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    relationshipType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRelationshipTypeStructData(
  Map<String, dynamic> firestoreData,
  RelationshipTypeStruct? relationshipType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (relationshipType == null) {
    return;
  }
  if (relationshipType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && relationshipType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final relationshipTypeData =
      getRelationshipTypeFirestoreData(relationshipType, forFieldValue);
  final nestedData =
      relationshipTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = relationshipType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRelationshipTypeFirestoreData(
  RelationshipTypeStruct? relationshipType, [
  bool forFieldValue = false,
]) {
  if (relationshipType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(relationshipType.toMap());

  // Add any Firestore field values
  relationshipType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRelationshipTypeListFirestoreData(
  List<RelationshipTypeStruct>? relationshipTypes,
) =>
    relationshipTypes
        ?.map((e) => getRelationshipTypeFirestoreData(e, true))
        .toList() ??
    [];
