// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RoomsStruct extends FFFirebaseStruct {
  RoomsStruct({
    String? temporary,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _temporary = temporary,
        super(firestoreUtilData);

  // "temporary" field.
  String? _temporary;
  String get temporary => _temporary ?? '';
  set temporary(String? val) => _temporary = val;

  bool hasTemporary() => _temporary != null;

  static RoomsStruct fromMap(Map<String, dynamic> data) => RoomsStruct(
        temporary: data['temporary'] as String?,
      );

  static RoomsStruct? maybeFromMap(dynamic data) =>
      data is Map ? RoomsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'temporary': _temporary,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'temporary': serializeParam(
          _temporary,
          ParamType.String,
        ),
      }.withoutNulls;

  static RoomsStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomsStruct(
        temporary: deserializeParam(
          data['temporary'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RoomsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomsStruct && temporary == other.temporary;
  }

  @override
  int get hashCode => const ListEquality().hash([temporary]);
}

RoomsStruct createRoomsStruct({
  String? temporary,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomsStruct(
      temporary: temporary,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomsStruct? updateRoomsStruct(
  RoomsStruct? rooms, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    rooms
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomsStructData(
  Map<String, dynamic> firestoreData,
  RoomsStruct? rooms,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (rooms == null) {
    return;
  }
  if (rooms.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && rooms.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomsData = getRoomsFirestoreData(rooms, forFieldValue);
  final nestedData = roomsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = rooms.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomsFirestoreData(
  RoomsStruct? rooms, [
  bool forFieldValue = false,
]) {
  if (rooms == null) {
    return {};
  }
  final firestoreData = mapToFirestore(rooms.toMap());

  // Add any Firestore field values
  rooms.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomsListFirestoreData(
  List<RoomsStruct>? roomss,
) =>
    roomss?.map((e) => getRoomsFirestoreData(e, true)).toList() ?? [];
