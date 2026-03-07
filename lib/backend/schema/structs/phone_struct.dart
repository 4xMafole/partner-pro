// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PhoneStruct extends FFFirebaseStruct {
  PhoneStruct({
    String? prefix,
    String? areacode,
    String? number,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _prefix = prefix,
        _areacode = areacode,
        _number = number,
        super(firestoreUtilData);

  // "prefix" field.
  String? _prefix;
  String get prefix => _prefix ?? '';
  set prefix(String? val) => _prefix = val;

  bool hasPrefix() => _prefix != null;

  // "areacode" field.
  String? _areacode;
  String get areacode => _areacode ?? '';
  set areacode(String? val) => _areacode = val;

  bool hasAreacode() => _areacode != null;

  // "number" field.
  String? _number;
  String get number => _number ?? '';
  set number(String? val) => _number = val;

  bool hasNumber() => _number != null;

  static PhoneStruct fromMap(Map<String, dynamic> data) => PhoneStruct(
        prefix: data['prefix'] as String?,
        areacode: data['areacode'] as String?,
        number: data['number'] as String?,
      );

  static PhoneStruct? maybeFromMap(dynamic data) =>
      data is Map ? PhoneStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'prefix': _prefix,
        'areacode': _areacode,
        'number': _number,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'prefix': serializeParam(
          _prefix,
          ParamType.String,
        ),
        'areacode': serializeParam(
          _areacode,
          ParamType.String,
        ),
        'number': serializeParam(
          _number,
          ParamType.String,
        ),
      }.withoutNulls;

  static PhoneStruct fromSerializableMap(Map<String, dynamic> data) =>
      PhoneStruct(
        prefix: deserializeParam(
          data['prefix'],
          ParamType.String,
          false,
        ),
        areacode: deserializeParam(
          data['areacode'],
          ParamType.String,
          false,
        ),
        number: deserializeParam(
          data['number'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PhoneStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PhoneStruct &&
        prefix == other.prefix &&
        areacode == other.areacode &&
        number == other.number;
  }

  @override
  int get hashCode => const ListEquality().hash([prefix, areacode, number]);
}

PhoneStruct createPhoneStruct({
  String? prefix,
  String? areacode,
  String? number,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PhoneStruct(
      prefix: prefix,
      areacode: areacode,
      number: number,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PhoneStruct? updatePhoneStruct(
  PhoneStruct? phone, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    phone
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPhoneStructData(
  Map<String, dynamic> firestoreData,
  PhoneStruct? phone,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (phone == null) {
    return;
  }
  if (phone.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && phone.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final phoneData = getPhoneFirestoreData(phone, forFieldValue);
  final nestedData = phoneData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = phone.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPhoneFirestoreData(
  PhoneStruct? phone, [
  bool forFieldValue = false,
]) {
  if (phone == null) {
    return {};
  }
  final firestoreData = mapToFirestore(phone.toMap());

  // Add any Firestore field values
  phone.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPhoneListFirestoreData(
  List<PhoneStruct>? phones,
) =>
    phones?.map((e) => getPhoneFirestoreData(e, true)).toList() ?? [];
