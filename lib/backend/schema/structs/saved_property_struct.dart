// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SavedPropertyStruct extends FFFirebaseStruct {
  SavedPropertyStruct({
    String? userId,
    String? createdAt,
    bool? status,
    SearchStruct? search,
    bool? isDeletedByUser,
    String? updatedAt,
    String? updatedBy,
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userId = userId,
        _createdAt = createdAt,
        _status = status,
        _search = search,
        _isDeletedByUser = isDeletedByUser,
        _updatedAt = updatedAt,
        _updatedBy = updatedBy,
        _id = id,
        super(firestoreUtilData);

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

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "search" field.
  SearchStruct? _search;
  SearchStruct get search => _search ?? SearchStruct();
  set search(SearchStruct? val) => _search = val;

  void updateSearch(Function(SearchStruct) updateFn) {
    updateFn(_search ??= SearchStruct());
  }

  bool hasSearch() => _search != null;

  // "is_deleted_by_user" field.
  bool? _isDeletedByUser;
  bool get isDeletedByUser => _isDeletedByUser ?? false;
  set isDeletedByUser(bool? val) => _isDeletedByUser = val;

  bool hasIsDeletedByUser() => _isDeletedByUser != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static SavedPropertyStruct fromMap(Map<String, dynamic> data) =>
      SavedPropertyStruct(
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as String?,
        status: data['status'] as bool?,
        search: data['search'] is SearchStruct
            ? data['search']
            : SearchStruct.maybeFromMap(data['search']),
        isDeletedByUser: data['is_deleted_by_user'] as bool?,
        updatedAt: data['updated_at'] as String?,
        updatedBy: data['updated_by'] as String?,
        id: data['id'] as String?,
      );

  static SavedPropertyStruct? maybeFromMap(dynamic data) => data is Map
      ? SavedPropertyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'created_at': _createdAt,
        'status': _status,
        'search': _search?.toMap(),
        'is_deleted_by_user': _isDeletedByUser,
        'updated_at': _updatedAt,
        'updated_by': _updatedBy,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'search': serializeParam(
          _search,
          ParamType.DataStruct,
        ),
        'is_deleted_by_user': serializeParam(
          _isDeletedByUser,
          ParamType.bool,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static SavedPropertyStruct fromSerializableMap(Map<String, dynamic> data) =>
      SavedPropertyStruct(
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
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        search: deserializeStructParam(
          data['search'],
          ParamType.DataStruct,
          false,
          structBuilder: SearchStruct.fromSerializableMap,
        ),
        isDeletedByUser: deserializeParam(
          data['is_deleted_by_user'],
          ParamType.bool,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SavedPropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SavedPropertyStruct &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        status == other.status &&
        search == other.search &&
        isDeletedByUser == other.isDeletedByUser &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        createdAt,
        status,
        search,
        isDeletedByUser,
        updatedAt,
        updatedBy,
        id
      ]);
}

SavedPropertyStruct createSavedPropertyStruct({
  String? userId,
  String? createdAt,
  bool? status,
  SearchStruct? search,
  bool? isDeletedByUser,
  String? updatedAt,
  String? updatedBy,
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SavedPropertyStruct(
      userId: userId,
      createdAt: createdAt,
      status: status,
      search: search ?? (clearUnsetFields ? SearchStruct() : null),
      isDeletedByUser: isDeletedByUser,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SavedPropertyStruct? updateSavedPropertyStruct(
  SavedPropertyStruct? savedProperty, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    savedProperty
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSavedPropertyStructData(
  Map<String, dynamic> firestoreData,
  SavedPropertyStruct? savedProperty,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (savedProperty == null) {
    return;
  }
  if (savedProperty.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && savedProperty.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final savedPropertyData =
      getSavedPropertyFirestoreData(savedProperty, forFieldValue);
  final nestedData =
      savedPropertyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = savedProperty.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSavedPropertyFirestoreData(
  SavedPropertyStruct? savedProperty, [
  bool forFieldValue = false,
]) {
  if (savedProperty == null) {
    return {};
  }
  final firestoreData = mapToFirestore(savedProperty.toMap());

  // Handle nested data for "search" field.
  addSearchStructData(
    firestoreData,
    savedProperty.hasSearch() ? savedProperty.search : null,
    'search',
    forFieldValue,
  );

  // Add any Firestore field values
  savedProperty.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSavedPropertyListFirestoreData(
  List<SavedPropertyStruct>? savedPropertys,
) =>
    savedPropertys
        ?.map((e) => getSavedPropertyFirestoreData(e, true))
        .toList() ??
    [];
