// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ConditionsStruct extends FFFirebaseStruct {
  ConditionsStruct({
    String? propertyCondition,
    bool? preApproval,
    bool? survey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _propertyCondition = propertyCondition,
        _preApproval = preApproval,
        _survey = survey,
        super(firestoreUtilData);

  // "property_condition" field.
  String? _propertyCondition;
  String get propertyCondition => _propertyCondition ?? '';
  set propertyCondition(String? val) => _propertyCondition = val;

  bool hasPropertyCondition() => _propertyCondition != null;

  // "pre_approval" field.
  bool? _preApproval;
  bool get preApproval => _preApproval ?? false;
  set preApproval(bool? val) => _preApproval = val;

  bool hasPreApproval() => _preApproval != null;

  // "survey" field.
  bool? _survey;
  bool get survey => _survey ?? false;
  set survey(bool? val) => _survey = val;

  bool hasSurvey() => _survey != null;

  static ConditionsStruct fromMap(Map<String, dynamic> data) =>
      ConditionsStruct(
        propertyCondition: data['property_condition'] as String?,
        preApproval: data['pre_approval'] as bool?,
        survey: data['survey'] as bool?,
      );

  static ConditionsStruct? maybeFromMap(dynamic data) => data is Map
      ? ConditionsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'property_condition': _propertyCondition,
        'pre_approval': _preApproval,
        'survey': _survey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'property_condition': serializeParam(
          _propertyCondition,
          ParamType.String,
        ),
        'pre_approval': serializeParam(
          _preApproval,
          ParamType.bool,
        ),
        'survey': serializeParam(
          _survey,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ConditionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConditionsStruct(
        propertyCondition: deserializeParam(
          data['property_condition'],
          ParamType.String,
          false,
        ),
        preApproval: deserializeParam(
          data['pre_approval'],
          ParamType.bool,
          false,
        ),
        survey: deserializeParam(
          data['survey'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ConditionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ConditionsStruct &&
        propertyCondition == other.propertyCondition &&
        preApproval == other.preApproval &&
        survey == other.survey;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([propertyCondition, preApproval, survey]);
}

ConditionsStruct createConditionsStruct({
  String? propertyCondition,
  bool? preApproval,
  bool? survey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConditionsStruct(
      propertyCondition: propertyCondition,
      preApproval: preApproval,
      survey: survey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConditionsStruct? updateConditionsStruct(
  ConditionsStruct? conditions, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    conditions
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConditionsStructData(
  Map<String, dynamic> firestoreData,
  ConditionsStruct? conditions,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (conditions == null) {
    return;
  }
  if (conditions.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && conditions.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final conditionsData = getConditionsFirestoreData(conditions, forFieldValue);
  final nestedData = conditionsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = conditions.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConditionsFirestoreData(
  ConditionsStruct? conditions, [
  bool forFieldValue = false,
]) {
  if (conditions == null) {
    return {};
  }
  final firestoreData = mapToFirestore(conditions.toMap());

  // Add any Firestore field values
  conditions.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConditionsListFirestoreData(
  List<ConditionsStruct>? conditionss,
) =>
    conditionss?.map((e) => getConditionsFirestoreData(e, true)).toList() ?? [];
