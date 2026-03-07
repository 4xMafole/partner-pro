// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApiTokenStruct extends FFFirebaseStruct {
  ApiTokenStruct({
    String? token,
    DateTime? createdTime,
    String? hours,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _token = token,
        _createdTime = createdTime,
        _hours = hours,
        super(firestoreUtilData);

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  set createdTime(DateTime? val) => _createdTime = val;

  bool hasCreatedTime() => _createdTime != null;

  // "hours" field.
  String? _hours;
  String get hours => _hours ?? '';
  set hours(String? val) => _hours = val;

  bool hasHours() => _hours != null;

  static ApiTokenStruct fromMap(Map<String, dynamic> data) => ApiTokenStruct(
        token: data['token'] as String?,
        createdTime: data['created_time'] as DateTime?,
        hours: data['hours'] as String?,
      );

  static ApiTokenStruct? maybeFromMap(dynamic data) =>
      data is Map ? ApiTokenStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'token': _token,
        'created_time': _createdTime,
        'hours': _hours,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'created_time': serializeParam(
          _createdTime,
          ParamType.DateTime,
        ),
        'hours': serializeParam(
          _hours,
          ParamType.String,
        ),
      }.withoutNulls;

  static ApiTokenStruct fromSerializableMap(Map<String, dynamic> data) =>
      ApiTokenStruct(
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        createdTime: deserializeParam(
          data['created_time'],
          ParamType.DateTime,
          false,
        ),
        hours: deserializeParam(
          data['hours'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ApiTokenStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApiTokenStruct &&
        token == other.token &&
        createdTime == other.createdTime &&
        hours == other.hours;
  }

  @override
  int get hashCode => const ListEquality().hash([token, createdTime, hours]);
}

ApiTokenStruct createApiTokenStruct({
  String? token,
  DateTime? createdTime,
  String? hours,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ApiTokenStruct(
      token: token,
      createdTime: createdTime,
      hours: hours,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ApiTokenStruct? updateApiTokenStruct(
  ApiTokenStruct? apiToken, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    apiToken
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addApiTokenStructData(
  Map<String, dynamic> firestoreData,
  ApiTokenStruct? apiToken,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (apiToken == null) {
    return;
  }
  if (apiToken.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && apiToken.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final apiTokenData = getApiTokenFirestoreData(apiToken, forFieldValue);
  final nestedData = apiTokenData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = apiToken.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getApiTokenFirestoreData(
  ApiTokenStruct? apiToken, [
  bool forFieldValue = false,
]) {
  if (apiToken == null) {
    return {};
  }
  final firestoreData = mapToFirestore(apiToken.toMap());

  // Add any Firestore field values
  apiToken.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getApiTokenListFirestoreData(
  List<ApiTokenStruct>? apiTokens,
) =>
    apiTokens?.map((e) => getApiTokenFirestoreData(e, true)).toList() ?? [];
