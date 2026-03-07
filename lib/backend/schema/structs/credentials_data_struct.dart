// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CredentialsDataStruct extends FFFirebaseStruct {
  CredentialsDataStruct({
    String? emailOrUsername,
    String? password,
    String? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _emailOrUsername = emailOrUsername,
        _password = password,
        _type = type,
        super(firestoreUtilData);

  // "emailOrUsername" field.
  String? _emailOrUsername;
  String get emailOrUsername => _emailOrUsername ?? '';
  set emailOrUsername(String? val) => _emailOrUsername = val;

  bool hasEmailOrUsername() => _emailOrUsername != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static CredentialsDataStruct fromMap(Map<String, dynamic> data) =>
      CredentialsDataStruct(
        emailOrUsername: data['emailOrUsername'] as String?,
        password: data['password'] as String?,
        type: data['type'] as String?,
      );

  static CredentialsDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CredentialsDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'emailOrUsername': _emailOrUsername,
        'password': _password,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'emailOrUsername': serializeParam(
          _emailOrUsername,
          ParamType.String,
        ),
        'password': serializeParam(
          _password,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static CredentialsDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CredentialsDataStruct(
        emailOrUsername: deserializeParam(
          data['emailOrUsername'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['password'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CredentialsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CredentialsDataStruct &&
        emailOrUsername == other.emailOrUsername &&
        password == other.password &&
        type == other.type;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([emailOrUsername, password, type]);
}

CredentialsDataStruct createCredentialsDataStruct({
  String? emailOrUsername,
  String? password,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CredentialsDataStruct(
      emailOrUsername: emailOrUsername,
      password: password,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CredentialsDataStruct? updateCredentialsDataStruct(
  CredentialsDataStruct? credentialsData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    credentialsData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCredentialsDataStructData(
  Map<String, dynamic> firestoreData,
  CredentialsDataStruct? credentialsData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (credentialsData == null) {
    return;
  }
  if (credentialsData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && credentialsData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final credentialsDataData =
      getCredentialsDataFirestoreData(credentialsData, forFieldValue);
  final nestedData =
      credentialsDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = credentialsData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCredentialsDataFirestoreData(
  CredentialsDataStruct? credentialsData, [
  bool forFieldValue = false,
]) {
  if (credentialsData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(credentialsData.toMap());

  // Add any Firestore field values
  credentialsData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCredentialsDataListFirestoreData(
  List<CredentialsDataStruct>? credentialsDatas,
) =>
    credentialsDatas
        ?.map((e) => getCredentialsDataFirestoreData(e, true))
        .toList() ??
    [];
