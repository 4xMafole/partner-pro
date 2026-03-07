// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ApiUserStruct extends FFFirebaseStruct {
  ApiUserStruct({
    String? userId,
    String? createdBy,
    bool? status,
    String? userName,
    String? displayName,
    String? email,
    String? phone,
    String? identityPhrase,
    String? photoUrl,
    String? accountType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userId = userId,
        _createdBy = createdBy,
        _status = status,
        _userName = userName,
        _displayName = displayName,
        _email = email,
        _phone = phone,
        _identityPhrase = identityPhrase,
        _photoUrl = photoUrl,
        _accountType = accountType,
        super(firestoreUtilData);

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  set userName(String? val) => _userName = val;

  bool hasUserName() => _userName != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "identity_phrase" field.
  String? _identityPhrase;
  String get identityPhrase => _identityPhrase ?? '';
  set identityPhrase(String? val) => _identityPhrase = val;

  bool hasIdentityPhrase() => _identityPhrase != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  set photoUrl(String? val) => _photoUrl = val;

  bool hasPhotoUrl() => _photoUrl != null;

  // "account_type" field.
  String? _accountType;
  String get accountType => _accountType ?? '';
  set accountType(String? val) => _accountType = val;

  bool hasAccountType() => _accountType != null;

  static ApiUserStruct fromMap(Map<String, dynamic> data) => ApiUserStruct(
        userId: data['user_id'] as String?,
        createdBy: data['created_by'] as String?,
        status: data['status'] as bool?,
        userName: data['user_name'] as String?,
        displayName: data['display_name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        identityPhrase: data['identity_phrase'] as String?,
        photoUrl: data['photo_url'] as String?,
        accountType: data['account_type'] as String?,
      );

  static ApiUserStruct? maybeFromMap(dynamic data) =>
      data is Map ? ApiUserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'created_by': _createdBy,
        'status': _status,
        'user_name': _userName,
        'display_name': _displayName,
        'email': _email,
        'phone': _phone,
        'identity_phrase': _identityPhrase,
        'photo_url': _photoUrl,
        'account_type': _accountType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'user_name': serializeParam(
          _userName,
          ParamType.String,
        ),
        'display_name': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'identity_phrase': serializeParam(
          _identityPhrase,
          ParamType.String,
        ),
        'photo_url': serializeParam(
          _photoUrl,
          ParamType.String,
        ),
        'account_type': serializeParam(
          _accountType,
          ParamType.String,
        ),
      }.withoutNulls;

  static ApiUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      ApiUserStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        userName: deserializeParam(
          data['user_name'],
          ParamType.String,
          false,
        ),
        displayName: deserializeParam(
          data['display_name'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        identityPhrase: deserializeParam(
          data['identity_phrase'],
          ParamType.String,
          false,
        ),
        photoUrl: deserializeParam(
          data['photo_url'],
          ParamType.String,
          false,
        ),
        accountType: deserializeParam(
          data['account_type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ApiUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApiUserStruct &&
        userId == other.userId &&
        createdBy == other.createdBy &&
        status == other.status &&
        userName == other.userName &&
        displayName == other.displayName &&
        email == other.email &&
        phone == other.phone &&
        identityPhrase == other.identityPhrase &&
        photoUrl == other.photoUrl &&
        accountType == other.accountType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        createdBy,
        status,
        userName,
        displayName,
        email,
        phone,
        identityPhrase,
        photoUrl,
        accountType
      ]);
}

ApiUserStruct createApiUserStruct({
  String? userId,
  String? createdBy,
  bool? status,
  String? userName,
  String? displayName,
  String? email,
  String? phone,
  String? identityPhrase,
  String? photoUrl,
  String? accountType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ApiUserStruct(
      userId: userId,
      createdBy: createdBy,
      status: status,
      userName: userName,
      displayName: displayName,
      email: email,
      phone: phone,
      identityPhrase: identityPhrase,
      photoUrl: photoUrl,
      accountType: accountType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ApiUserStruct? updateApiUserStruct(
  ApiUserStruct? apiUser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    apiUser
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addApiUserStructData(
  Map<String, dynamic> firestoreData,
  ApiUserStruct? apiUser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (apiUser == null) {
    return;
  }
  if (apiUser.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && apiUser.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final apiUserData = getApiUserFirestoreData(apiUser, forFieldValue);
  final nestedData = apiUserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = apiUser.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getApiUserFirestoreData(
  ApiUserStruct? apiUser, [
  bool forFieldValue = false,
]) {
  if (apiUser == null) {
    return {};
  }
  final firestoreData = mapToFirestore(apiUser.toMap());

  // Add any Firestore field values
  apiUser.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getApiUserListFirestoreData(
  List<ApiUserStruct>? apiUsers,
) =>
    apiUsers?.map((e) => getApiUserFirestoreData(e, true)).toList() ?? [];
