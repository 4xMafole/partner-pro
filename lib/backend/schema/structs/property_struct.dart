// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertyStruct extends FFFirebaseStruct {
  PropertyStruct({
    String? id,
    String? propertyType,
    String? title,
    String? description,
    String? beds,
    String? baths,
    String? sqft,
    int? price,
    List<String>? documents,
    LocationStruct? location,
    List<String>? images,
    bool? isActive,
    Status? yardSignStatus,
    bool? isFavourite,
    String? listDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _propertyType = propertyType,
        _title = title,
        _description = description,
        _beds = beds,
        _baths = baths,
        _sqft = sqft,
        _price = price,
        _documents = documents,
        _location = location,
        _images = images,
        _isActive = isActive,
        _yardSignStatus = yardSignStatus,
        _isFavourite = isFavourite,
        _listDate = listDate,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "property_type" field.
  String? _propertyType;
  String get propertyType => _propertyType ?? '';
  set propertyType(String? val) => _propertyType = val;

  bool hasPropertyType() => _propertyType != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "beds" field.
  String? _beds;
  String get beds => _beds ?? '';
  set beds(String? val) => _beds = val;

  bool hasBeds() => _beds != null;

  // "baths" field.
  String? _baths;
  String get baths => _baths ?? '';
  set baths(String? val) => _baths = val;

  bool hasBaths() => _baths != null;

  // "sqft" field.
  String? _sqft;
  String get sqft => _sqft ?? '';
  set sqft(String? val) => _sqft = val;

  bool hasSqft() => _sqft != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "documents" field.
  List<String>? _documents;
  List<String> get documents => _documents ?? const [];
  set documents(List<String>? val) => _documents = val;

  void updateDocuments(Function(List<String>) updateFn) {
    updateFn(_documents ??= []);
  }

  bool hasDocuments() => _documents != null;

  // "location" field.
  LocationStruct? _location;
  LocationStruct get location => _location ?? LocationStruct();
  set location(LocationStruct? val) => _location = val;

  void updateLocation(Function(LocationStruct) updateFn) {
    updateFn(_location ??= LocationStruct());
  }

  bool hasLocation() => _location != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? true;
  set isActive(bool? val) => _isActive = val;

  bool hasIsActive() => _isActive != null;

  // "yard_sign_status" field.
  Status? _yardSignStatus;
  Status? get yardSignStatus => _yardSignStatus;
  set yardSignStatus(Status? val) => _yardSignStatus = val;

  bool hasYardSignStatus() => _yardSignStatus != null;

  // "is_favourite" field.
  bool? _isFavourite;
  bool get isFavourite => _isFavourite ?? false;
  set isFavourite(bool? val) => _isFavourite = val;

  bool hasIsFavourite() => _isFavourite != null;

  // "list_date" field.
  String? _listDate;
  String get listDate => _listDate ?? '';
  set listDate(String? val) => _listDate = val;

  bool hasListDate() => _listDate != null;

  static PropertyStruct fromMap(Map<String, dynamic> data) => PropertyStruct(
        id: data['id'] as String?,
        propertyType: data['property_type'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        beds: data['beds'] as String?,
        baths: data['baths'] as String?,
        sqft: data['sqft'] as String?,
        price: castToType<int>(data['price']),
        documents: getDataList(data['documents']),
        location: data['location'] is LocationStruct
            ? data['location']
            : LocationStruct.maybeFromMap(data['location']),
        images: getDataList(data['images']),
        isActive: data['is_active'] as bool?,
        yardSignStatus: data['yard_sign_status'] is Status
            ? data['yard_sign_status']
            : deserializeEnum<Status>(data['yard_sign_status']),
        isFavourite: data['is_favourite'] as bool?,
        listDate: data['list_date'] as String?,
      );

  static PropertyStruct? maybeFromMap(dynamic data) =>
      data is Map ? PropertyStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'property_type': _propertyType,
        'title': _title,
        'description': _description,
        'beds': _beds,
        'baths': _baths,
        'sqft': _sqft,
        'price': _price,
        'documents': _documents,
        'location': _location?.toMap(),
        'images': _images,
        'is_active': _isActive,
        'yard_sign_status': _yardSignStatus?.serialize(),
        'is_favourite': _isFavourite,
        'list_date': _listDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'property_type': serializeParam(
          _propertyType,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'beds': serializeParam(
          _beds,
          ParamType.String,
        ),
        'baths': serializeParam(
          _baths,
          ParamType.String,
        ),
        'sqft': serializeParam(
          _sqft,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'documents': serializeParam(
          _documents,
          ParamType.String,
          isList: true,
        ),
        'location': serializeParam(
          _location,
          ParamType.DataStruct,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.bool,
        ),
        'yard_sign_status': serializeParam(
          _yardSignStatus,
          ParamType.Enum,
        ),
        'is_favourite': serializeParam(
          _isFavourite,
          ParamType.bool,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static PropertyStruct fromSerializableMap(Map<String, dynamic> data) =>
      PropertyStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        propertyType: deserializeParam(
          data['property_type'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        beds: deserializeParam(
          data['beds'],
          ParamType.String,
          false,
        ),
        baths: deserializeParam(
          data['baths'],
          ParamType.String,
          false,
        ),
        sqft: deserializeParam(
          data['sqft'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        documents: deserializeParam<String>(
          data['documents'],
          ParamType.String,
          true,
        ),
        location: deserializeStructParam(
          data['location'],
          ParamType.DataStruct,
          false,
          structBuilder: LocationStruct.fromSerializableMap,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.bool,
          false,
        ),
        yardSignStatus: deserializeParam<Status>(
          data['yard_sign_status'],
          ParamType.Enum,
          false,
        ),
        isFavourite: deserializeParam(
          data['is_favourite'],
          ParamType.bool,
          false,
        ),
        listDate: deserializeParam(
          data['list_date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PropertyStruct &&
        id == other.id &&
        propertyType == other.propertyType &&
        title == other.title &&
        description == other.description &&
        beds == other.beds &&
        baths == other.baths &&
        sqft == other.sqft &&
        price == other.price &&
        listEquality.equals(documents, other.documents) &&
        location == other.location &&
        listEquality.equals(images, other.images) &&
        isActive == other.isActive &&
        yardSignStatus == other.yardSignStatus &&
        isFavourite == other.isFavourite &&
        listDate == other.listDate;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        propertyType,
        title,
        description,
        beds,
        baths,
        sqft,
        price,
        documents,
        location,
        images,
        isActive,
        yardSignStatus,
        isFavourite,
        listDate
      ]);
}

PropertyStruct createPropertyStruct({
  String? id,
  String? propertyType,
  String? title,
  String? description,
  String? beds,
  String? baths,
  String? sqft,
  int? price,
  LocationStruct? location,
  bool? isActive,
  Status? yardSignStatus,
  bool? isFavourite,
  String? listDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PropertyStruct(
      id: id,
      propertyType: propertyType,
      title: title,
      description: description,
      beds: beds,
      baths: baths,
      sqft: sqft,
      price: price,
      location: location ?? (clearUnsetFields ? LocationStruct() : null),
      isActive: isActive,
      yardSignStatus: yardSignStatus,
      isFavourite: isFavourite,
      listDate: listDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PropertyStruct? updatePropertyStruct(
  PropertyStruct? property, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    property
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPropertyStructData(
  Map<String, dynamic> firestoreData,
  PropertyStruct? property,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (property == null) {
    return;
  }
  if (property.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && property.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final propertyData = getPropertyFirestoreData(property, forFieldValue);
  final nestedData = propertyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = property.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPropertyFirestoreData(
  PropertyStruct? property, [
  bool forFieldValue = false,
]) {
  if (property == null) {
    return {};
  }
  final firestoreData = mapToFirestore(property.toMap());

  // Handle nested data for "location" field.
  addLocationStructData(
    firestoreData,
    property.hasLocation() ? property.location : null,
    'location',
    forFieldValue,
  );

  // Add any Firestore field values
  property.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPropertyListFirestoreData(
  List<PropertyStruct>? propertys,
) =>
    propertys?.map((e) => getPropertyFirestoreData(e, true)).toList() ?? [];
