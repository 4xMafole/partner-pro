// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SellerInsertPropertyStruct extends FFFirebaseStruct {
  SellerInsertPropertyStruct({
    String? propertyName,
    MyAddressStruct? address,
    String? bathrooms,
    String? bedrooms,
    String? listDate,
    String? listPrice,
    String? propertyType,
    List<String>? sellerId,
    String? squareFootage,
    String? mlsId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _propertyName = propertyName,
        _address = address,
        _bathrooms = bathrooms,
        _bedrooms = bedrooms,
        _listDate = listDate,
        _listPrice = listPrice,
        _propertyType = propertyType,
        _sellerId = sellerId,
        _squareFootage = squareFootage,
        _mlsId = mlsId,
        super(firestoreUtilData);

  // "property_name" field.
  String? _propertyName;
  String get propertyName => _propertyName ?? '';
  set propertyName(String? val) => _propertyName = val;

  bool hasPropertyName() => _propertyName != null;

  // "address" field.
  MyAddressStruct? _address;
  MyAddressStruct get address => _address ?? MyAddressStruct();
  set address(MyAddressStruct? val) => _address = val;

  void updateAddress(Function(MyAddressStruct) updateFn) {
    updateFn(_address ??= MyAddressStruct());
  }

  bool hasAddress() => _address != null;

  // "bathrooms" field.
  String? _bathrooms;
  String get bathrooms => _bathrooms ?? '';
  set bathrooms(String? val) => _bathrooms = val;

  bool hasBathrooms() => _bathrooms != null;

  // "bedrooms" field.
  String? _bedrooms;
  String get bedrooms => _bedrooms ?? '';
  set bedrooms(String? val) => _bedrooms = val;

  bool hasBedrooms() => _bedrooms != null;

  // "list_date" field.
  String? _listDate;
  String get listDate => _listDate ?? '';
  set listDate(String? val) => _listDate = val;

  bool hasListDate() => _listDate != null;

  // "list_price" field.
  String? _listPrice;
  String get listPrice => _listPrice ?? '';
  set listPrice(String? val) => _listPrice = val;

  bool hasListPrice() => _listPrice != null;

  // "property_type" field.
  String? _propertyType;
  String get propertyType => _propertyType ?? '';
  set propertyType(String? val) => _propertyType = val;

  bool hasPropertyType() => _propertyType != null;

  // "seller_id" field.
  List<String>? _sellerId;
  List<String> get sellerId => _sellerId ?? const [];
  set sellerId(List<String>? val) => _sellerId = val;

  void updateSellerId(Function(List<String>) updateFn) {
    updateFn(_sellerId ??= []);
  }

  bool hasSellerId() => _sellerId != null;

  // "square_footage" field.
  String? _squareFootage;
  String get squareFootage => _squareFootage ?? '';
  set squareFootage(String? val) => _squareFootage = val;

  bool hasSquareFootage() => _squareFootage != null;

  // "mls_id" field.
  String? _mlsId;
  String get mlsId => _mlsId ?? '';
  set mlsId(String? val) => _mlsId = val;

  bool hasMlsId() => _mlsId != null;

  static SellerInsertPropertyStruct fromMap(Map<String, dynamic> data) =>
      SellerInsertPropertyStruct(
        propertyName: data['property_name'] as String?,
        address: data['address'] is MyAddressStruct
            ? data['address']
            : MyAddressStruct.maybeFromMap(data['address']),
        bathrooms: data['bathrooms'] as String?,
        bedrooms: data['bedrooms'] as String?,
        listDate: data['list_date'] as String?,
        listPrice: data['list_price'] as String?,
        propertyType: data['property_type'] as String?,
        sellerId: getDataList(data['seller_id']),
        squareFootage: data['square_footage'] as String?,
        mlsId: data['mls_id'] as String?,
      );

  static SellerInsertPropertyStruct? maybeFromMap(dynamic data) => data is Map
      ? SellerInsertPropertyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'property_name': _propertyName,
        'address': _address?.toMap(),
        'bathrooms': _bathrooms,
        'bedrooms': _bedrooms,
        'list_date': _listDate,
        'list_price': _listPrice,
        'property_type': _propertyType,
        'seller_id': _sellerId,
        'square_footage': _squareFootage,
        'mls_id': _mlsId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'property_name': serializeParam(
          _propertyName,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'bathrooms': serializeParam(
          _bathrooms,
          ParamType.String,
        ),
        'bedrooms': serializeParam(
          _bedrooms,
          ParamType.String,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
        ),
        'list_price': serializeParam(
          _listPrice,
          ParamType.String,
        ),
        'property_type': serializeParam(
          _propertyType,
          ParamType.String,
        ),
        'seller_id': serializeParam(
          _sellerId,
          ParamType.String,
          isList: true,
        ),
        'square_footage': serializeParam(
          _squareFootage,
          ParamType.String,
        ),
        'mls_id': serializeParam(
          _mlsId,
          ParamType.String,
        ),
      }.withoutNulls;

  static SellerInsertPropertyStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SellerInsertPropertyStruct(
        propertyName: deserializeParam(
          data['property_name'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: MyAddressStruct.fromSerializableMap,
        ),
        bathrooms: deserializeParam(
          data['bathrooms'],
          ParamType.String,
          false,
        ),
        bedrooms: deserializeParam(
          data['bedrooms'],
          ParamType.String,
          false,
        ),
        listDate: deserializeParam(
          data['list_date'],
          ParamType.String,
          false,
        ),
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.String,
          false,
        ),
        propertyType: deserializeParam(
          data['property_type'],
          ParamType.String,
          false,
        ),
        sellerId: deserializeParam<String>(
          data['seller_id'],
          ParamType.String,
          true,
        ),
        squareFootage: deserializeParam(
          data['square_footage'],
          ParamType.String,
          false,
        ),
        mlsId: deserializeParam(
          data['mls_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SellerInsertPropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SellerInsertPropertyStruct &&
        propertyName == other.propertyName &&
        address == other.address &&
        bathrooms == other.bathrooms &&
        bedrooms == other.bedrooms &&
        listDate == other.listDate &&
        listPrice == other.listPrice &&
        propertyType == other.propertyType &&
        listEquality.equals(sellerId, other.sellerId) &&
        squareFootage == other.squareFootage &&
        mlsId == other.mlsId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        propertyName,
        address,
        bathrooms,
        bedrooms,
        listDate,
        listPrice,
        propertyType,
        sellerId,
        squareFootage,
        mlsId
      ]);
}

SellerInsertPropertyStruct createSellerInsertPropertyStruct({
  String? propertyName,
  MyAddressStruct? address,
  String? bathrooms,
  String? bedrooms,
  String? listDate,
  String? listPrice,
  String? propertyType,
  String? squareFootage,
  String? mlsId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SellerInsertPropertyStruct(
      propertyName: propertyName,
      address: address ?? (clearUnsetFields ? MyAddressStruct() : null),
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      listDate: listDate,
      listPrice: listPrice,
      propertyType: propertyType,
      squareFootage: squareFootage,
      mlsId: mlsId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SellerInsertPropertyStruct? updateSellerInsertPropertyStruct(
  SellerInsertPropertyStruct? sellerInsertProperty, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sellerInsertProperty
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSellerInsertPropertyStructData(
  Map<String, dynamic> firestoreData,
  SellerInsertPropertyStruct? sellerInsertProperty,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sellerInsertProperty == null) {
    return;
  }
  if (sellerInsertProperty.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && sellerInsertProperty.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sellerInsertPropertyData =
      getSellerInsertPropertyFirestoreData(sellerInsertProperty, forFieldValue);
  final nestedData =
      sellerInsertPropertyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      sellerInsertProperty.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSellerInsertPropertyFirestoreData(
  SellerInsertPropertyStruct? sellerInsertProperty, [
  bool forFieldValue = false,
]) {
  if (sellerInsertProperty == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sellerInsertProperty.toMap());

  // Handle nested data for "address" field.
  addMyAddressStructData(
    firestoreData,
    sellerInsertProperty.hasAddress() ? sellerInsertProperty.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  sellerInsertProperty.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSellerInsertPropertyListFirestoreData(
  List<SellerInsertPropertyStruct>? sellerInsertPropertys,
) =>
    sellerInsertPropertys
        ?.map((e) => getSellerInsertPropertyFirestoreData(e, true))
        .toList() ??
    [];
