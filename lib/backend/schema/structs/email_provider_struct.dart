// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmailProviderStruct extends FFFirebaseStruct {
  EmailProviderStruct({
    String? from,
    String? to,
    String? cc,
    String? subject,
    String? contentType,
    String? body,
    EmailAttachmentStruct? attachments,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _from = from,
        _to = to,
        _cc = cc,
        _subject = subject,
        _contentType = contentType,
        _body = body,
        _attachments = attachments,
        super(firestoreUtilData);

  // "from" field.
  String? _from;
  String get from => _from ?? '';
  set from(String? val) => _from = val;

  bool hasFrom() => _from != null;

  // "to" field.
  String? _to;
  String get to => _to ?? '';
  set to(String? val) => _to = val;

  bool hasTo() => _to != null;

  // "cc" field.
  String? _cc;
  String get cc => _cc ?? '';
  set cc(String? val) => _cc = val;

  bool hasCc() => _cc != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  set subject(String? val) => _subject = val;

  bool hasSubject() => _subject != null;

  // "contentType" field.
  String? _contentType;
  String get contentType => _contentType ?? '';
  set contentType(String? val) => _contentType = val;

  bool hasContentType() => _contentType != null;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  set body(String? val) => _body = val;

  bool hasBody() => _body != null;

  // "attachments" field.
  EmailAttachmentStruct? _attachments;
  EmailAttachmentStruct get attachments =>
      _attachments ?? EmailAttachmentStruct();
  set attachments(EmailAttachmentStruct? val) => _attachments = val;

  void updateAttachments(Function(EmailAttachmentStruct) updateFn) {
    updateFn(_attachments ??= EmailAttachmentStruct());
  }

  bool hasAttachments() => _attachments != null;

  static EmailProviderStruct fromMap(Map<String, dynamic> data) =>
      EmailProviderStruct(
        from: data['from'] as String?,
        to: data['to'] as String?,
        cc: data['cc'] as String?,
        subject: data['subject'] as String?,
        contentType: data['contentType'] as String?,
        body: data['body'] as String?,
        attachments: data['attachments'] is EmailAttachmentStruct
            ? data['attachments']
            : EmailAttachmentStruct.maybeFromMap(data['attachments']),
      );

  static EmailProviderStruct? maybeFromMap(dynamic data) => data is Map
      ? EmailProviderStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'from': _from,
        'to': _to,
        'cc': _cc,
        'subject': _subject,
        'contentType': _contentType,
        'body': _body,
        'attachments': _attachments?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'from': serializeParam(
          _from,
          ParamType.String,
        ),
        'to': serializeParam(
          _to,
          ParamType.String,
        ),
        'cc': serializeParam(
          _cc,
          ParamType.String,
        ),
        'subject': serializeParam(
          _subject,
          ParamType.String,
        ),
        'contentType': serializeParam(
          _contentType,
          ParamType.String,
        ),
        'body': serializeParam(
          _body,
          ParamType.String,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static EmailProviderStruct fromSerializableMap(Map<String, dynamic> data) =>
      EmailProviderStruct(
        from: deserializeParam(
          data['from'],
          ParamType.String,
          false,
        ),
        to: deserializeParam(
          data['to'],
          ParamType.String,
          false,
        ),
        cc: deserializeParam(
          data['cc'],
          ParamType.String,
          false,
        ),
        subject: deserializeParam(
          data['subject'],
          ParamType.String,
          false,
        ),
        contentType: deserializeParam(
          data['contentType'],
          ParamType.String,
          false,
        ),
        body: deserializeParam(
          data['body'],
          ParamType.String,
          false,
        ),
        attachments: deserializeStructParam(
          data['attachments'],
          ParamType.DataStruct,
          false,
          structBuilder: EmailAttachmentStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'EmailProviderStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EmailProviderStruct &&
        from == other.from &&
        to == other.to &&
        cc == other.cc &&
        subject == other.subject &&
        contentType == other.contentType &&
        body == other.body &&
        attachments == other.attachments;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([from, to, cc, subject, contentType, body, attachments]);
}

EmailProviderStruct createEmailProviderStruct({
  String? from,
  String? to,
  String? cc,
  String? subject,
  String? contentType,
  String? body,
  EmailAttachmentStruct? attachments,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EmailProviderStruct(
      from: from,
      to: to,
      cc: cc,
      subject: subject,
      contentType: contentType,
      body: body,
      attachments:
          attachments ?? (clearUnsetFields ? EmailAttachmentStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EmailProviderStruct? updateEmailProviderStruct(
  EmailProviderStruct? emailProvider, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    emailProvider
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEmailProviderStructData(
  Map<String, dynamic> firestoreData,
  EmailProviderStruct? emailProvider,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (emailProvider == null) {
    return;
  }
  if (emailProvider.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && emailProvider.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final emailProviderData =
      getEmailProviderFirestoreData(emailProvider, forFieldValue);
  final nestedData =
      emailProviderData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = emailProvider.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEmailProviderFirestoreData(
  EmailProviderStruct? emailProvider, [
  bool forFieldValue = false,
]) {
  if (emailProvider == null) {
    return {};
  }
  final firestoreData = mapToFirestore(emailProvider.toMap());

  // Handle nested data for "attachments" field.
  addEmailAttachmentStructData(
    firestoreData,
    emailProvider.hasAttachments() ? emailProvider.attachments : null,
    'attachments',
    forFieldValue,
  );

  // Add any Firestore field values
  emailProvider.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEmailProviderListFirestoreData(
  List<EmailProviderStruct>? emailProviders,
) =>
    emailProviders
        ?.map((e) => getEmailProviderFirestoreData(e, true))
        .toList() ??
    [];
