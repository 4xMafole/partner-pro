// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeesAndDuesStruct extends FFFirebaseStruct {
  FeesAndDuesStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static FeesAndDuesStruct fromMap(Map<String, dynamic> data) =>
      FeesAndDuesStruct(
        id: data['id'] as String?,
      );

  static FeesAndDuesStruct? maybeFromMap(dynamic data) => data is Map
      ? FeesAndDuesStruct.fromMap(data.cast<String, dynamic>())
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

  static FeesAndDuesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FeesAndDuesStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FeesAndDuesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FeesAndDuesStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

FeesAndDuesStruct createFeesAndDuesStruct({
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FeesAndDuesStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FeesAndDuesStruct? updateFeesAndDuesStruct(
  FeesAndDuesStruct? feesAndDues, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    feesAndDues
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFeesAndDuesStructData(
  Map<String, dynamic> firestoreData,
  FeesAndDuesStruct? feesAndDues,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (feesAndDues == null) {
    return;
  }
  if (feesAndDues.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && feesAndDues.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final feesAndDuesData =
      getFeesAndDuesFirestoreData(feesAndDues, forFieldValue);
  final nestedData =
      feesAndDuesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = feesAndDues.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFeesAndDuesFirestoreData(
  FeesAndDuesStruct? feesAndDues, [
  bool forFieldValue = false,
]) {
  if (feesAndDues == null) {
    return {};
  }
  final firestoreData = mapToFirestore(feesAndDues.toMap());

  // Add any Firestore field values
  feesAndDues.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFeesAndDuesListFirestoreData(
  List<FeesAndDuesStruct>? feesAndDuess,
) =>
    feesAndDuess?.map((e) => getFeesAndDuesFirestoreData(e, true)).toList() ??
    [];
