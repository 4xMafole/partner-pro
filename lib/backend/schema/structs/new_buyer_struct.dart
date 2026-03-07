// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewBuyerStruct extends FFFirebaseStruct {
  NewBuyerStruct({
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

  static NewBuyerStruct fromMap(Map<String, dynamic> data) => NewBuyerStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        phoneNumber: data['phone_number'] as String?,
        email: data['email'] as String?,
      );

  static NewBuyerStruct? maybeFromMap(dynamic data) =>
      data is Map ? NewBuyerStruct.fromMap(data.cast<String, dynamic>()) : null;

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

  static NewBuyerStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewBuyerStruct(
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
  String toString() => 'NewBuyerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewBuyerStruct &&
        id == other.id &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, phoneNumber, email]);
}

NewBuyerStruct createNewBuyerStruct({
  String? id,
  String? name,
  String? phoneNumber,
  String? email,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NewBuyerStruct(
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

NewBuyerStruct? updateNewBuyerStruct(
  NewBuyerStruct? newBuyer, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    newBuyer
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNewBuyerStructData(
  Map<String, dynamic> firestoreData,
  NewBuyerStruct? newBuyer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (newBuyer == null) {
    return;
  }
  if (newBuyer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && newBuyer.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final newBuyerData = getNewBuyerFirestoreData(newBuyer, forFieldValue);
  final nestedData = newBuyerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = newBuyer.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNewBuyerFirestoreData(
  NewBuyerStruct? newBuyer, [
  bool forFieldValue = false,
]) {
  if (newBuyer == null) {
    return {};
  }
  final firestoreData = mapToFirestore(newBuyer.toMap());

  // Add any Firestore field values
  newBuyer.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNewBuyerListFirestoreData(
  List<NewBuyerStruct>? newBuyers,
) =>
    newBuyers?.map((e) => getNewBuyerFirestoreData(e, true)).toList() ?? [];
