// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BuyerStruct extends FFFirebaseStruct {
  BuyerStruct({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _phoneNumber = phoneNumber,
        _email = email,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

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

  static BuyerStruct fromMap(Map<String, dynamic> data) => BuyerStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        email: data['email'] as String?,
      );

  static BuyerStruct? maybeFromMap(dynamic data) =>
      data is Map ? BuyerStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'phone_number': _phoneNumber,
        'email': _email,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
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

  static BuyerStruct fromSerializableMap(Map<String, dynamic> data) =>
      BuyerStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
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
  String toString() => 'BuyerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BuyerStruct &&
        id == other.id &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, phoneNumber, email]);
}

BuyerStruct createBuyerStruct({
  String? id,
  String? name,
  String? phoneNumber,
  String? email,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BuyerStruct(
      id: id,
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

BuyerStruct? updateBuyerStruct(
  BuyerStruct? buyer, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    buyer
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBuyerStructData(
  Map<String, dynamic> firestoreData,
  BuyerStruct? buyer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (buyer == null) {
    return;
  }
  if (buyer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && buyer.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final buyerData = getBuyerFirestoreData(buyer, forFieldValue);
  final nestedData = buyerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = buyer.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBuyerFirestoreData(
  BuyerStruct? buyer, [
  bool forFieldValue = false,
]) {
  if (buyer == null) {
    return {};
  }
  final firestoreData = mapToFirestore(buyer.toMap());

  // Add any Firestore field values
  buyer.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBuyerListFirestoreData(
  List<BuyerStruct>? buyers,
) =>
    buyers?.map((e) => getBuyerFirestoreData(e, true)).toList() ?? [];
