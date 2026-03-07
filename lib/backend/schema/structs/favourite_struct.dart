// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavouriteStruct extends FFFirebaseStruct {
  FavouriteStruct({
    bool? status,
    String? propertyId,
    String? userId,
    DateTime? createdAt,
    String? createdBy,
    DateTime? lastUpdatedDate,
    String? notes,
    bool? isDeletedByUser,
    String? id,
    String? price,
    String? image,
    String? bathroom,
    String? bedroom,
    String? address,
    String? square,
    PropertyDataClassStruct? propertyDataClas,
    List<String>? mediaList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _propertyId = propertyId,
        _userId = userId,
        _createdAt = createdAt,
        _createdBy = createdBy,
        _lastUpdatedDate = lastUpdatedDate,
        _notes = notes,
        _isDeletedByUser = isDeletedByUser,
        _id = id,
        _price = price,
        _image = image,
        _bathroom = bathroom,
        _bedroom = bedroom,
        _address = address,
        _square = square,
        _propertyDataClas = propertyDataClas,
        _mediaList = mediaList,
        super(firestoreUtilData);

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "property_id" field.
  String? _propertyId;
  String get propertyId => _propertyId ?? '';
  set propertyId(String? val) => _propertyId = val;

  bool hasPropertyId() => _propertyId != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "last_updated_date" field.
  DateTime? _lastUpdatedDate;
  DateTime? get lastUpdatedDate => _lastUpdatedDate;
  set lastUpdatedDate(DateTime? val) => _lastUpdatedDate = val;

  bool hasLastUpdatedDate() => _lastUpdatedDate != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "is_deleted_by_user" field.
  bool? _isDeletedByUser;
  bool get isDeletedByUser => _isDeletedByUser ?? false;
  set isDeletedByUser(bool? val) => _isDeletedByUser = val;

  bool hasIsDeletedByUser() => _isDeletedByUser != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  set price(String? val) => _price = val;

  bool hasPrice() => _price != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "bathroom" field.
  String? _bathroom;
  String get bathroom => _bathroom ?? '';
  set bathroom(String? val) => _bathroom = val;

  bool hasBathroom() => _bathroom != null;

  // "bedroom" field.
  String? _bedroom;
  String get bedroom => _bedroom ?? '';
  set bedroom(String? val) => _bedroom = val;

  bool hasBedroom() => _bedroom != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "square" field.
  String? _square;
  String get square => _square ?? '';
  set square(String? val) => _square = val;

  bool hasSquare() => _square != null;

  // "propertyDataClas" field.
  PropertyDataClassStruct? _propertyDataClas;
  PropertyDataClassStruct get propertyDataClas =>
      _propertyDataClas ?? PropertyDataClassStruct();
  set propertyDataClas(PropertyDataClassStruct? val) => _propertyDataClas = val;

  void updatePropertyDataClas(Function(PropertyDataClassStruct) updateFn) {
    updateFn(_propertyDataClas ??= PropertyDataClassStruct());
  }

  bool hasPropertyDataClas() => _propertyDataClas != null;

  // "mediaList" field.
  List<String>? _mediaList;
  List<String> get mediaList => _mediaList ?? const [];
  set mediaList(List<String>? val) => _mediaList = val;

  void updateMediaList(Function(List<String>) updateFn) {
    updateFn(_mediaList ??= []);
  }

  bool hasMediaList() => _mediaList != null;

  static FavouriteStruct fromMap(Map<String, dynamic> data) => FavouriteStruct(
        status: data['status'] as bool?,
        propertyId: data['property_id'] as String?,
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as DateTime?,
        createdBy: data['created_by'] as String?,
        lastUpdatedDate: data['last_updated_date'] as DateTime?,
        notes: data['notes'] as String?,
        isDeletedByUser: data['is_deleted_by_user'] as bool?,
        id: data['id'] as String?,
        price: data['price'] as String?,
        image: data['image'] as String?,
        bathroom: data['bathroom'] as String?,
        bedroom: data['bedroom'] as String?,
        address: data['address'] as String?,
        square: data['square'] as String?,
        propertyDataClas: data['propertyDataClas'] is PropertyDataClassStruct
            ? data['propertyDataClas']
            : PropertyDataClassStruct.maybeFromMap(data['propertyDataClas']),
        mediaList: getDataList(data['mediaList']),
      );

  static FavouriteStruct? maybeFromMap(dynamic data) => data is Map
      ? FavouriteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'property_id': _propertyId,
        'user_id': _userId,
        'created_at': _createdAt,
        'created_by': _createdBy,
        'last_updated_date': _lastUpdatedDate,
        'notes': _notes,
        'is_deleted_by_user': _isDeletedByUser,
        'id': _id,
        'price': _price,
        'image': _image,
        'bathroom': _bathroom,
        'bedroom': _bedroom,
        'address': _address,
        'square': _square,
        'propertyDataClas': _propertyDataClas?.toMap(),
        'mediaList': _mediaList,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'property_id': serializeParam(
          _propertyId,
          ParamType.String,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'last_updated_date': serializeParam(
          _lastUpdatedDate,
          ParamType.DateTime,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
        'is_deleted_by_user': serializeParam(
          _isDeletedByUser,
          ParamType.bool,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'bathroom': serializeParam(
          _bathroom,
          ParamType.String,
        ),
        'bedroom': serializeParam(
          _bedroom,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'square': serializeParam(
          _square,
          ParamType.String,
        ),
        'propertyDataClas': serializeParam(
          _propertyDataClas,
          ParamType.DataStruct,
        ),
        'mediaList': serializeParam(
          _mediaList,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static FavouriteStruct fromSerializableMap(Map<String, dynamic> data) =>
      FavouriteStruct(
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        propertyId: deserializeParam(
          data['property_id'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        lastUpdatedDate: deserializeParam(
          data['last_updated_date'],
          ParamType.DateTime,
          false,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
        isDeletedByUser: deserializeParam(
          data['is_deleted_by_user'],
          ParamType.bool,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        bathroom: deserializeParam(
          data['bathroom'],
          ParamType.String,
          false,
        ),
        bedroom: deserializeParam(
          data['bedroom'],
          ParamType.String,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        square: deserializeParam(
          data['square'],
          ParamType.String,
          false,
        ),
        propertyDataClas: deserializeStructParam(
          data['propertyDataClas'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyDataClassStruct.fromSerializableMap,
        ),
        mediaList: deserializeParam<String>(
          data['mediaList'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'FavouriteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FavouriteStruct &&
        status == other.status &&
        propertyId == other.propertyId &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        lastUpdatedDate == other.lastUpdatedDate &&
        notes == other.notes &&
        isDeletedByUser == other.isDeletedByUser &&
        id == other.id &&
        price == other.price &&
        image == other.image &&
        bathroom == other.bathroom &&
        bedroom == other.bedroom &&
        address == other.address &&
        square == other.square &&
        propertyDataClas == other.propertyDataClas &&
        listEquality.equals(mediaList, other.mediaList);
  }

  @override
  int get hashCode => const ListEquality().hash([
        status,
        propertyId,
        userId,
        createdAt,
        createdBy,
        lastUpdatedDate,
        notes,
        isDeletedByUser,
        id,
        price,
        image,
        bathroom,
        bedroom,
        address,
        square,
        propertyDataClas,
        mediaList
      ]);
}

FavouriteStruct createFavouriteStruct({
  bool? status,
  String? propertyId,
  String? userId,
  DateTime? createdAt,
  String? createdBy,
  DateTime? lastUpdatedDate,
  String? notes,
  bool? isDeletedByUser,
  String? id,
  String? price,
  String? image,
  String? bathroom,
  String? bedroom,
  String? address,
  String? square,
  PropertyDataClassStruct? propertyDataClas,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavouriteStruct(
      status: status,
      propertyId: propertyId,
      userId: userId,
      createdAt: createdAt,
      createdBy: createdBy,
      lastUpdatedDate: lastUpdatedDate,
      notes: notes,
      isDeletedByUser: isDeletedByUser,
      id: id,
      price: price,
      image: image,
      bathroom: bathroom,
      bedroom: bedroom,
      address: address,
      square: square,
      propertyDataClas: propertyDataClas ??
          (clearUnsetFields ? PropertyDataClassStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavouriteStruct? updateFavouriteStruct(
  FavouriteStruct? favourite, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favourite
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavouriteStructData(
  Map<String, dynamic> firestoreData,
  FavouriteStruct? favourite,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favourite == null) {
    return;
  }
  if (favourite.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favourite.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favouriteData = getFavouriteFirestoreData(favourite, forFieldValue);
  final nestedData = favouriteData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favourite.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavouriteFirestoreData(
  FavouriteStruct? favourite, [
  bool forFieldValue = false,
]) {
  if (favourite == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favourite.toMap());

  // Handle nested data for "propertyDataClas" field.
  addPropertyDataClassStructData(
    firestoreData,
    favourite.hasPropertyDataClas() ? favourite.propertyDataClas : null,
    'propertyDataClas',
    forFieldValue,
  );

  // Add any Firestore field values
  favourite.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavouriteListFirestoreData(
  List<FavouriteStruct>? favourites,
) =>
    favourites?.map((e) => getFavouriteFirestoreData(e, true)).toList() ?? [];
