// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttributeSourceStruct extends FFFirebaseStruct {
  AttributeSourceStruct({
    String? infoString2,
    String? infoString3,
    String? infoString1,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _infoString2 = infoString2,
        _infoString3 = infoString3,
        _infoString1 = infoString1,
        super(firestoreUtilData);

  // "infoString2" field.
  String? _infoString2;
  String get infoString2 => _infoString2 ?? '';
  set infoString2(String? val) => _infoString2 = val;

  bool hasInfoString2() => _infoString2 != null;

  // "infoString3" field.
  String? _infoString3;
  String get infoString3 => _infoString3 ?? '';
  set infoString3(String? val) => _infoString3 = val;

  bool hasInfoString3() => _infoString3 != null;

  // "infoString1" field.
  String? _infoString1;
  String get infoString1 => _infoString1 ?? '';
  set infoString1(String? val) => _infoString1 = val;

  bool hasInfoString1() => _infoString1 != null;

  static AttributeSourceStruct fromMap(Map<String, dynamic> data) =>
      AttributeSourceStruct(
        infoString2: data['infoString2'] as String?,
        infoString3: data['infoString3'] as String?,
        infoString1: data['infoString1'] as String?,
      );

  static AttributeSourceStruct? maybeFromMap(dynamic data) => data is Map
      ? AttributeSourceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'infoString2': _infoString2,
        'infoString3': _infoString3,
        'infoString1': _infoString1,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'infoString2': serializeParam(
          _infoString2,
          ParamType.String,
        ),
        'infoString3': serializeParam(
          _infoString3,
          ParamType.String,
        ),
        'infoString1': serializeParam(
          _infoString1,
          ParamType.String,
        ),
      }.withoutNulls;

  static AttributeSourceStruct fromSerializableMap(Map<String, dynamic> data) =>
      AttributeSourceStruct(
        infoString2: deserializeParam(
          data['infoString2'],
          ParamType.String,
          false,
        ),
        infoString3: deserializeParam(
          data['infoString3'],
          ParamType.String,
          false,
        ),
        infoString1: deserializeParam(
          data['infoString1'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AttributeSourceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AttributeSourceStruct &&
        infoString2 == other.infoString2 &&
        infoString3 == other.infoString3 &&
        infoString1 == other.infoString1;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([infoString2, infoString3, infoString1]);
}

AttributeSourceStruct createAttributeSourceStruct({
  String? infoString2,
  String? infoString3,
  String? infoString1,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AttributeSourceStruct(
      infoString2: infoString2,
      infoString3: infoString3,
      infoString1: infoString1,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AttributeSourceStruct? updateAttributeSourceStruct(
  AttributeSourceStruct? attributeSource, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    attributeSource
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAttributeSourceStructData(
  Map<String, dynamic> firestoreData,
  AttributeSourceStruct? attributeSource,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (attributeSource == null) {
    return;
  }
  if (attributeSource.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && attributeSource.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final attributeSourceData =
      getAttributeSourceFirestoreData(attributeSource, forFieldValue);
  final nestedData =
      attributeSourceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = attributeSource.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAttributeSourceFirestoreData(
  AttributeSourceStruct? attributeSource, [
  bool forFieldValue = false,
]) {
  if (attributeSource == null) {
    return {};
  }
  final firestoreData = mapToFirestore(attributeSource.toMap());

  // Add any Firestore field values
  attributeSource.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAttributeSourceListFirestoreData(
  List<AttributeSourceStruct>? attributeSources,
) =>
    attributeSources
        ?.map((e) => getAttributeSourceFirestoreData(e, true))
        .toList() ??
    [];
