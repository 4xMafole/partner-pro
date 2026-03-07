// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmailAttachmentStruct extends FFFirebaseStruct {
  EmailAttachmentStruct({
    String? name,
    String? contentType,
    String? content,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _contentType = contentType,
        _content = content,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "contentType" field.
  String? _contentType;
  String get contentType => _contentType ?? '';
  set contentType(String? val) => _contentType = val;

  bool hasContentType() => _contentType != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static EmailAttachmentStruct fromMap(Map<String, dynamic> data) =>
      EmailAttachmentStruct(
        name: data['name'] as String?,
        contentType: data['contentType'] as String?,
        content: data['content'] as String?,
      );

  static EmailAttachmentStruct? maybeFromMap(dynamic data) => data is Map
      ? EmailAttachmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'contentType': _contentType,
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'contentType': serializeParam(
          _contentType,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static EmailAttachmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      EmailAttachmentStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        contentType: deserializeParam(
          data['contentType'],
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
  String toString() => 'EmailAttachmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EmailAttachmentStruct &&
        name == other.name &&
        contentType == other.contentType &&
        content == other.content;
  }

  @override
  int get hashCode => const ListEquality().hash([name, contentType, content]);
}

EmailAttachmentStruct createEmailAttachmentStruct({
  String? name,
  String? contentType,
  String? content,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EmailAttachmentStruct(
      name: name,
      contentType: contentType,
      content: content,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EmailAttachmentStruct? updateEmailAttachmentStruct(
  EmailAttachmentStruct? emailAttachment, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    emailAttachment
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEmailAttachmentStructData(
  Map<String, dynamic> firestoreData,
  EmailAttachmentStruct? emailAttachment,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (emailAttachment == null) {
    return;
  }
  if (emailAttachment.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && emailAttachment.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final emailAttachmentData =
      getEmailAttachmentFirestoreData(emailAttachment, forFieldValue);
  final nestedData =
      emailAttachmentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = emailAttachment.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEmailAttachmentFirestoreData(
  EmailAttachmentStruct? emailAttachment, [
  bool forFieldValue = false,
]) {
  if (emailAttachment == null) {
    return {};
  }
  final firestoreData = mapToFirestore(emailAttachment.toMap());

  // Add any Firestore field values
  emailAttachment.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEmailAttachmentListFirestoreData(
  List<EmailAttachmentStruct>? emailAttachments,
) =>
    emailAttachments
        ?.map((e) => getEmailAttachmentFirestoreData(e, true))
        .toList() ??
    [];
