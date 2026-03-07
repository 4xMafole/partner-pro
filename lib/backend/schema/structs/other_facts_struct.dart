// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class OtherFactsStruct extends FFFirebaseStruct {
  OtherFactsStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static OtherFactsStruct fromMap(Map<String, dynamic> data) =>
      OtherFactsStruct(
        id: data['id'] as String?,
      );

  static OtherFactsStruct? maybeFromMap(dynamic data) => data is Map
      ? OtherFactsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static OtherFactsStruct fromSerializableMap(Map<String, dynamic> data) =>
      OtherFactsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OtherFactsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OtherFactsStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

OtherFactsStruct createOtherFactsStruct({
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OtherFactsStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OtherFactsStruct? updateOtherFactsStruct(
  OtherFactsStruct? otherFacts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    otherFacts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOtherFactsStructData(
  Map<String, dynamic> firestoreData,
  OtherFactsStruct? otherFacts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (otherFacts == null) {
    return;
  }
  if (otherFacts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && otherFacts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final otherFactsData = getOtherFactsFirestoreData(otherFacts, forFieldValue);
  final nestedData = otherFactsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = otherFacts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOtherFactsFirestoreData(
  OtherFactsStruct? otherFacts, [
  bool forFieldValue = false,
]) {
  if (otherFacts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(otherFacts.toMap());

  // Add any Firestore field values
  otherFacts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOtherFactsListFirestoreData(
  List<OtherFactsStruct>? otherFactss,
) =>
    otherFactss?.map((e) => getOtherFactsFirestoreData(e, true)).toList() ?? [];
