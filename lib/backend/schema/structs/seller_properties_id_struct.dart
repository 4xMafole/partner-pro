// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SellerPropertiesIdStruct extends FFFirebaseStruct {
  SellerPropertiesIdStruct({
    String? oid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _oid = oid,
        super(firestoreUtilData);

  // "oid" field.
  String? _oid;
  String get oid => _oid ?? '';
  set oid(String? val) => _oid = val;

  bool hasOid() => _oid != null;

  static SellerPropertiesIdStruct fromMap(Map<String, dynamic> data) =>
      SellerPropertiesIdStruct(
        oid: data['oid'] as String?,
      );

  static SellerPropertiesIdStruct? maybeFromMap(dynamic data) => data is Map
      ? SellerPropertiesIdStruct.fromMap(data.cast<String, dynamic>())
      : null;

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

  static SellerPropertiesIdStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SellerPropertiesIdStruct(
        oid: deserializeParam(
          data['oid'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SellerPropertiesIdStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SellerPropertiesIdStruct && oid == other.oid;
  }

  @override
  int get hashCode => const ListEquality().hash([oid]);
}

SellerPropertiesIdStruct createSellerPropertiesIdStruct({
  String? oid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SellerPropertiesIdStruct(
      oid: oid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SellerPropertiesIdStruct? updateSellerPropertiesIdStruct(
  SellerPropertiesIdStruct? sellerPropertiesId, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sellerPropertiesId
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSellerPropertiesIdStructData(
  Map<String, dynamic> firestoreData,
  SellerPropertiesIdStruct? sellerPropertiesId,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sellerPropertiesId == null) {
    return;
  }
  if (sellerPropertiesId.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && sellerPropertiesId.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sellerPropertiesIdData =
      getSellerPropertiesIdFirestoreData(sellerPropertiesId, forFieldValue);
  final nestedData =
      sellerPropertiesIdData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      sellerPropertiesId.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSellerPropertiesIdFirestoreData(
  SellerPropertiesIdStruct? sellerPropertiesId, [
  bool forFieldValue = false,
]) {
  if (sellerPropertiesId == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sellerPropertiesId.toMap());

  // Add any Firestore field values
  sellerPropertiesId.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSellerPropertiesIdListFirestoreData(
  List<SellerPropertiesIdStruct>? sellerPropertiesIds,
) =>
    sellerPropertiesIds
        ?.map((e) => getSellerPropertiesIdFirestoreData(e, true))
        .toList() ??
    [];
