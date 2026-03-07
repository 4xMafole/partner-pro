// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavoriteObjectStruct extends FFFirebaseStruct {
  FavoriteObjectStruct({
    bool? status,
    String? createdBy,
    String? propertyId,
    String? userId,
    String? createdAt,
    String? lastUpdatedDate,
    String? notes,
    bool? isDeletedByUser,
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _createdBy = createdBy,
        _propertyId = propertyId,
        _userId = userId,
        _createdAt = createdAt,
        _lastUpdatedDate = lastUpdatedDate,
        _notes = notes,
        _isDeletedByUser = isDeletedByUser,
        _id = id,
        super(firestoreUtilData);

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

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
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "last_updated_date" field.
  String? _lastUpdatedDate;
  String get lastUpdatedDate => _lastUpdatedDate ?? '';
  set lastUpdatedDate(String? val) => _lastUpdatedDate = val;

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

  static FavoriteObjectStruct fromMap(Map<String, dynamic> data) =>
      FavoriteObjectStruct(
        status: data['status'] as bool?,
        createdBy: data['created_by'] as String?,
        propertyId: data['property_id'] as String?,
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as String?,
        lastUpdatedDate: data['last_updated_date'] as String?,
        notes: data['notes'] as String?,
        isDeletedByUser: data['is_deleted_by_user'] as bool?,
        id: data['id'] as String?,
      );

  static FavoriteObjectStruct? maybeFromMap(dynamic data) => data is Map
      ? FavoriteObjectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'created_by': _createdBy,
        'property_id': _propertyId,
        'user_id': _userId,
        'created_at': _createdAt,
        'last_updated_date': _lastUpdatedDate,
        'notes': _notes,
        'is_deleted_by_user': _isDeletedByUser,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
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
          ParamType.String,
        ),
        'last_updated_date': serializeParam(
          _lastUpdatedDate,
          ParamType.String,
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
      }.withoutNulls;

  static FavoriteObjectStruct fromSerializableMap(Map<String, dynamic> data) =>
      FavoriteObjectStruct(
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
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
          ParamType.String,
          false,
        ),
        lastUpdatedDate: deserializeParam(
          data['last_updated_date'],
          ParamType.String,
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
      );

  @override
  String toString() => 'FavoriteObjectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FavoriteObjectStruct &&
        status == other.status &&
        createdBy == other.createdBy &&
        propertyId == other.propertyId &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        lastUpdatedDate == other.lastUpdatedDate &&
        notes == other.notes &&
        isDeletedByUser == other.isDeletedByUser &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        status,
        createdBy,
        propertyId,
        userId,
        createdAt,
        lastUpdatedDate,
        notes,
        isDeletedByUser,
        id
      ]);
}

FavoriteObjectStruct createFavoriteObjectStruct({
  bool? status,
  String? createdBy,
  String? propertyId,
  String? userId,
  String? createdAt,
  String? lastUpdatedDate,
  String? notes,
  bool? isDeletedByUser,
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavoriteObjectStruct(
      status: status,
      createdBy: createdBy,
      propertyId: propertyId,
      userId: userId,
      createdAt: createdAt,
      lastUpdatedDate: lastUpdatedDate,
      notes: notes,
      isDeletedByUser: isDeletedByUser,
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavoriteObjectStruct? updateFavoriteObjectStruct(
  FavoriteObjectStruct? favoriteObject, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favoriteObject
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavoriteObjectStructData(
  Map<String, dynamic> firestoreData,
  FavoriteObjectStruct? favoriteObject,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favoriteObject == null) {
    return;
  }
  if (favoriteObject.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favoriteObject.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favoriteObjectData =
      getFavoriteObjectFirestoreData(favoriteObject, forFieldValue);
  final nestedData =
      favoriteObjectData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favoriteObject.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavoriteObjectFirestoreData(
  FavoriteObjectStruct? favoriteObject, [
  bool forFieldValue = false,
]) {
  if (favoriteObject == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favoriteObject.toMap());

  // Add any Firestore field values
  favoriteObject.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavoriteObjectListFirestoreData(
  List<FavoriteObjectStruct>? favoriteObjects,
) =>
    favoriteObjects
        ?.map((e) => getFavoriteObjectFirestoreData(e, true))
        .toList() ??
    [];
