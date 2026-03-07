// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyPropertyStruct extends FFFirebaseStruct {
  MyPropertyStruct({
    String? propertyName,
    MyAddressStruct? address,
    String? bathrooms,
    String? bedrooms,
    String? countyParishPrecinct,
    String? hoa,
    bool? isDeletedByUser,
    String? listDate,
    String? listPrice,
    String? lotSize,
    String? media,
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
    String? updatedBy,
    String? mlsId,
    SellerPropertiesIdStruct? sellerPropertiesId,
    String? lastUpdateDate,
    String? createdAt,
    IdStruct? id,
    String? squareFootage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _propertyName = propertyName,
        _address = address,
        _bathrooms = bathrooms,
        _bedrooms = bedrooms,
        _countyParishPrecinct = countyParishPrecinct,
        _hoa = hoa,
        _isDeletedByUser = isDeletedByUser,
        _listDate = listDate,
        _listPrice = listPrice,
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
        _updatedBy = updatedBy,
        _mlsId = mlsId,
        _sellerPropertiesId = sellerPropertiesId,
        _lastUpdateDate = lastUpdateDate,
        _createdAt = createdAt,
        _id = id,
        _squareFootage = squareFootage,
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

  // "list_price" field.
  String? _listPrice;
  String get listPrice => _listPrice ?? '';
  set listPrice(String? val) => _listPrice = val;

  bool hasListPrice() => _listPrice != null;

  // "lot_size" field.
  String? _lotSize;
  String get lotSize => _lotSize ?? '';
  set lotSize(String? val) => _lotSize = val;

  bool hasLotSize() => _lotSize != null;

  // "media" field.
  String? _media;
  String get media => _media ?? '';
  set media(String? val) => _media = val;

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

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "mls_id" field.
  String? _mlsId;
  String get mlsId => _mlsId ?? '';
  set mlsId(String? val) => _mlsId = val;

  bool hasMlsId() => _mlsId != null;

  // "seller_properties_id" field.
  SellerPropertiesIdStruct? _sellerPropertiesId;
  SellerPropertiesIdStruct get sellerPropertiesId =>
      _sellerPropertiesId ?? SellerPropertiesIdStruct();
  set sellerPropertiesId(SellerPropertiesIdStruct? val) =>
      _sellerPropertiesId = val;

  void updateSellerPropertiesId(Function(SellerPropertiesIdStruct) updateFn) {
    updateFn(_sellerPropertiesId ??= SellerPropertiesIdStruct());
  }

  bool hasSellerPropertiesId() => _sellerPropertiesId != null;

  // "last_update_date" field.
  String? _lastUpdateDate;
  String get lastUpdateDate => _lastUpdateDate ?? '';
  set lastUpdateDate(String? val) => _lastUpdateDate = val;

  bool hasLastUpdateDate() => _lastUpdateDate != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "id" field.
  IdStruct? _id;
  IdStruct get id => _id ?? IdStruct();
  set id(IdStruct? val) => _id = val;

  void updateId(Function(IdStruct) updateFn) {
    updateFn(_id ??= IdStruct());
  }

  bool hasId() => _id != null;

  // "square_footage" field.
  String? _squareFootage;
  String get squareFootage => _squareFootage ?? '';
  set squareFootage(String? val) => _squareFootage = val;

  bool hasSquareFootage() => _squareFootage != null;

  static MyPropertyStruct fromMap(Map<String, dynamic> data) =>
      MyPropertyStruct(
        propertyName: data['property_name'] as String?,
        address: data['address'] is MyAddressStruct
            ? data['address']
            : MyAddressStruct.maybeFromMap(data['address']),
        bathrooms: data['bathrooms'] as String?,
        bedrooms: data['bedrooms'] as String?,
        countyParishPrecinct: data['county_parish_precinct'] as String?,
        hoa: data['hoa'] as String?,
        isDeletedByUser: data['is_deleted_by_user'] as bool?,
        listDate: data['list_date'] as String?,
        listPrice: data['list_price'] as String?,
        lotSize: data['lot_size'] as String?,
        media: data['media'] as String?,
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
        updatedBy: data['updated_by'] as String?,
        mlsId: data['mls_id'] as String?,
        sellerPropertiesId:
            data['seller_properties_id'] is SellerPropertiesIdStruct
                ? data['seller_properties_id']
                : SellerPropertiesIdStruct.maybeFromMap(
                    data['seller_properties_id']),
        lastUpdateDate: data['last_update_date'] as String?,
        createdAt: data['created_at'] as String?,
        id: data['id'] is IdStruct
            ? data['id']
            : IdStruct.maybeFromMap(data['id']),
        squareFootage: data['square_footage'] as String?,
      );

  static MyPropertyStruct? maybeFromMap(dynamic data) => data is Map
      ? MyPropertyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'property_name': _propertyName,
        'address': _address?.toMap(),
        'bathrooms': _bathrooms,
        'bedrooms': _bedrooms,
        'county_parish_precinct': _countyParishPrecinct,
        'hoa': _hoa,
        'is_deleted_by_user': _isDeletedByUser,
        'list_date': _listDate,
        'list_price': _listPrice,
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
        'updated_by': _updatedBy,
        'mls_id': _mlsId,
        'seller_properties_id': _sellerPropertiesId?.toMap(),
        'last_update_date': _lastUpdateDate,
        'created_at': _createdAt,
        'id': _id?.toMap(),
        'square_footage': _squareFootage,
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
        'county_parish_precinct': serializeParam(
          _countyParishPrecinct,
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
        'list_price': serializeParam(
          _listPrice,
          ParamType.String,
        ),
        'lot_size': serializeParam(
          _lotSize,
          ParamType.String,
        ),
        'media': serializeParam(
          _media,
          ParamType.String,
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
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'mls_id': serializeParam(
          _mlsId,
          ParamType.String,
        ),
        'seller_properties_id': serializeParam(
          _sellerPropertiesId,
          ParamType.DataStruct,
        ),
        'last_update_date': serializeParam(
          _lastUpdateDate,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.DataStruct,
        ),
        'square_footage': serializeParam(
          _squareFootage,
          ParamType.String,
        ),
      }.withoutNulls;

  static MyPropertyStruct fromSerializableMap(Map<String, dynamic> data) =>
      MyPropertyStruct(
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
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.String,
          false,
        ),
        lotSize: deserializeParam(
          data['lot_size'],
          ParamType.String,
          false,
        ),
        media: deserializeParam(
          data['media'],
          ParamType.String,
          false,
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
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        mlsId: deserializeParam(
          data['mls_id'],
          ParamType.String,
          false,
        ),
        sellerPropertiesId: deserializeStructParam(
          data['seller_properties_id'],
          ParamType.DataStruct,
          false,
          structBuilder: SellerPropertiesIdStruct.fromSerializableMap,
        ),
        lastUpdateDate: deserializeParam(
          data['last_update_date'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        id: deserializeStructParam(
          data['id'],
          ParamType.DataStruct,
          false,
          structBuilder: IdStruct.fromSerializableMap,
        ),
        squareFootage: deserializeParam(
          data['square_footage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MyPropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MyPropertyStruct &&
        propertyName == other.propertyName &&
        address == other.address &&
        bathrooms == other.bathrooms &&
        bedrooms == other.bedrooms &&
        countyParishPrecinct == other.countyParishPrecinct &&
        hoa == other.hoa &&
        isDeletedByUser == other.isDeletedByUser &&
        listDate == other.listDate &&
        listPrice == other.listPrice &&
        lotSize == other.lotSize &&
        media == other.media &&
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
        updatedBy == other.updatedBy &&
        mlsId == other.mlsId &&
        sellerPropertiesId == other.sellerPropertiesId &&
        lastUpdateDate == other.lastUpdateDate &&
        createdAt == other.createdAt &&
        id == other.id &&
        squareFootage == other.squareFootage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        propertyName,
        address,
        bathrooms,
        bedrooms,
        countyParishPrecinct,
        hoa,
        isDeletedByUser,
        listDate,
        listPrice,
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
        updatedBy,
        mlsId,
        sellerPropertiesId,
        lastUpdateDate,
        createdAt,
        id,
        squareFootage
      ]);
}

MyPropertyStruct createMyPropertyStruct({
  String? propertyName,
  MyAddressStruct? address,
  String? bathrooms,
  String? bedrooms,
  String? countyParishPrecinct,
  String? hoa,
  bool? isDeletedByUser,
  String? listDate,
  String? listPrice,
  String? lotSize,
  String? media,
  String? notes,
  String? propertyType,
  bool? status,
  bool? listAsIs,
  bool? inContract,
  bool? isPending,
  bool? listNegotiable,
  bool? listPriceReduction,
  bool? isSold,
  String? updatedBy,
  String? mlsId,
  SellerPropertiesIdStruct? sellerPropertiesId,
  String? lastUpdateDate,
  String? createdAt,
  IdStruct? id,
  String? squareFootage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MyPropertyStruct(
      propertyName: propertyName,
      address: address ?? (clearUnsetFields ? MyAddressStruct() : null),
      bathrooms: bathrooms,
      bedrooms: bedrooms,
      countyParishPrecinct: countyParishPrecinct,
      hoa: hoa,
      isDeletedByUser: isDeletedByUser,
      listDate: listDate,
      listPrice: listPrice,
      lotSize: lotSize,
      media: media,
      notes: notes,
      propertyType: propertyType,
      status: status,
      listAsIs: listAsIs,
      inContract: inContract,
      isPending: isPending,
      listNegotiable: listNegotiable,
      listPriceReduction: listPriceReduction,
      isSold: isSold,
      updatedBy: updatedBy,
      mlsId: mlsId,
      sellerPropertiesId: sellerPropertiesId ??
          (clearUnsetFields ? SellerPropertiesIdStruct() : null),
      lastUpdateDate: lastUpdateDate,
      createdAt: createdAt,
      id: id ?? (clearUnsetFields ? IdStruct() : null),
      squareFootage: squareFootage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MyPropertyStruct? updateMyPropertyStruct(
  MyPropertyStruct? myProperty, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    myProperty
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMyPropertyStructData(
  Map<String, dynamic> firestoreData,
  MyPropertyStruct? myProperty,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (myProperty == null) {
    return;
  }
  if (myProperty.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && myProperty.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final myPropertyData = getMyPropertyFirestoreData(myProperty, forFieldValue);
  final nestedData = myPropertyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = myProperty.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMyPropertyFirestoreData(
  MyPropertyStruct? myProperty, [
  bool forFieldValue = false,
]) {
  if (myProperty == null) {
    return {};
  }
  final firestoreData = mapToFirestore(myProperty.toMap());

  // Handle nested data for "address" field.
  addMyAddressStructData(
    firestoreData,
    myProperty.hasAddress() ? myProperty.address : null,
    'address',
    forFieldValue,
  );

  // Handle nested data for "seller_properties_id" field.
  addSellerPropertiesIdStructData(
    firestoreData,
    myProperty.hasSellerPropertiesId() ? myProperty.sellerPropertiesId : null,
    'seller_properties_id',
    forFieldValue,
  );

  // Handle nested data for "id" field.
  addIdStructData(
    firestoreData,
    myProperty.hasId() ? myProperty.id : null,
    'id',
    forFieldValue,
  );

  // Add any Firestore field values
  myProperty.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMyPropertyListFirestoreData(
  List<MyPropertyStruct>? myPropertys,
) =>
    myPropertys?.map((e) => getMyPropertyFirestoreData(e, true)).toList() ?? [];
