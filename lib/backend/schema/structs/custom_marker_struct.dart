// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomMarkerStruct extends FFFirebaseStruct {
  CustomMarkerStruct({
    String? id,
    double? latitude,
    double? longitude,
    String? price,
    List<String>? propertyImages,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _latitude = latitude,
        _longitude = longitude,
        _price = price,
        _propertyImages = propertyImages,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  set latitude(double? val) => _latitude = val;

  void incrementLatitude(double amount) => latitude = latitude + amount;

  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  set longitude(double? val) => _longitude = val;

  void incrementLongitude(double amount) => longitude = longitude + amount;

  bool hasLongitude() => _longitude != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  set price(String? val) => _price = val;

  bool hasPrice() => _price != null;

  // "property_images" field.
  List<String>? _propertyImages;
  List<String> get propertyImages => _propertyImages ?? const [];
  set propertyImages(List<String>? val) => _propertyImages = val;

  void updatePropertyImages(Function(List<String>) updateFn) {
    updateFn(_propertyImages ??= []);
  }

  bool hasPropertyImages() => _propertyImages != null;

  static CustomMarkerStruct fromMap(Map<String, dynamic> data) =>
      CustomMarkerStruct(
        id: data['id'] as String?,
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        price: data['price'] as String?,
        propertyImages: getDataList(data['property_images']),
      );

  static CustomMarkerStruct? maybeFromMap(dynamic data) => data is Map
      ? CustomMarkerStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'latitude': _latitude,
        'longitude': _longitude,
        'price': _price,
        'property_images': _propertyImages,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'price': serializeParam(
          _price,
          ParamType.String,
        ),
        'property_images': serializeParam(
          _propertyImages,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static CustomMarkerStruct fromSerializableMap(Map<String, dynamic> data) =>
      CustomMarkerStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.double,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.double,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.String,
          false,
        ),
        propertyImages: deserializeParam<String>(
          data['property_images'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'CustomMarkerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CustomMarkerStruct &&
        id == other.id &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        price == other.price &&
        listEquality.equals(propertyImages, other.propertyImages);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, latitude, longitude, price, propertyImages]);
}

CustomMarkerStruct createCustomMarkerStruct({
  String? id,
  double? latitude,
  double? longitude,
  String? price,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CustomMarkerStruct(
      id: id,
      latitude: latitude,
      longitude: longitude,
      price: price,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CustomMarkerStruct? updateCustomMarkerStruct(
  CustomMarkerStruct? customMarker, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    customMarker
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCustomMarkerStructData(
  Map<String, dynamic> firestoreData,
  CustomMarkerStruct? customMarker,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (customMarker == null) {
    return;
  }
  if (customMarker.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && customMarker.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final customMarkerData =
      getCustomMarkerFirestoreData(customMarker, forFieldValue);
  final nestedData =
      customMarkerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = customMarker.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCustomMarkerFirestoreData(
  CustomMarkerStruct? customMarker, [
  bool forFieldValue = false,
]) {
  if (customMarker == null) {
    return {};
  }
  final firestoreData = mapToFirestore(customMarker.toMap());

  // Add any Firestore field values
  customMarker.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCustomMarkerListFirestoreData(
  List<CustomMarkerStruct>? customMarkers,
) =>
    customMarkers?.map((e) => getCustomMarkerFirestoreData(e, true)).toList() ??
    [];
