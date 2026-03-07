// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FileInfoStruct extends FFFirebaseStruct {
  FileInfoStruct({
    String? fileName,
    String? fileSize,
    String? fileUrl,
    String? content,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fileName = fileName,
        _fileSize = fileSize,
        _fileUrl = fileUrl,
        _content = content,
        super(firestoreUtilData);

  // "fileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  set fileName(String? val) => _fileName = val;

  bool hasFileName() => _fileName != null;

  // "fileSize" field.
  String? _fileSize;
  String get fileSize => _fileSize ?? '';
  set fileSize(String? val) => _fileSize = val;

  bool hasFileSize() => _fileSize != null;

  // "fileUrl" field.
  String? _fileUrl;
  String get fileUrl => _fileUrl ?? '';
  set fileUrl(String? val) => _fileUrl = val;

  bool hasFileUrl() => _fileUrl != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static FileInfoStruct fromMap(Map<String, dynamic> data) => FileInfoStruct(
        fileName: data['fileName'] as String?,
        fileSize: data['fileSize'] as String?,
        fileUrl: data['fileUrl'] as String?,
        content: data['content'] as String?,
      );

  static FileInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? FileInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'fileName': _fileName,
        'fileSize': _fileSize,
        'fileUrl': _fileUrl,
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fileName': serializeParam(
          _fileName,
          ParamType.String,
        ),
        'fileSize': serializeParam(
          _fileSize,
          ParamType.String,
        ),
        'fileUrl': serializeParam(
          _fileUrl,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static FileInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileInfoStruct(
        fileName: deserializeParam(
          data['fileName'],
          ParamType.String,
          false,
        ),
        fileSize: deserializeParam(
          data['fileSize'],
          ParamType.String,
          false,
        ),
        fileUrl: deserializeParam(
          data['fileUrl'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FileInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileInfoStruct &&
        fileName == other.fileName &&
        fileSize == other.fileSize &&
        fileUrl == other.fileUrl &&
        content == other.content;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([fileName, fileSize, fileUrl, content]);
}

FileInfoStruct createFileInfoStruct({
  String? fileName,
  String? fileSize,
  String? fileUrl,
  String? content,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileInfoStruct(
      fileName: fileName,
      fileSize: fileSize,
      fileUrl: fileUrl,
      content: content,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileInfoStruct? updateFileInfoStruct(
  FileInfoStruct? fileInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileInfoStructData(
  Map<String, dynamic> firestoreData,
  FileInfoStruct? fileInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileInfo == null) {
    return;
  }
  if (fileInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileInfoData = getFileInfoFirestoreData(fileInfo, forFieldValue);
  final nestedData = fileInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileInfoFirestoreData(
  FileInfoStruct? fileInfo, [
  bool forFieldValue = false,
]) {
  if (fileInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileInfo.toMap());

  // Add any Firestore field values
  fileInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileInfoListFirestoreData(
  List<FileInfoStruct>? fileInfos,
) =>
    fileInfos?.map((e) => getFileInfoFirestoreData(e, true)).toList() ?? [];
