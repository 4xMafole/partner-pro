// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserFileStruct extends FFFirebaseStruct {
  UserFileStruct({
    String? id,
    String? name,
    String? url,
    String? content,
    String? createdDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _url = url,
        _content = content,
        _createdDate = createdDate,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "created_date" field.
  String? _createdDate;
  String get createdDate => _createdDate ?? '';
  set createdDate(String? val) => _createdDate = val;

  bool hasCreatedDate() => _createdDate != null;

  static UserFileStruct fromMap(Map<String, dynamic> data) => UserFileStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        url: data['url'] as String?,
        content: data['content'] as String?,
        createdDate: data['created_date'] as String?,
      );

  static UserFileStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserFileStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'url': _url,
        'content': _content,
        'created_date': _createdDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'created_date': serializeParam(
          _createdDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserFileStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserFileStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        createdDate: deserializeParam(
          data['created_date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserFileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserFileStruct &&
        id == other.id &&
        name == other.name &&
        url == other.url &&
        content == other.content &&
        createdDate == other.createdDate;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, name, url, content, createdDate]);
}

UserFileStruct createUserFileStruct({
  String? id,
  String? name,
  String? url,
  String? content,
  String? createdDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserFileStruct(
      id: id,
      name: name,
      url: url,
      content: content,
      createdDate: createdDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserFileStruct? updateUserFileStruct(
  UserFileStruct? userFile, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userFile
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserFileStructData(
  Map<String, dynamic> firestoreData,
  UserFileStruct? userFile,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userFile == null) {
    return;
  }
  if (userFile.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userFile.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userFileData = getUserFileFirestoreData(userFile, forFieldValue);
  final nestedData = userFileData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userFile.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserFileFirestoreData(
  UserFileStruct? userFile, [
  bool forFieldValue = false,
]) {
  if (userFile == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userFile.toMap());

  // Add any Firestore field values
  userFile.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserFileListFirestoreData(
  List<UserFileStruct>? userFiles,
) =>
    userFiles?.map((e) => getUserFileFirestoreData(e, true)).toList() ?? [];
