// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TestModelStruct extends FFFirebaseStruct {
  TestModelStruct({
    int? id,
    String? propertyName,
    Address1Struct? address,
    String? countyParishPrecinct,
    String? hoa,
    int? listPrice,
    String? lotSize,
    List<String>? media,
    String? notes,
    String? propertyType,
    String? squareFootage,
    String? mlsId,
    int? yearBuilt,
    double? latitude,
    double? longitude,
    List<String>? sellerId,
    bool? listAsIs,
    bool? inContract,
    bool? isPending,
    bool? listNegotiable,
    bool? listPriceReduction,
    bool? isSold,
    String? lastUpdatedDate,
    String? updatedBy,
    String? createdAt,
    String? listDate,
    double? bedrooms,
    double? bathrooms,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _propertyName = propertyName,
        _address = address,
        _countyParishPrecinct = countyParishPrecinct,
        _hoa = hoa,
        _listPrice = listPrice,
        _lotSize = lotSize,
        _media = media,
        _notes = notes,
        _propertyType = propertyType,
        _squareFootage = squareFootage,
        _mlsId = mlsId,
        _yearBuilt = yearBuilt,
        _latitude = latitude,
        _longitude = longitude,
        _sellerId = sellerId,
        _listAsIs = listAsIs,
        _inContract = inContract,
        _isPending = isPending,
        _listNegotiable = listNegotiable,
        _listPriceReduction = listPriceReduction,
        _isSold = isSold,
        _lastUpdatedDate = lastUpdatedDate,
        _updatedBy = updatedBy,
        _createdAt = createdAt,
        _listDate = listDate,
        _bedrooms = bedrooms,
        _bathrooms = bathrooms,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "property_name" field.
  String? _propertyName;
  String get propertyName => _propertyName ?? '';
  set propertyName(String? val) => _propertyName = val;

  bool hasPropertyName() => _propertyName != null;

  // "address" field.
  Address1Struct? _address;
  Address1Struct get address => _address ?? Address1Struct();
  set address(Address1Struct? val) => _address = val;

  void updateAddress(Function(Address1Struct) updateFn) {
    updateFn(_address ??= Address1Struct());
  }

  bool hasAddress() => _address != null;

  // "county_parish_precinct" field.
  String? _countyParishPrecinct;
  String get countyParishPrecinct => _countyParishPrecinct ?? '';
  set countyParishPrecinct(String? val) => _countyParishPrecinct = val;

  bool hasCountyParishPrecinct() => _countyParishPrecinct != null;

  // "hoa" field.
  String? _hoa;
  String get hoa => _hoa ?? '';
  set hoa(String? val) => _hoa = val;

  bool hasHoa() => _hoa != null;

  // "list_price" field.
  int? _listPrice;
  int get listPrice => _listPrice ?? 0;
  set listPrice(int? val) => _listPrice = val;

  void incrementListPrice(int amount) => listPrice = listPrice + amount;

  bool hasListPrice() => _listPrice != null;

  // "lot_size" field.
  String? _lotSize;
  String get lotSize => _lotSize ?? '';
  set lotSize(String? val) => _lotSize = val;

  bool hasLotSize() => _lotSize != null;

  // "media" field.
  List<String>? _media;
  List<String> get media => _media ?? const [];
  set media(List<String>? val) => _media = val;

  void updateMedia(Function(List<String>) updateFn) {
    updateFn(_media ??= []);
  }

  bool hasMedia() => _media != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "property_type" field.
  String? _propertyType;
  String get propertyType => _propertyType ?? '';
  set propertyType(String? val) => _propertyType = val;

  bool hasPropertyType() => _propertyType != null;

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

  // "year_built" field.
  int? _yearBuilt;
  int get yearBuilt => _yearBuilt ?? 0;
  set yearBuilt(int? val) => _yearBuilt = val;

  void incrementYearBuilt(int amount) => yearBuilt = yearBuilt + amount;

  bool hasYearBuilt() => _yearBuilt != null;

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

  // "seller_id" field.
  List<String>? _sellerId;
  List<String> get sellerId => _sellerId ?? const [];
  set sellerId(List<String>? val) => _sellerId = val;

  void updateSellerId(Function(List<String>) updateFn) {
    updateFn(_sellerId ??= []);
  }

  bool hasSellerId() => _sellerId != null;

  // "list_as_is" field.
  bool? _listAsIs;
  bool get listAsIs => _listAsIs ?? false;
  set listAsIs(bool? val) => _listAsIs = val;

  bool hasListAsIs() => _listAsIs != null;

  // "in_contract" field.
  bool? _inContract;
  bool get inContract => _inContract ?? false;
  set inContract(bool? val) => _inContract = val;

  bool hasInContract() => _inContract != null;

  // "is_pending" field.
  bool? _isPending;
  bool get isPending => _isPending ?? false;
  set isPending(bool? val) => _isPending = val;

  bool hasIsPending() => _isPending != null;

  // "list_negotiable" field.
  bool? _listNegotiable;
  bool get listNegotiable => _listNegotiable ?? false;
  set listNegotiable(bool? val) => _listNegotiable = val;

  bool hasListNegotiable() => _listNegotiable != null;

  // "list_price_reduction" field.
  bool? _listPriceReduction;
  bool get listPriceReduction => _listPriceReduction ?? false;
  set listPriceReduction(bool? val) => _listPriceReduction = val;

  bool hasListPriceReduction() => _listPriceReduction != null;

  // "is_sold" field.
  bool? _isSold;
  bool get isSold => _isSold ?? false;
  set isSold(bool? val) => _isSold = val;

  bool hasIsSold() => _isSold != null;

  // "last_updated_date" field.
  String? _lastUpdatedDate;
  String get lastUpdatedDate => _lastUpdatedDate ?? '';
  set lastUpdatedDate(String? val) => _lastUpdatedDate = val;

  bool hasLastUpdatedDate() => _lastUpdatedDate != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "list_date" field.
  String? _listDate;
  String get listDate => _listDate ?? '';
  set listDate(String? val) => _listDate = val;

  bool hasListDate() => _listDate != null;

  // "bedrooms" field.
  double? _bedrooms;
  double get bedrooms => _bedrooms ?? 0.0;
  set bedrooms(double? val) => _bedrooms = val;

  void incrementBedrooms(double amount) => bedrooms = bedrooms + amount;

  bool hasBedrooms() => _bedrooms != null;

  // "bathrooms" field.
  double? _bathrooms;
  double get bathrooms => _bathrooms ?? 0.0;
  set bathrooms(double? val) => _bathrooms = val;

  void incrementBathrooms(double amount) => bathrooms = bathrooms + amount;

  bool hasBathrooms() => _bathrooms != null;

  static TestModelStruct fromMap(Map<String, dynamic> data) => TestModelStruct(
        id: castToType<int>(data['id']),
        propertyName: data['property_name'] as String?,
        address: data['address'] is Address1Struct
            ? data['address']
            : Address1Struct.maybeFromMap(data['address']),
        countyParishPrecinct: data['county_parish_precinct'] as String?,
        hoa: data['hoa'] as String?,
        listPrice: castToType<int>(data['list_price']),
        lotSize: data['lot_size'] as String?,
        media: getDataList(data['media']),
        notes: data['notes'] as String?,
        propertyType: data['property_type'] as String?,
        squareFootage: data['square_footage'] as String?,
        mlsId: data['mls_id'] as String?,
        yearBuilt: castToType<int>(data['year_built']),
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        sellerId: getDataList(data['seller_id']),
        listAsIs: data['list_as_is'] as bool?,
        inContract: data['in_contract'] as bool?,
        isPending: data['is_pending'] as bool?,
        listNegotiable: data['list_negotiable'] as bool?,
        listPriceReduction: data['list_price_reduction'] as bool?,
        isSold: data['is_sold'] as bool?,
        lastUpdatedDate: data['last_updated_date'] as String?,
        updatedBy: data['updated_by'] as String?,
        createdAt: data['created_at'] as String?,
        listDate: data['list_date'] as String?,
        bedrooms: castToType<double>(data['bedrooms']),
        bathrooms: castToType<double>(data['bathrooms']),
      );

  static TestModelStruct? maybeFromMap(dynamic data) => data is Map
      ? TestModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'property_name': _propertyName,
        'address': _address?.toMap(),
        'county_parish_precinct': _countyParishPrecinct,
        'hoa': _hoa,
        'list_price': _listPrice,
        'lot_size': _lotSize,
        'media': _media,
        'notes': _notes,
        'property_type': _propertyType,
        'square_footage': _squareFootage,
        'mls_id': _mlsId,
        'year_built': _yearBuilt,
        'latitude': _latitude,
        'longitude': _longitude,
        'seller_id': _sellerId,
        'list_as_is': _listAsIs,
        'in_contract': _inContract,
        'is_pending': _isPending,
        'list_negotiable': _listNegotiable,
        'list_price_reduction': _listPriceReduction,
        'is_sold': _isSold,
        'last_updated_date': _lastUpdatedDate,
        'updated_by': _updatedBy,
        'created_at': _createdAt,
        'list_date': _listDate,
        'bedrooms': _bedrooms,
        'bathrooms': _bathrooms,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'property_name': serializeParam(
          _propertyName,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'county_parish_precinct': serializeParam(
          _countyParishPrecinct,
          ParamType.String,
        ),
        'hoa': serializeParam(
          _hoa,
          ParamType.String,
        ),
        'list_price': serializeParam(
          _listPrice,
          ParamType.int,
        ),
        'lot_size': serializeParam(
          _lotSize,
          ParamType.String,
        ),
        'media': serializeParam(
          _media,
          ParamType.String,
          isList: true,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
        'property_type': serializeParam(
          _propertyType,
          ParamType.String,
        ),
        'square_footage': serializeParam(
          _squareFootage,
          ParamType.String,
        ),
        'mls_id': serializeParam(
          _mlsId,
          ParamType.String,
        ),
        'year_built': serializeParam(
          _yearBuilt,
          ParamType.int,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'seller_id': serializeParam(
          _sellerId,
          ParamType.String,
          isList: true,
        ),
        'list_as_is': serializeParam(
          _listAsIs,
          ParamType.bool,
        ),
        'in_contract': serializeParam(
          _inContract,
          ParamType.bool,
        ),
        'is_pending': serializeParam(
          _isPending,
          ParamType.bool,
        ),
        'list_negotiable': serializeParam(
          _listNegotiable,
          ParamType.bool,
        ),
        'list_price_reduction': serializeParam(
          _listPriceReduction,
          ParamType.bool,
        ),
        'is_sold': serializeParam(
          _isSold,
          ParamType.bool,
        ),
        'last_updated_date': serializeParam(
          _lastUpdatedDate,
          ParamType.String,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
        ),
        'bedrooms': serializeParam(
          _bedrooms,
          ParamType.double,
        ),
        'bathrooms': serializeParam(
          _bathrooms,
          ParamType.double,
        ),
      }.withoutNulls;

  static TestModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      TestModelStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        propertyName: deserializeParam(
          data['property_name'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: Address1Struct.fromSerializableMap,
        ),
        countyParishPrecinct: deserializeParam(
          data['county_parish_precinct'],
          ParamType.String,
          false,
        ),
        hoa: deserializeParam(
          data['hoa'],
          ParamType.String,
          false,
        ),
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.int,
          false,
        ),
        lotSize: deserializeParam(
          data['lot_size'],
          ParamType.String,
          false,
        ),
        media: deserializeParam<String>(
          data['media'],
          ParamType.String,
          true,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
        propertyType: deserializeParam(
          data['property_type'],
          ParamType.String,
          false,
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
        yearBuilt: deserializeParam(
          data['year_built'],
          ParamType.int,
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
        sellerId: deserializeParam<String>(
          data['seller_id'],
          ParamType.String,
          true,
        ),
        listAsIs: deserializeParam(
          data['list_as_is'],
          ParamType.bool,
          false,
        ),
        inContract: deserializeParam(
          data['in_contract'],
          ParamType.bool,
          false,
        ),
        isPending: deserializeParam(
          data['is_pending'],
          ParamType.bool,
          false,
        ),
        listNegotiable: deserializeParam(
          data['list_negotiable'],
          ParamType.bool,
          false,
        ),
        listPriceReduction: deserializeParam(
          data['list_price_reduction'],
          ParamType.bool,
          false,
        ),
        isSold: deserializeParam(
          data['is_sold'],
          ParamType.bool,
          false,
        ),
        lastUpdatedDate: deserializeParam(
          data['last_updated_date'],
          ParamType.String,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        listDate: deserializeParam(
          data['list_date'],
          ParamType.String,
          false,
        ),
        bedrooms: deserializeParam(
          data['bedrooms'],
          ParamType.double,
          false,
        ),
        bathrooms: deserializeParam(
          data['bathrooms'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'TestModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TestModelStruct &&
        id == other.id &&
        propertyName == other.propertyName &&
        address == other.address &&
        countyParishPrecinct == other.countyParishPrecinct &&
        hoa == other.hoa &&
        listPrice == other.listPrice &&
        lotSize == other.lotSize &&
        listEquality.equals(media, other.media) &&
        notes == other.notes &&
        propertyType == other.propertyType &&
        squareFootage == other.squareFootage &&
        mlsId == other.mlsId &&
        yearBuilt == other.yearBuilt &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        listEquality.equals(sellerId, other.sellerId) &&
        listAsIs == other.listAsIs &&
        inContract == other.inContract &&
        isPending == other.isPending &&
        listNegotiable == other.listNegotiable &&
        listPriceReduction == other.listPriceReduction &&
        isSold == other.isSold &&
        lastUpdatedDate == other.lastUpdatedDate &&
        updatedBy == other.updatedBy &&
        createdAt == other.createdAt &&
        listDate == other.listDate &&
        bedrooms == other.bedrooms &&
        bathrooms == other.bathrooms;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        propertyName,
        address,
        countyParishPrecinct,
        hoa,
        listPrice,
        lotSize,
        media,
        notes,
        propertyType,
        squareFootage,
        mlsId,
        yearBuilt,
        latitude,
        longitude,
        sellerId,
        listAsIs,
        inContract,
        isPending,
        listNegotiable,
        listPriceReduction,
        isSold,
        lastUpdatedDate,
        updatedBy,
        createdAt,
        listDate,
        bedrooms,
        bathrooms
      ]);
}

TestModelStruct createTestModelStruct({
  int? id,
  String? propertyName,
  Address1Struct? address,
  String? countyParishPrecinct,
  String? hoa,
  int? listPrice,
  String? lotSize,
  String? notes,
  String? propertyType,
  String? squareFootage,
  String? mlsId,
  int? yearBuilt,
  double? latitude,
  double? longitude,
  bool? listAsIs,
  bool? inContract,
  bool? isPending,
  bool? listNegotiable,
  bool? listPriceReduction,
  bool? isSold,
  String? lastUpdatedDate,
  String? updatedBy,
  String? createdAt,
  String? listDate,
  double? bedrooms,
  double? bathrooms,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TestModelStruct(
      id: id,
      propertyName: propertyName,
      address: address ?? (clearUnsetFields ? Address1Struct() : null),
      countyParishPrecinct: countyParishPrecinct,
      hoa: hoa,
      listPrice: listPrice,
      lotSize: lotSize,
      notes: notes,
      propertyType: propertyType,
      squareFootage: squareFootage,
      mlsId: mlsId,
      yearBuilt: yearBuilt,
      latitude: latitude,
      longitude: longitude,
      listAsIs: listAsIs,
      inContract: inContract,
      isPending: isPending,
      listNegotiable: listNegotiable,
      listPriceReduction: listPriceReduction,
      isSold: isSold,
      lastUpdatedDate: lastUpdatedDate,
      updatedBy: updatedBy,
      createdAt: createdAt,
      listDate: listDate,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TestModelStruct? updateTestModelStruct(
  TestModelStruct? testModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    testModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTestModelStructData(
  Map<String, dynamic> firestoreData,
  TestModelStruct? testModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (testModel == null) {
    return;
  }
  if (testModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && testModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final testModelData = getTestModelFirestoreData(testModel, forFieldValue);
  final nestedData = testModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = testModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTestModelFirestoreData(
  TestModelStruct? testModel, [
  bool forFieldValue = false,
]) {
  if (testModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(testModel.toMap());

  // Handle nested data for "address" field.
  addAddress1StructData(
    firestoreData,
    testModel.hasAddress() ? testModel.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  testModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTestModelListFirestoreData(
  List<TestModelStruct>? testModels,
) =>
    testModels?.map((e) => getTestModelFirestoreData(e, true)).toList() ?? [];
