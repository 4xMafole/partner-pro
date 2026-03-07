// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NearbyHomesStruct extends FFFirebaseStruct {
  NearbyHomesStruct({
    int? livingArea,
    int? livingAreaValue,
    String? lotAreaUnits,
    double? lotAreaValue,
    int? lotSize,
    List<MiniCardPhotosStruct>? miniCardPhotos,
    int? zpid,
    double? longitude,
    String? livingAreaUnits,
    Address1Struct? address,
    String? livingAreaUnitsShort,
    int? price,
    String? homeType,
    String? homeStatus,
    String? currency,
    double? latitude,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _livingArea = livingArea,
        _livingAreaValue = livingAreaValue,
        _lotAreaUnits = lotAreaUnits,
        _lotAreaValue = lotAreaValue,
        _lotSize = lotSize,
        _miniCardPhotos = miniCardPhotos,
        _zpid = zpid,
        _longitude = longitude,
        _livingAreaUnits = livingAreaUnits,
        _address = address,
        _livingAreaUnitsShort = livingAreaUnitsShort,
        _price = price,
        _homeType = homeType,
        _homeStatus = homeStatus,
        _currency = currency,
        _latitude = latitude,
        super(firestoreUtilData);

  // "livingArea" field.
  int? _livingArea;
  int get livingArea => _livingArea ?? 0;
  set livingArea(int? val) => _livingArea = val;

  void incrementLivingArea(int amount) => livingArea = livingArea + amount;

  bool hasLivingArea() => _livingArea != null;

  // "livingAreaValue" field.
  int? _livingAreaValue;
  int get livingAreaValue => _livingAreaValue ?? 0;
  set livingAreaValue(int? val) => _livingAreaValue = val;

  void incrementLivingAreaValue(int amount) =>
      livingAreaValue = livingAreaValue + amount;

  bool hasLivingAreaValue() => _livingAreaValue != null;

  // "lotAreaUnits" field.
  String? _lotAreaUnits;
  String get lotAreaUnits => _lotAreaUnits ?? '';
  set lotAreaUnits(String? val) => _lotAreaUnits = val;

  bool hasLotAreaUnits() => _lotAreaUnits != null;

  // "lotAreaValue" field.
  double? _lotAreaValue;
  double get lotAreaValue => _lotAreaValue ?? 0.0;
  set lotAreaValue(double? val) => _lotAreaValue = val;

  void incrementLotAreaValue(double amount) =>
      lotAreaValue = lotAreaValue + amount;

  bool hasLotAreaValue() => _lotAreaValue != null;

  // "lotSize" field.
  int? _lotSize;
  int get lotSize => _lotSize ?? 0;
  set lotSize(int? val) => _lotSize = val;

  void incrementLotSize(int amount) => lotSize = lotSize + amount;

  bool hasLotSize() => _lotSize != null;

  // "miniCardPhotos" field.
  List<MiniCardPhotosStruct>? _miniCardPhotos;
  List<MiniCardPhotosStruct> get miniCardPhotos => _miniCardPhotos ?? const [];
  set miniCardPhotos(List<MiniCardPhotosStruct>? val) => _miniCardPhotos = val;

  void updateMiniCardPhotos(Function(List<MiniCardPhotosStruct>) updateFn) {
    updateFn(_miniCardPhotos ??= []);
  }

  bool hasMiniCardPhotos() => _miniCardPhotos != null;

  // "zpid" field.
  int? _zpid;
  int get zpid => _zpid ?? 0;
  set zpid(int? val) => _zpid = val;

  void incrementZpid(int amount) => zpid = zpid + amount;

  bool hasZpid() => _zpid != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  set longitude(double? val) => _longitude = val;

  void incrementLongitude(double amount) => longitude = longitude + amount;

  bool hasLongitude() => _longitude != null;

  // "livingAreaUnits" field.
  String? _livingAreaUnits;
  String get livingAreaUnits => _livingAreaUnits ?? '';
  set livingAreaUnits(String? val) => _livingAreaUnits = val;

  bool hasLivingAreaUnits() => _livingAreaUnits != null;

  // "address" field.
  Address1Struct? _address;
  Address1Struct get address => _address ?? Address1Struct();
  set address(Address1Struct? val) => _address = val;

  void updateAddress(Function(Address1Struct) updateFn) {
    updateFn(_address ??= Address1Struct());
  }

  bool hasAddress() => _address != null;

  // "livingAreaUnitsShort" field.
  String? _livingAreaUnitsShort;
  String get livingAreaUnitsShort => _livingAreaUnitsShort ?? '';
  set livingAreaUnitsShort(String? val) => _livingAreaUnitsShort = val;

  bool hasLivingAreaUnitsShort() => _livingAreaUnitsShort != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "homeType" field.
  String? _homeType;
  String get homeType => _homeType ?? '';
  set homeType(String? val) => _homeType = val;

  bool hasHomeType() => _homeType != null;

  // "homeStatus" field.
  String? _homeStatus;
  String get homeStatus => _homeStatus ?? '';
  set homeStatus(String? val) => _homeStatus = val;

  bool hasHomeStatus() => _homeStatus != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  set latitude(double? val) => _latitude = val;

  void incrementLatitude(double amount) => latitude = latitude + amount;

  bool hasLatitude() => _latitude != null;

  static NearbyHomesStruct fromMap(Map<String, dynamic> data) =>
      NearbyHomesStruct(
        livingArea: castToType<int>(data['livingArea']),
        livingAreaValue: castToType<int>(data['livingAreaValue']),
        lotAreaUnits: data['lotAreaUnits'] as String?,
        lotAreaValue: castToType<double>(data['lotAreaValue']),
        lotSize: castToType<int>(data['lotSize']),
        miniCardPhotos: getStructList(
          data['miniCardPhotos'],
          MiniCardPhotosStruct.fromMap,
        ),
        zpid: castToType<int>(data['zpid']),
        longitude: castToType<double>(data['longitude']),
        livingAreaUnits: data['livingAreaUnits'] as String?,
        address: data['address'] is Address1Struct
            ? data['address']
            : Address1Struct.maybeFromMap(data['address']),
        livingAreaUnitsShort: data['livingAreaUnitsShort'] as String?,
        price: castToType<int>(data['price']),
        homeType: data['homeType'] as String?,
        homeStatus: data['homeStatus'] as String?,
        currency: data['currency'] as String?,
        latitude: castToType<double>(data['latitude']),
      );

  static NearbyHomesStruct? maybeFromMap(dynamic data) => data is Map
      ? NearbyHomesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'livingArea': _livingArea,
        'livingAreaValue': _livingAreaValue,
        'lotAreaUnits': _lotAreaUnits,
        'lotAreaValue': _lotAreaValue,
        'lotSize': _lotSize,
        'miniCardPhotos': _miniCardPhotos?.map((e) => e.toMap()).toList(),
        'zpid': _zpid,
        'longitude': _longitude,
        'livingAreaUnits': _livingAreaUnits,
        'address': _address?.toMap(),
        'livingAreaUnitsShort': _livingAreaUnitsShort,
        'price': _price,
        'homeType': _homeType,
        'homeStatus': _homeStatus,
        'currency': _currency,
        'latitude': _latitude,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'livingArea': serializeParam(
          _livingArea,
          ParamType.int,
        ),
        'livingAreaValue': serializeParam(
          _livingAreaValue,
          ParamType.int,
        ),
        'lotAreaUnits': serializeParam(
          _lotAreaUnits,
          ParamType.String,
        ),
        'lotAreaValue': serializeParam(
          _lotAreaValue,
          ParamType.double,
        ),
        'lotSize': serializeParam(
          _lotSize,
          ParamType.int,
        ),
        'miniCardPhotos': serializeParam(
          _miniCardPhotos,
          ParamType.DataStruct,
          isList: true,
        ),
        'zpid': serializeParam(
          _zpid,
          ParamType.int,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'livingAreaUnits': serializeParam(
          _livingAreaUnits,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'livingAreaUnitsShort': serializeParam(
          _livingAreaUnitsShort,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'homeType': serializeParam(
          _homeType,
          ParamType.String,
        ),
        'homeStatus': serializeParam(
          _homeStatus,
          ParamType.String,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
      }.withoutNulls;

  static NearbyHomesStruct fromSerializableMap(Map<String, dynamic> data) =>
      NearbyHomesStruct(
        livingArea: deserializeParam(
          data['livingArea'],
          ParamType.int,
          false,
        ),
        livingAreaValue: deserializeParam(
          data['livingAreaValue'],
          ParamType.int,
          false,
        ),
        lotAreaUnits: deserializeParam(
          data['lotAreaUnits'],
          ParamType.String,
          false,
        ),
        lotAreaValue: deserializeParam(
          data['lotAreaValue'],
          ParamType.double,
          false,
        ),
        lotSize: deserializeParam(
          data['lotSize'],
          ParamType.int,
          false,
        ),
        miniCardPhotos: deserializeStructParam<MiniCardPhotosStruct>(
          data['miniCardPhotos'],
          ParamType.DataStruct,
          true,
          structBuilder: MiniCardPhotosStruct.fromSerializableMap,
        ),
        zpid: deserializeParam(
          data['zpid'],
          ParamType.int,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.double,
          false,
        ),
        livingAreaUnits: deserializeParam(
          data['livingAreaUnits'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: Address1Struct.fromSerializableMap,
        ),
        livingAreaUnitsShort: deserializeParam(
          data['livingAreaUnitsShort'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        homeType: deserializeParam(
          data['homeType'],
          ParamType.String,
          false,
        ),
        homeStatus: deserializeParam(
          data['homeStatus'],
          ParamType.String,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'NearbyHomesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NearbyHomesStruct &&
        livingArea == other.livingArea &&
        livingAreaValue == other.livingAreaValue &&
        lotAreaUnits == other.lotAreaUnits &&
        lotAreaValue == other.lotAreaValue &&
        lotSize == other.lotSize &&
        listEquality.equals(miniCardPhotos, other.miniCardPhotos) &&
        zpid == other.zpid &&
        longitude == other.longitude &&
        livingAreaUnits == other.livingAreaUnits &&
        address == other.address &&
        livingAreaUnitsShort == other.livingAreaUnitsShort &&
        price == other.price &&
        homeType == other.homeType &&
        homeStatus == other.homeStatus &&
        currency == other.currency &&
        latitude == other.latitude;
  }

  @override
  int get hashCode => const ListEquality().hash([
        livingArea,
        livingAreaValue,
        lotAreaUnits,
        lotAreaValue,
        lotSize,
        miniCardPhotos,
        zpid,
        longitude,
        livingAreaUnits,
        address,
        livingAreaUnitsShort,
        price,
        homeType,
        homeStatus,
        currency,
        latitude
      ]);
}

NearbyHomesStruct createNearbyHomesStruct({
  int? livingArea,
  int? livingAreaValue,
  String? lotAreaUnits,
  double? lotAreaValue,
  int? lotSize,
  int? zpid,
  double? longitude,
  String? livingAreaUnits,
  Address1Struct? address,
  String? livingAreaUnitsShort,
  int? price,
  String? homeType,
  String? homeStatus,
  String? currency,
  double? latitude,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NearbyHomesStruct(
      livingArea: livingArea,
      livingAreaValue: livingAreaValue,
      lotAreaUnits: lotAreaUnits,
      lotAreaValue: lotAreaValue,
      lotSize: lotSize,
      zpid: zpid,
      longitude: longitude,
      livingAreaUnits: livingAreaUnits,
      address: address ?? (clearUnsetFields ? Address1Struct() : null),
      livingAreaUnitsShort: livingAreaUnitsShort,
      price: price,
      homeType: homeType,
      homeStatus: homeStatus,
      currency: currency,
      latitude: latitude,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NearbyHomesStruct? updateNearbyHomesStruct(
  NearbyHomesStruct? nearbyHomes, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nearbyHomes
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNearbyHomesStructData(
  Map<String, dynamic> firestoreData,
  NearbyHomesStruct? nearbyHomes,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nearbyHomes == null) {
    return;
  }
  if (nearbyHomes.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nearbyHomes.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nearbyHomesData =
      getNearbyHomesFirestoreData(nearbyHomes, forFieldValue);
  final nestedData =
      nearbyHomesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nearbyHomes.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNearbyHomesFirestoreData(
  NearbyHomesStruct? nearbyHomes, [
  bool forFieldValue = false,
]) {
  if (nearbyHomes == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nearbyHomes.toMap());

  // Handle nested data for "address" field.
  addAddress1StructData(
    firestoreData,
    nearbyHomes.hasAddress() ? nearbyHomes.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  nearbyHomes.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNearbyHomesListFirestoreData(
  List<NearbyHomesStruct>? nearbyHomess,
) =>
    nearbyHomess?.map((e) => getNearbyHomesFirestoreData(e, true)).toList() ??
    [];
