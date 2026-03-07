// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertyModelStruct extends FFFirebaseStruct {
  PropertyModelStruct({
    String? id,
    String? propertyName,
    Address1Struct? address,
    List<String>? countyParishPrecinct,
    String? createdAt,
    String? hoa,
    bool? isDeletedByUser,
    String? listDate,
    String? lotSize,
    List<String>? media,
    String? notes,
    String? propertyType,
    List<String>? sellerId,
    bool? status,
    bool? listAsIs,
    bool? inContract,
    bool? isPending,
    bool? listNegotiable,
    bool? listPriceReduction,
    bool? isSold,
    String? lastUpdatedDate,
    int? mlsId,
    String? updatedBy,
    double? latitude,
    double? longitude,
    int? listPrice,
    int? bathrooms,
    int? bedrooms,
    String? squareFootage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _propertyName = propertyName,
        _address = address,
        _countyParishPrecinct = countyParishPrecinct,
        _createdAt = createdAt,
        _hoa = hoa,
        _isDeletedByUser = isDeletedByUser,
        _listDate = listDate,
        _lotSize = lotSize,
        _media = media,
        _notes = notes,
        _propertyType = propertyType,
        _sellerId = sellerId,
        _status = status,
        _listAsIs = listAsIs,
        _inContract = inContract,
        _isPending = isPending,
        _listNegotiable = listNegotiable,
        _listPriceReduction = listPriceReduction,
        _isSold = isSold,
        _lastUpdatedDate = lastUpdatedDate,
        _mlsId = mlsId,
        _updatedBy = updatedBy,
        _latitude = latitude,
        _longitude = longitude,
        _listPrice = listPrice,
        _bathrooms = bathrooms,
        _bedrooms = bedrooms,
        _squareFootage = squareFootage,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

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
  List<String>? _countyParishPrecinct;
  List<String> get countyParishPrecinct => _countyParishPrecinct ?? const [];
  set countyParishPrecinct(List<String>? val) => _countyParishPrecinct = val;

  void updateCountyParishPrecinct(Function(List<String>) updateFn) {
    updateFn(_countyParishPrecinct ??= []);
  }

  bool hasCountyParishPrecinct() => _countyParishPrecinct != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "hoa" field.
  String? _hoa;
  String get hoa => _hoa ?? '';
  set hoa(String? val) => _hoa = val;

  bool hasHoa() => _hoa != null;

  // "is_deleted_by_user" field.
  bool? _isDeletedByUser;
  bool get isDeletedByUser => _isDeletedByUser ?? false;
  set isDeletedByUser(bool? val) => _isDeletedByUser = val;

  bool hasIsDeletedByUser() => _isDeletedByUser != null;

  // "list_date" field.
  String? _listDate;
  String get listDate => _listDate ?? '';
  set listDate(String? val) => _listDate = val;

  bool hasListDate() => _listDate != null;

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

  // "seller_id" field.
  List<String>? _sellerId;
  List<String> get sellerId => _sellerId ?? const [];
  set sellerId(List<String>? val) => _sellerId = val;

  void updateSellerId(Function(List<String>) updateFn) {
    updateFn(_sellerId ??= []);
  }

  bool hasSellerId() => _sellerId != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

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

  // "mls_id" field.
  int? _mlsId;
  int get mlsId => _mlsId ?? 0;
  set mlsId(int? val) => _mlsId = val;

  void incrementMlsId(int amount) => mlsId = mlsId + amount;

  bool hasMlsId() => _mlsId != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

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

  // "list_price" field.
  int? _listPrice;
  int get listPrice => _listPrice ?? 0;
  set listPrice(int? val) => _listPrice = val;

  void incrementListPrice(int amount) => listPrice = listPrice + amount;

  bool hasListPrice() => _listPrice != null;

  // "bathrooms" field.
  int? _bathrooms;
  int get bathrooms => _bathrooms ?? 0;
  set bathrooms(int? val) => _bathrooms = val;

  void incrementBathrooms(int amount) => bathrooms = bathrooms + amount;

  bool hasBathrooms() => _bathrooms != null;

  // "bedrooms" field.
  int? _bedrooms;
  int get bedrooms => _bedrooms ?? 0;
  set bedrooms(int? val) => _bedrooms = val;

  void incrementBedrooms(int amount) => bedrooms = bedrooms + amount;

  bool hasBedrooms() => _bedrooms != null;

  // "square_footage" field.
  String? _squareFootage;
  String get squareFootage => _squareFootage ?? '';
  set squareFootage(String? val) => _squareFootage = val;

  bool hasSquareFootage() => _squareFootage != null;

  static PropertyModelStruct fromMap(Map<String, dynamic> data) =>
      PropertyModelStruct(
        id: data['id'] as String?,
        propertyName: data['property_name'] as String?,
        address: data['address'] is Address1Struct
            ? data['address']
            : Address1Struct.maybeFromMap(data['address']),
        countyParishPrecinct: getDataList(data['county_parish_precinct']),
        createdAt: data['created_at'] as String?,
        hoa: data['hoa'] as String?,
        isDeletedByUser: data['is_deleted_by_user'] as bool?,
        listDate: data['list_date'] as String?,
        lotSize: data['lot_size'] as String?,
        media: getDataList(data['media']),
        notes: data['notes'] as String?,
        propertyType: data['property_type'] as String?,
        sellerId: getDataList(data['seller_id']),
        status: data['status'] as bool?,
        listAsIs: data['list_as_is'] as bool?,
        inContract: data['in_contract'] as bool?,
        isPending: data['is_pending'] as bool?,
        listNegotiable: data['list_negotiable'] as bool?,
        listPriceReduction: data['list_price_reduction'] as bool?,
        isSold: data['is_sold'] as bool?,
        lastUpdatedDate: data['last_updated_date'] as String?,
        mlsId: castToType<int>(data['mls_id']),
        updatedBy: data['updated_by'] as String?,
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        listPrice: castToType<int>(data['list_price']),
        bathrooms: castToType<int>(data['bathrooms']),
        bedrooms: castToType<int>(data['bedrooms']),
        squareFootage: data['square_footage'] as String?,
      );

  static PropertyModelStruct? maybeFromMap(dynamic data) => data is Map
      ? PropertyModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'property_name': _propertyName,
        'address': _address?.toMap(),
        'county_parish_precinct': _countyParishPrecinct,
        'created_at': _createdAt,
        'hoa': _hoa,
        'is_deleted_by_user': _isDeletedByUser,
        'list_date': _listDate,
        'lot_size': _lotSize,
        'media': _media,
        'notes': _notes,
        'property_type': _propertyType,
        'seller_id': _sellerId,
        'status': _status,
        'list_as_is': _listAsIs,
        'in_contract': _inContract,
        'is_pending': _isPending,
        'list_negotiable': _listNegotiable,
        'list_price_reduction': _listPriceReduction,
        'is_sold': _isSold,
        'last_updated_date': _lastUpdatedDate,
        'mls_id': _mlsId,
        'updated_by': _updatedBy,
        'latitude': _latitude,
        'longitude': _longitude,
        'list_price': _listPrice,
        'bathrooms': _bathrooms,
        'bedrooms': _bedrooms,
        'square_footage': _squareFootage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
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
          isList: true,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'hoa': serializeParam(
          _hoa,
          ParamType.String,
        ),
        'is_deleted_by_user': serializeParam(
          _isDeletedByUser,
          ParamType.bool,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
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
        'seller_id': serializeParam(
          _sellerId,
          ParamType.String,
          isList: true,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
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
        'mls_id': serializeParam(
          _mlsId,
          ParamType.int,
        ),
        'updated_by': serializeParam(
          _updatedBy,
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
        'list_price': serializeParam(
          _listPrice,
          ParamType.int,
        ),
        'bathrooms': serializeParam(
          _bathrooms,
          ParamType.int,
        ),
        'bedrooms': serializeParam(
          _bedrooms,
          ParamType.int,
        ),
        'square_footage': serializeParam(
          _squareFootage,
          ParamType.String,
        ),
      }.withoutNulls;

  static PropertyModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      PropertyModelStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
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
        countyParishPrecinct: deserializeParam<String>(
          data['county_parish_precinct'],
          ParamType.String,
          true,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        hoa: deserializeParam(
          data['hoa'],
          ParamType.String,
          false,
        ),
        isDeletedByUser: deserializeParam(
          data['is_deleted_by_user'],
          ParamType.bool,
          false,
        ),
        listDate: deserializeParam(
          data['list_date'],
          ParamType.String,
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
        sellerId: deserializeParam<String>(
          data['seller_id'],
          ParamType.String,
          true,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
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
        mlsId: deserializeParam(
          data['mls_id'],
          ParamType.int,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
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
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.int,
          false,
        ),
        bathrooms: deserializeParam(
          data['bathrooms'],
          ParamType.int,
          false,
        ),
        bedrooms: deserializeParam(
          data['bedrooms'],
          ParamType.int,
          false,
        ),
        squareFootage: deserializeParam(
          data['square_footage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PropertyModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PropertyModelStruct &&
        id == other.id &&
        propertyName == other.propertyName &&
        address == other.address &&
        listEquality.equals(countyParishPrecinct, other.countyParishPrecinct) &&
        createdAt == other.createdAt &&
        hoa == other.hoa &&
        isDeletedByUser == other.isDeletedByUser &&
        listDate == other.listDate &&
        lotSize == other.lotSize &&
        listEquality.equals(media, other.media) &&
        notes == other.notes &&
        propertyType == other.propertyType &&
        listEquality.equals(sellerId, other.sellerId) &&
        status == other.status &&
        listAsIs == other.listAsIs &&
        inContract == other.inContract &&
        isPending == other.isPending &&
        listNegotiable == other.listNegotiable &&
        listPriceReduction == other.listPriceReduction &&
        isSold == other.isSold &&
        lastUpdatedDate == other.lastUpdatedDate &&
        mlsId == other.mlsId &&
        updatedBy == other.updatedBy &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        listPrice == other.listPrice &&
        bathrooms == other.bathrooms &&
        bedrooms == other.bedrooms &&
        squareFootage == other.squareFootage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        propertyName,
        address,
        countyParishPrecinct,
        createdAt,
        hoa,
        isDeletedByUser,
        listDate,
        lotSize,
        media,
        notes,
        propertyType,
        sellerId,
        status,
        listAsIs,
        inContract,
        isPending,
        listNegotiable,
        listPriceReduction,
        isSold,
        lastUpdatedDate,
        mlsId,
        updatedBy,
        latitude,
        longitude,
        listPrice,
        bathrooms,
        bedrooms,
        squareFootage
      ]);
}

PropertyModelStruct createPropertyModelStruct({
  String? id,
  String? propertyName,
  Address1Struct? address,
  String? createdAt,
  String? hoa,
  bool? isDeletedByUser,
  String? listDate,
  String? lotSize,
  String? notes,
  String? propertyType,
  bool? status,
  bool? listAsIs,
  bool? inContract,
  bool? isPending,
  bool? listNegotiable,
  bool? listPriceReduction,
  bool? isSold,
  String? lastUpdatedDate,
  int? mlsId,
  String? updatedBy,
  double? latitude,
  double? longitude,
  int? listPrice,
  int? bathrooms,
  int? bedrooms,
  String? squareFootage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PropertyModelStruct(
      id: id,
      propertyName: propertyName,
      address: address ?? (clearUnsetFields ? Address1Struct() : null),
      createdAt: createdAt,
      hoa: hoa,
      isDeletedByUser: isDeletedByUser,
      listDate: listDate,
      lotSize: lotSize,
      notes: notes,
      propertyType: propertyType,
      status: status,
      listAsIs: listAsIs,
      inContract: inContract,
      isPending: isPending,
      listNegotiable: listNegotiable,
      listPriceReduction: listPriceReduction,
      isSold: isSold,
      lastUpdatedDate: lastUpdatedDate,
      mlsId: mlsId,
      updatedBy: updatedBy,
      latitude: latitude,
      longitude: longitude,
      listPrice: listPrice,
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      squareFootage: squareFootage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PropertyModelStruct? updatePropertyModelStruct(
  PropertyModelStruct? propertyModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    propertyModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPropertyModelStructData(
  Map<String, dynamic> firestoreData,
  PropertyModelStruct? propertyModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (propertyModel == null) {
    return;
  }
  if (propertyModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && propertyModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final propertyModelData =
      getPropertyModelFirestoreData(propertyModel, forFieldValue);
  final nestedData =
      propertyModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = propertyModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPropertyModelFirestoreData(
  PropertyModelStruct? propertyModel, [
  bool forFieldValue = false,
]) {
  if (propertyModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(propertyModel.toMap());

  // Handle nested data for "address" field.
  addAddress1StructData(
    firestoreData,
    propertyModel.hasAddress() ? propertyModel.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  propertyModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPropertyModelListFirestoreData(
  List<PropertyModelStruct>? propertyModels,
) =>
    propertyModels
        ?.map((e) => getPropertyModelFirestoreData(e, true))
        .toList() ??
    [];
