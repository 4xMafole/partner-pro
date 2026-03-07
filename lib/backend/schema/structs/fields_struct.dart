// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FieldsStruct extends FFFirebaseStruct {
  FieldsStruct({
    String? fieldName,
    String? pages,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fieldName = fieldName,
        _pages = pages,
        super(firestoreUtilData);

  // "fieldName" field.
  String? _fieldName;
  String get fieldName => _fieldName ?? '';
  set fieldName(String? val) => _fieldName = val;

  bool hasFieldName() => _fieldName != null;

  // "pages" field.
  String? _pages;
  String get pages => _pages ?? '';
  set pages(String? val) => _pages = val;

  bool hasPages() => _pages != null;

  static FieldsStruct fromMap(Map<String, dynamic> data) => FieldsStruct(
        fieldName: data['fieldName'] as String?,
        pages: data['pages'] as String?,
      );

  static FieldsStruct? maybeFromMap(dynamic data) =>
      data is Map ? FieldsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'fieldName': _fieldName,
        'pages': _pages,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fieldName': serializeParam(
          _fieldName,
          ParamType.String,
        ),
        'pages': serializeParam(
          _pages,
          ParamType.String,
        ),
      }.withoutNulls;

  static FieldsStruct fromSerializableMap(Map<String, dynamic> data) =>
      FieldsStruct(
        fieldName: deserializeParam(
          data['fieldName'],
          ParamType.String,
          false,
        ),
        pages: deserializeParam(
          data['pages'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FieldsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FieldsStruct &&
        fieldName == other.fieldName &&
        pages == other.pages;
  }

  @override
  int get hashCode => const ListEquality().hash([fieldName, pages]);
}

FieldsStruct createFieldsStruct({
  String? fieldName,
  String? pages,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FieldsStruct(
      fieldName: fieldName,
      pages: pages,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FieldsStruct? updateFieldsStruct(
  FieldsStruct? fields, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fields
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFieldsStructData(
  Map<String, dynamic> firestoreData,
  FieldsStruct? fields,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fields == null) {
    return;
  }
  if (fields.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fields.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fieldsData = getFieldsFirestoreData(fields, forFieldValue);
  final nestedData = fieldsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fields.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFieldsFirestoreData(
  FieldsStruct? fields, [
  bool forFieldValue = false,
]) {
  if (fields == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fields.toMap());

  // Add any Firestore field values
  fields.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFieldsListFirestoreData(
  List<FieldsStruct>? fieldss,
) =>
    fieldss?.map((e) => getFieldsFirestoreData(e, true)).toList() ?? [];
