// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertyDataClassStruct extends FFFirebaseStruct {
  PropertyDataClassStruct({
    String? id,
    String? propertyName,
    int? bathrooms,
    int? bedrooms,
    String? countyParishPrecinct,
    int? listPrice,
    String? lotSize,
    List<String>? media,
    String? notes,
    String? propertyType,
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
    bool? lastUpdatedDate,
    String? updatedBy,
    AddressDataClassStruct? address,
    int? squareFootage,
    String? createdAt,
    String? listDate,
    String? onMarketDate,
    String? agentPhoneNumber,
    String? agentName,
    String? agentEmail,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _propertyName = propertyName,
        _bathrooms = bathrooms,
        _bedrooms = bedrooms,
        _countyParishPrecinct = countyParishPrecinct,
        _listPrice = listPrice,
        _lotSize = lotSize,
        _media = media,
        _notes = notes,
        _propertyType = propertyType,
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
        _address = address,
        _squareFootage = squareFootage,
        _createdAt = createdAt,
        _listDate = listDate,
        _onMarketDate = onMarketDate,
        _agentPhoneNumber = agentPhoneNumber,
        _agentName = agentName,
        _agentEmail = agentEmail,
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

  // "county_parish_precinct" field.
  String? _countyParishPrecinct;
  String get countyParishPrecinct => _countyParishPrecinct ?? '';
  set countyParishPrecinct(String? val) => _countyParishPrecinct = val;

  bool hasCountyParishPrecinct() => _countyParishPrecinct != null;

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
  bool? _lastUpdatedDate;
  bool get lastUpdatedDate => _lastUpdatedDate ?? false;
  set lastUpdatedDate(bool? val) => _lastUpdatedDate = val;

  bool hasLastUpdatedDate() => _lastUpdatedDate != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "address" field.
  AddressDataClassStruct? _address;
  AddressDataClassStruct get address => _address ?? AddressDataClassStruct();
  set address(AddressDataClassStruct? val) => _address = val;

  void updateAddress(Function(AddressDataClassStruct) updateFn) {
    updateFn(_address ??= AddressDataClassStruct());
  }

  bool hasAddress() => _address != null;

  // "square_footage" field.
  int? _squareFootage;
  int get squareFootage => _squareFootage ?? 0;
  set squareFootage(int? val) => _squareFootage = val;

  void incrementSquareFootage(int amount) =>
      squareFootage = squareFootage + amount;

  bool hasSquareFootage() => _squareFootage != null;

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

  // "on_market_date" field.
  String? _onMarketDate;
  String get onMarketDate => _onMarketDate ?? '';
  set onMarketDate(String? val) => _onMarketDate = val;

  bool hasOnMarketDate() => _onMarketDate != null;

  // "agent_phone_number" field.
  String? _agentPhoneNumber;
  String get agentPhoneNumber => _agentPhoneNumber ?? '';
  set agentPhoneNumber(String? val) => _agentPhoneNumber = val;

  bool hasAgentPhoneNumber() => _agentPhoneNumber != null;

  // "agent_name" field.
  String? _agentName;
  String get agentName => _agentName ?? '';
  set agentName(String? val) => _agentName = val;

  bool hasAgentName() => _agentName != null;

  // "agent_email" field.
  String? _agentEmail;
  String get agentEmail => _agentEmail ?? '';
  set agentEmail(String? val) => _agentEmail = val;

  bool hasAgentEmail() => _agentEmail != null;

  static PropertyDataClassStruct fromMap(Map<String, dynamic> data) =>
      PropertyDataClassStruct(
        id: data['id'] as String?,
        propertyName: data['property_name'] as String?,
        bathrooms: castToType<int>(data['bathrooms']),
        bedrooms: castToType<int>(data['bedrooms']),
        countyParishPrecinct: data['county_parish_precinct'] as String?,
        listPrice: castToType<int>(data['list_price']),
        lotSize: data['lot_size'] as String?,
        media: getDataList(data['media']),
        notes: data['notes'] as String?,
        propertyType: data['property_type'] as String?,
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
        lastUpdatedDate: data['last_updated_date'] as bool?,
        updatedBy: data['updated_by'] as String?,
        address: data['address'] is AddressDataClassStruct
            ? data['address']
            : AddressDataClassStruct.maybeFromMap(data['address']),
        squareFootage: castToType<int>(data['square_footage']),
        createdAt: data['created_at'] as String?,
        listDate: data['list_date'] as String?,
        onMarketDate: data['on_market_date'] as String?,
        agentPhoneNumber: data['agent_phone_number'] as String?,
        agentName: data['agent_name'] as String?,
        agentEmail: data['agent_email'] as String?,
      );

  static PropertyDataClassStruct? maybeFromMap(dynamic data) => data is Map
      ? PropertyDataClassStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'property_name': _propertyName,
        'bathrooms': _bathrooms,
        'bedrooms': _bedrooms,
        'county_parish_precinct': _countyParishPrecinct,
        'list_price': _listPrice,
        'lot_size': _lotSize,
        'media': _media,
        'notes': _notes,
        'property_type': _propertyType,
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
        'address': _address?.toMap(),
        'square_footage': _squareFootage,
        'created_at': _createdAt,
        'list_date': _listDate,
        'on_market_date': _onMarketDate,
        'agent_phone_number': _agentPhoneNumber,
        'agent_name': _agentName,
        'agent_email': _agentEmail,
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
        'bathrooms': serializeParam(
          _bathrooms,
          ParamType.int,
        ),
        'bedrooms': serializeParam(
          _bedrooms,
          ParamType.int,
        ),
        'county_parish_precinct': serializeParam(
          _countyParishPrecinct,
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
          ParamType.bool,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'square_footage': serializeParam(
          _squareFootage,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
        ),
        'on_market_date': serializeParam(
          _onMarketDate,
          ParamType.String,
        ),
        'agent_phone_number': serializeParam(
          _agentPhoneNumber,
          ParamType.String,
        ),
        'agent_name': serializeParam(
          _agentName,
          ParamType.String,
        ),
        'agent_email': serializeParam(
          _agentEmail,
          ParamType.String,
        ),
      }.withoutNulls;

  static PropertyDataClassStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PropertyDataClassStruct(
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
        countyParishPrecinct: deserializeParam(
          data['county_parish_precinct'],
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
          ParamType.bool,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: AddressDataClassStruct.fromSerializableMap,
        ),
        squareFootage: deserializeParam(
          data['square_footage'],
          ParamType.int,
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
        onMarketDate: deserializeParam(
          data['on_market_date'],
          ParamType.String,
          false,
        ),
        agentPhoneNumber: deserializeParam(
          data['agent_phone_number'],
          ParamType.String,
          false,
        ),
        agentName: deserializeParam(
          data['agent_name'],
          ParamType.String,
          false,
        ),
        agentEmail: deserializeParam(
          data['agent_email'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PropertyDataClassStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PropertyDataClassStruct &&
        id == other.id &&
        propertyName == other.propertyName &&
        bathrooms == other.bathrooms &&
        bedrooms == other.bedrooms &&
        countyParishPrecinct == other.countyParishPrecinct &&
        listPrice == other.listPrice &&
        lotSize == other.lotSize &&
        listEquality.equals(media, other.media) &&
        notes == other.notes &&
        propertyType == other.propertyType &&
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
        address == other.address &&
        squareFootage == other.squareFootage &&
        createdAt == other.createdAt &&
        listDate == other.listDate &&
        onMarketDate == other.onMarketDate &&
        agentPhoneNumber == other.agentPhoneNumber &&
        agentName == other.agentName &&
        agentEmail == other.agentEmail;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        propertyName,
        bathrooms,
        bedrooms,
        countyParishPrecinct,
        listPrice,
        lotSize,
        media,
        notes,
        propertyType,
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
        address,
        squareFootage,
        createdAt,
        listDate,
        onMarketDate,
        agentPhoneNumber,
        agentName,
        agentEmail
      ]);
}

PropertyDataClassStruct createPropertyDataClassStruct({
  String? id,
  String? propertyName,
  int? bathrooms,
  int? bedrooms,
  String? countyParishPrecinct,
  int? listPrice,
  String? lotSize,
  String? notes,
  String? propertyType,
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
  bool? lastUpdatedDate,
  String? updatedBy,
  AddressDataClassStruct? address,
  int? squareFootage,
  String? createdAt,
  String? listDate,
  String? onMarketDate,
  String? agentPhoneNumber,
  String? agentName,
  String? agentEmail,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PropertyDataClassStruct(
      id: id,
      propertyName: propertyName,
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      countyParishPrecinct: countyParishPrecinct,
      listPrice: listPrice,
      lotSize: lotSize,
      notes: notes,
      propertyType: propertyType,
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
      address: address ?? (clearUnsetFields ? AddressDataClassStruct() : null),
      squareFootage: squareFootage,
      createdAt: createdAt,
      listDate: listDate,
      onMarketDate: onMarketDate,
      agentPhoneNumber: agentPhoneNumber,
      agentName: agentName,
      agentEmail: agentEmail,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PropertyDataClassStruct? updatePropertyDataClassStruct(
  PropertyDataClassStruct? propertyDataClass, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    propertyDataClass
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPropertyDataClassStructData(
  Map<String, dynamic> firestoreData,
  PropertyDataClassStruct? propertyDataClass,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (propertyDataClass == null) {
    return;
  }
  if (propertyDataClass.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && propertyDataClass.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final propertyDataClassData =
      getPropertyDataClassFirestoreData(propertyDataClass, forFieldValue);
  final nestedData =
      propertyDataClassData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = propertyDataClass.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPropertyDataClassFirestoreData(
  PropertyDataClassStruct? propertyDataClass, [
  bool forFieldValue = false,
]) {
  if (propertyDataClass == null) {
    return {};
  }
  final firestoreData = mapToFirestore(propertyDataClass.toMap());

  // Handle nested data for "address" field.
  addAddressDataClassStructData(
    firestoreData,
    propertyDataClass.hasAddress() ? propertyDataClass.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  propertyDataClass.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPropertyDataClassListFirestoreData(
  List<PropertyDataClassStruct>? propertyDataClasss,
) =>
    propertyDataClasss
        ?.map((e) => getPropertyDataClassFirestoreData(e, true))
        .toList() ??
    [];
