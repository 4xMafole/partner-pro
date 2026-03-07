// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AtAGlanceFactsStruct extends FFFirebaseStruct {
  AtAGlanceFactsStruct({
    String? factValue,
    String? factLabel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _factValue = factValue,
        _factLabel = factLabel,
        super(firestoreUtilData);

  // "factValue" field.
  String? _factValue;
  String get factValue => _factValue ?? '';
  set factValue(String? val) => _factValue = val;

  bool hasFactValue() => _factValue != null;

  // "factLabel" field.
  String? _factLabel;
  String get factLabel => _factLabel ?? '';
  set factLabel(String? val) => _factLabel = val;

  bool hasFactLabel() => _factLabel != null;

  static AtAGlanceFactsStruct fromMap(Map<String, dynamic> data) =>
      AtAGlanceFactsStruct(
        factValue: data['factValue'] as String?,
        factLabel: data['factLabel'] as String?,
      );

  static AtAGlanceFactsStruct? maybeFromMap(dynamic data) => data is Map
      ? AtAGlanceFactsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'factValue': _factValue,
        'factLabel': _factLabel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'factValue': serializeParam(
          _factValue,
          ParamType.String,
        ),
        'factLabel': serializeParam(
          _factLabel,
          ParamType.String,
        ),
      }.withoutNulls;

  static AtAGlanceFactsStruct fromSerializableMap(Map<String, dynamic> data) =>
      AtAGlanceFactsStruct(
        factValue: deserializeParam(
          data['factValue'],
          ParamType.String,
          false,
        ),
        factLabel: deserializeParam(
          data['factLabel'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AtAGlanceFactsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AtAGlanceFactsStruct &&
        factValue == other.factValue &&
        factLabel == other.factLabel;
  }

  @override
  int get hashCode => const ListEquality().hash([factValue, factLabel]);
}

AtAGlanceFactsStruct createAtAGlanceFactsStruct({
  String? factValue,
  String? factLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AtAGlanceFactsStruct(
      factValue: factValue,
      factLabel: factLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AtAGlanceFactsStruct? updateAtAGlanceFactsStruct(
  AtAGlanceFactsStruct? atAGlanceFacts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    atAGlanceFacts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAtAGlanceFactsStructData(
  Map<String, dynamic> firestoreData,
  AtAGlanceFactsStruct? atAGlanceFacts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (atAGlanceFacts == null) {
    return;
  }
  if (atAGlanceFacts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && atAGlanceFacts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final atAGlanceFactsData =
      getAtAGlanceFactsFirestoreData(atAGlanceFacts, forFieldValue);
  final nestedData =
      atAGlanceFactsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = atAGlanceFacts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAtAGlanceFactsFirestoreData(
  AtAGlanceFactsStruct? atAGlanceFacts, [
  bool forFieldValue = false,
]) {
  if (atAGlanceFacts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(atAGlanceFacts.toMap());

  // Add any Firestore field values
  atAGlanceFacts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAtAGlanceFactsListFirestoreData(
  List<AtAGlanceFactsStruct>? atAGlanceFactss,
) =>
    atAGlanceFactss
        ?.map((e) => getAtAGlanceFactsFirestoreData(e, true))
        .toList() ??
    [];
