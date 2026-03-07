// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertyDataByZIPIDStruct extends FFFirebaseStruct {
  PropertyDataByZIPIDStruct({
    String? id,
    Address1Struct? address,
    int? bathrooms,
    int? bedrooms,
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
    String? onMarketDate,
    String? agentPhoneNumber,
    String? agentName,
    String? agentEmail,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _address = address,
        _bathrooms = bathrooms,
        _bedrooms = bedrooms,
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

  // "address" field.
  Address1Struct? _address;
  Address1Struct get address => _address ?? Address1Struct();
  set address(Address1Struct? val) => _address = val;

  void updateAddress(Function(Address1Struct) updateFn) {
    updateFn(_address ??= Address1Struct());
  }

  bool hasAddress() => _address != null;

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

  static PropertyDataByZIPIDStruct fromMap(Map<String, dynamic> data) =>
      PropertyDataByZIPIDStruct(
        id: data['id'] as String?,
        address: data['address'] is Address1Struct
            ? data['address']
            : Address1Struct.maybeFromMap(data['address']),
        bathrooms: castToType<int>(data['bathrooms']),
        bedrooms: castToType<int>(data['bedrooms']),
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
        onMarketDate: data['on_market_date'] as String?,
        agentPhoneNumber: data['agent_phone_number'] as String?,
        agentName: data['agent_name'] as String?,
        agentEmail: data['agent_email'] as String?,
      );

  static PropertyDataByZIPIDStruct? maybeFromMap(dynamic data) => data is Map
      ? PropertyDataByZIPIDStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'address': _address?.toMap(),
        'bathrooms': _bathrooms,
        'bedrooms': _bedrooms,
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
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
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

  static PropertyDataByZIPIDStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PropertyDataByZIPIDStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: Address1Struct.fromSerializableMap,
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
  String toString() => 'PropertyDataByZIPIDStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PropertyDataByZIPIDStruct &&
        id == other.id &&
        address == other.address &&
        bathrooms == other.bathrooms &&
        bedrooms == other.bedrooms &&
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
        onMarketDate == other.onMarketDate &&
        agentPhoneNumber == other.agentPhoneNumber &&
        agentName == other.agentName &&
        agentEmail == other.agentEmail;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        address,
        bathrooms,
        bedrooms,
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
        onMarketDate,
        agentPhoneNumber,
        agentName,
        agentEmail
      ]);
}

PropertyDataByZIPIDStruct createPropertyDataByZIPIDStruct({
  String? id,
  Address1Struct? address,
  int? bathrooms,
  int? bedrooms,
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
  String? onMarketDate,
  String? agentPhoneNumber,
  String? agentName,
  String? agentEmail,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PropertyDataByZIPIDStruct(
      id: id,
      address: address ?? (clearUnsetFields ? Address1Struct() : null),
      bathrooms: bathrooms,
      bedrooms: bedrooms,
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

PropertyDataByZIPIDStruct? updatePropertyDataByZIPIDStruct(
  PropertyDataByZIPIDStruct? propertyDataByZIPID, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    propertyDataByZIPID
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPropertyDataByZIPIDStructData(
  Map<String, dynamic> firestoreData,
  PropertyDataByZIPIDStruct? propertyDataByZIPID,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (propertyDataByZIPID == null) {
    return;
  }
  if (propertyDataByZIPID.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && propertyDataByZIPID.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final propertyDataByZIPIDData =
      getPropertyDataByZIPIDFirestoreData(propertyDataByZIPID, forFieldValue);
  final nestedData =
      propertyDataByZIPIDData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      propertyDataByZIPID.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPropertyDataByZIPIDFirestoreData(
  PropertyDataByZIPIDStruct? propertyDataByZIPID, [
  bool forFieldValue = false,
]) {
  if (propertyDataByZIPID == null) {
    return {};
  }
  final firestoreData = mapToFirestore(propertyDataByZIPID.toMap());

  // Handle nested data for "address" field.
  addAddress1StructData(
    firestoreData,
    propertyDataByZIPID.hasAddress() ? propertyDataByZIPID.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  propertyDataByZIPID.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPropertyDataByZIPIDListFirestoreData(
  List<PropertyDataByZIPIDStruct>? propertyDataByZIPIDs,
) =>
    propertyDataByZIPIDs
        ?.map((e) => getPropertyDataByZIPIDFirestoreData(e, true))
        .toList() ??
    [];
