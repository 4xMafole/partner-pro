// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddressDataClassStruct extends FFFirebaseStruct {
  AddressDataClassStruct({
    String? streetName,
    String? streetNumber,
    String? streetDirection,
    String? streetType,
    String? neighborhood,
    String? city,
    String? state,
    String? zip,
    String? zipPlus4,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _streetName = streetName,
        _streetNumber = streetNumber,
        _streetDirection = streetDirection,
        _streetType = streetType,
        _neighborhood = neighborhood,
        _city = city,
        _state = state,
        _zip = zip,
        _zipPlus4 = zipPlus4,
        super(firestoreUtilData);

  // "street_name" field.
  String? _streetName;
  String get streetName => _streetName ?? '';
  set streetName(String? val) => _streetName = val;

  bool hasStreetName() => _streetName != null;

  // "street_number" field.
  String? _streetNumber;
  String get streetNumber => _streetNumber ?? '';
  set streetNumber(String? val) => _streetNumber = val;

  bool hasStreetNumber() => _streetNumber != null;

  // "street_direction" field.
  String? _streetDirection;
  String get streetDirection => _streetDirection ?? '';
  set streetDirection(String? val) => _streetDirection = val;

  bool hasStreetDirection() => _streetDirection != null;

  // "street_type" field.
  String? _streetType;
  String get streetType => _streetType ?? '';
  set streetType(String? val) => _streetType = val;

  bool hasStreetType() => _streetType != null;

  // "neighborhood" field.
  String? _neighborhood;
  String get neighborhood => _neighborhood ?? '';
  set neighborhood(String? val) => _neighborhood = val;

  bool hasNeighborhood() => _neighborhood != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  // "zip" field.
  String? _zip;
  String get zip => _zip ?? '';
  set zip(String? val) => _zip = val;

  bool hasZip() => _zip != null;

  // "zip_plus_4" field.
  String? _zipPlus4;
  String get zipPlus4 => _zipPlus4 ?? '';
  set zipPlus4(String? val) => _zipPlus4 = val;

  bool hasZipPlus4() => _zipPlus4 != null;

  static AddressDataClassStruct fromMap(Map<String, dynamic> data) =>
      AddressDataClassStruct(
        streetName: data['street_name'] as String?,
        streetNumber: data['street_number'] as String?,
        streetDirection: data['street_direction'] as String?,
        streetType: data['street_type'] as String?,
        neighborhood: data['neighborhood'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        zip: data['zip'] as String?,
        zipPlus4: data['zip_plus_4'] as String?,
      );

  static AddressDataClassStruct? maybeFromMap(dynamic data) => data is Map
      ? AddressDataClassStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'street_name': _streetName,
        'street_number': _streetNumber,
        'street_direction': _streetDirection,
        'street_type': _streetType,
        'neighborhood': _neighborhood,
        'city': _city,
        'state': _state,
        'zip': _zip,
        'zip_plus_4': _zipPlus4,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'street_name': serializeParam(
          _streetName,
          ParamType.String,
        ),
        'street_number': serializeParam(
          _streetNumber,
          ParamType.String,
        ),
        'street_direction': serializeParam(
          _streetDirection,
          ParamType.String,
        ),
        'street_type': serializeParam(
          _streetType,
          ParamType.String,
        ),
        'neighborhood': serializeParam(
          _neighborhood,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'zip': serializeParam(
          _zip,
          ParamType.String,
        ),
        'zip_plus_4': serializeParam(
          _zipPlus4,
          ParamType.String,
        ),
      }.withoutNulls;

  static AddressDataClassStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AddressDataClassStruct(
        streetName: deserializeParam(
          data['street_name'],
          ParamType.String,
          false,
        ),
        streetNumber: deserializeParam(
          data['street_number'],
          ParamType.String,
          false,
        ),
        streetDirection: deserializeParam(
          data['street_direction'],
          ParamType.String,
          false,
        ),
        streetType: deserializeParam(
          data['street_type'],
          ParamType.String,
          false,
        ),
        neighborhood: deserializeParam(
          data['neighborhood'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        zip: deserializeParam(
          data['zip'],
          ParamType.String,
          false,
        ),
        zipPlus4: deserializeParam(
          data['zip_plus_4'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AddressDataClassStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AddressDataClassStruct &&
        streetName == other.streetName &&
        streetNumber == other.streetNumber &&
        streetDirection == other.streetDirection &&
        streetType == other.streetType &&
        neighborhood == other.neighborhood &&
        city == other.city &&
        state == other.state &&
        zip == other.zip &&
        zipPlus4 == other.zipPlus4;
  }

  @override
  int get hashCode => const ListEquality().hash([
        streetName,
        streetNumber,
        streetDirection,
        streetType,
        neighborhood,
        city,
        state,
        zip,
        zipPlus4
      ]);
}

AddressDataClassStruct createAddressDataClassStruct({
  String? streetName,
  String? streetNumber,
  String? streetDirection,
  String? streetType,
  String? neighborhood,
  String? city,
  String? state,
  String? zip,
  String? zipPlus4,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AddressDataClassStruct(
      streetName: streetName,
      streetNumber: streetNumber,
      streetDirection: streetDirection,
      streetType: streetType,
      neighborhood: neighborhood,
      city: city,
      state: state,
      zip: zip,
      zipPlus4: zipPlus4,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AddressDataClassStruct? updateAddressDataClassStruct(
  AddressDataClassStruct? addressDataClass, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    addressDataClass
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAddressDataClassStructData(
  Map<String, dynamic> firestoreData,
  AddressDataClassStruct? addressDataClass,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (addressDataClass == null) {
    return;
  }
  if (addressDataClass.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && addressDataClass.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final addressDataClassData =
      getAddressDataClassFirestoreData(addressDataClass, forFieldValue);
  final nestedData =
      addressDataClassData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = addressDataClass.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAddressDataClassFirestoreData(
  AddressDataClassStruct? addressDataClass, [
  bool forFieldValue = false,
]) {
  if (addressDataClass == null) {
    return {};
  }
  final firestoreData = mapToFirestore(addressDataClass.toMap());

  // Add any Firestore field values
  addressDataClass.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAddressDataClassListFirestoreData(
  List<AddressDataClassStruct>? addressDataClasss,
) =>
    addressDataClasss
        ?.map((e) => getAddressDataClassFirestoreData(e, true))
        .toList() ??
    [];
