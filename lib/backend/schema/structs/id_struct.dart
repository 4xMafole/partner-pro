// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IdStruct extends FFFirebaseStruct {
  IdStruct({
    String? oid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _oid = oid,
        super(firestoreUtilData);

  // "oid" field.
  String? _oid;
  String get oid => _oid ?? '';
  set oid(String? val) => _oid = val;

  bool hasOid() => _oid != null;

  static IdStruct fromMap(Map<String, dynamic> data) => IdStruct(
        oid: data['oid'] as String?,
      );

  static IdStruct? maybeFromMap(dynamic data) =>
      data is Map ? IdStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'oid': _oid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'oid': serializeParam(
          _oid,
          ParamType.String,
        ),
      }.withoutNulls;

  static IdStruct fromSerializableMap(Map<String, dynamic> data) => IdStruct(
        oid: deserializeParam(
          data['oid'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'IdStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IdStruct && oid == other.oid;
  }

  @override
  int get hashCode => const ListEquality().hash([oid]);
}

IdStruct createIdStruct({
  String? oid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IdStruct(
      oid: oid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

IdStruct? updateIdStruct(
  IdStruct? id, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    id
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIdStructData(
  Map<String, dynamic> firestoreData,
  IdStruct? id,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (id == null) {
    return;
  }
  if (id.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && id.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final idData = getIdFirestoreData(id, forFieldValue);
  final nestedData = idData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = id.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIdFirestoreData(
  IdStruct? id, [
  bool forFieldValue = false,
]) {
  if (id == null) {
    return {};
  }
  final firestoreData = mapToFirestore(id.toMap());

  // Add any Firestore field values
  id.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIdListFirestoreData(
  List<IdStruct>? ids,
) =>
    ids?.map((e) => getIdFirestoreData(e, true)).toList() ?? [];
