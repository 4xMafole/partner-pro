// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LocationZpidStruct extends FFFirebaseStruct {
  LocationZpidStruct({
    String? address,
    int? zpid,
    String? addressType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _address = address,
        _zpid = zpid,
        _addressType = addressType,
        super(firestoreUtilData);

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "zpid" field.
  int? _zpid;
  int get zpid => _zpid ?? 0;
  set zpid(int? val) => _zpid = val;

  void incrementZpid(int amount) => zpid = zpid + amount;

  bool hasZpid() => _zpid != null;

  // "addressType" field.
  String? _addressType;
  String get addressType => _addressType ?? '';
  set addressType(String? val) => _addressType = val;

  bool hasAddressType() => _addressType != null;

  static LocationZpidStruct fromMap(Map<String, dynamic> data) =>
      LocationZpidStruct(
        address: data['address'] as String?,
        zpid: castToType<int>(data['zpid']),
        addressType: data['addressType'] as String?,
      );

  static LocationZpidStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationZpidStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'address': _address,
        'zpid': _zpid,
        'addressType': _addressType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'zpid': serializeParam(
          _zpid,
          ParamType.int,
        ),
        'addressType': serializeParam(
          _addressType,
          ParamType.String,
        ),
      }.withoutNulls;

  static LocationZpidStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationZpidStruct(
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        zpid: deserializeParam(
          data['zpid'],
          ParamType.int,
          false,
        ),
        addressType: deserializeParam(
          data['addressType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LocationZpidStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationZpidStruct &&
        address == other.address &&
        zpid == other.zpid &&
        addressType == other.addressType;
  }

  @override
  int get hashCode => const ListEquality().hash([address, zpid, addressType]);
}

LocationZpidStruct createLocationZpidStruct({
  String? address,
  int? zpid,
  String? addressType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationZpidStruct(
      address: address,
      zpid: zpid,
      addressType: addressType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationZpidStruct? updateLocationZpidStruct(
  LocationZpidStruct? locationZpid, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationZpid
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationZpidStructData(
  Map<String, dynamic> firestoreData,
  LocationZpidStruct? locationZpid,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationZpid == null) {
    return;
  }
  if (locationZpid.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationZpid.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationZpidData =
      getLocationZpidFirestoreData(locationZpid, forFieldValue);
  final nestedData =
      locationZpidData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = locationZpid.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationZpidFirestoreData(
  LocationZpidStruct? locationZpid, [
  bool forFieldValue = false,
]) {
  if (locationZpid == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationZpid.toMap());

  // Add any Firestore field values
  locationZpid.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationZpidListFirestoreData(
  List<LocationZpidStruct>? locationZpids,
) =>
    locationZpids?.map((e) => getLocationZpidFirestoreData(e, true)).toList() ??
    [];
