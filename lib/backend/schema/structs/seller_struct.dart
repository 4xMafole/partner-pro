// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SellerStruct extends FFFirebaseStruct {
  SellerStruct({
    String? name,
    String? phoneNumber,
    String? email,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _email = email,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  static SellerStruct fromMap(Map<String, dynamic> data) => SellerStruct(
        name: data['name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        email: data['email'] as String?,
      );

  static SellerStruct? maybeFromMap(dynamic data) =>
      data is Map ? SellerStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'phone_number': _phoneNumber,
        'email': _email,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
      }.withoutNulls;

  static SellerStruct fromSerializableMap(Map<String, dynamic> data) =>
      SellerStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SellerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SellerStruct &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
  }

  @override
  int get hashCode => const ListEquality().hash([name, phoneNumber, email]);
}

SellerStruct createSellerStruct({
  String? name,
  String? phoneNumber,
  String? email,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SellerStruct(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SellerStruct? updateSellerStruct(
  SellerStruct? seller, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    seller
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSellerStructData(
  Map<String, dynamic> firestoreData,
  SellerStruct? seller,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (seller == null) {
    return;
  }
  if (seller.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && seller.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sellerData = getSellerFirestoreData(seller, forFieldValue);
  final nestedData = sellerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = seller.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSellerFirestoreData(
  SellerStruct? seller, [
  bool forFieldValue = false,
]) {
  if (seller == null) {
    return {};
  }
  final firestoreData = mapToFirestore(seller.toMap());

  // Add any Firestore field values
  seller.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSellerListFirestoreData(
  List<SellerStruct>? sellers,
) =>
    sellers?.map((e) => getSellerFirestoreData(e, true)).toList() ?? [];
