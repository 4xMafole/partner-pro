// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class OpenHouseScheduleStruct extends FFFirebaseStruct {
  OpenHouseScheduleStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static OpenHouseScheduleStruct fromMap(Map<String, dynamic> data) =>
      OpenHouseScheduleStruct(
        id: data['id'] as String?,
      );

  static OpenHouseScheduleStruct? maybeFromMap(dynamic data) => data is Map
      ? OpenHouseScheduleStruct.fromMap(data.cast<String, dynamic>())
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

  static OpenHouseScheduleStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OpenHouseScheduleStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OpenHouseScheduleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OpenHouseScheduleStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

OpenHouseScheduleStruct createOpenHouseScheduleStruct({
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OpenHouseScheduleStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OpenHouseScheduleStruct? updateOpenHouseScheduleStruct(
  OpenHouseScheduleStruct? openHouseSchedule, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    openHouseSchedule
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOpenHouseScheduleStructData(
  Map<String, dynamic> firestoreData,
  OpenHouseScheduleStruct? openHouseSchedule,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (openHouseSchedule == null) {
    return;
  }
  if (openHouseSchedule.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && openHouseSchedule.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final openHouseScheduleData =
      getOpenHouseScheduleFirestoreData(openHouseSchedule, forFieldValue);
  final nestedData =
      openHouseScheduleData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = openHouseSchedule.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOpenHouseScheduleFirestoreData(
  OpenHouseScheduleStruct? openHouseSchedule, [
  bool forFieldValue = false,
]) {
  if (openHouseSchedule == null) {
    return {};
  }
  final firestoreData = mapToFirestore(openHouseSchedule.toMap());

  // Add any Firestore field values
  openHouseSchedule.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOpenHouseScheduleListFirestoreData(
  List<OpenHouseScheduleStruct>? openHouseSchedules,
) =>
    openHouseSchedules
        ?.map((e) => getOpenHouseScheduleFirestoreData(e, true))
        .toList() ??
    [];
