// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SMSProviderStruct extends FFFirebaseStruct {
  SMSProviderStruct({
    String? sender,
    String? recipient,
    String? content,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _sender = sender,
        _recipient = recipient,
        _content = content,
        super(firestoreUtilData);

  // "sender" field.
  String? _sender;
  String get sender => _sender ?? '';
  set sender(String? val) => _sender = val;

  bool hasSender() => _sender != null;

  // "recipient" field.
  String? _recipient;
  String get recipient => _recipient ?? '';
  set recipient(String? val) => _recipient = val;

  bool hasRecipient() => _recipient != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static SMSProviderStruct fromMap(Map<String, dynamic> data) =>
      SMSProviderStruct(
        sender: data['sender'] as String?,
        recipient: data['recipient'] as String?,
        content: data['content'] as String?,
      );

  static SMSProviderStruct? maybeFromMap(dynamic data) => data is Map
      ? SMSProviderStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'sender': _sender,
        'recipient': _recipient,
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'sender': serializeParam(
          _sender,
          ParamType.String,
        ),
        'recipient': serializeParam(
          _recipient,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static SMSProviderStruct fromSerializableMap(Map<String, dynamic> data) =>
      SMSProviderStruct(
        sender: deserializeParam(
          data['sender'],
          ParamType.String,
          false,
        ),
        recipient: deserializeParam(
          data['recipient'],
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
  String toString() => 'SMSProviderStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SMSProviderStruct &&
        sender == other.sender &&
        recipient == other.recipient &&
        content == other.content;
  }

  @override
  int get hashCode => const ListEquality().hash([sender, recipient, content]);
}

SMSProviderStruct createSMSProviderStruct({
  String? sender,
  String? recipient,
  String? content,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SMSProviderStruct(
      sender: sender,
      recipient: recipient,
      content: content,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SMSProviderStruct? updateSMSProviderStruct(
  SMSProviderStruct? sMSProvider, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sMSProvider
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSMSProviderStructData(
  Map<String, dynamic> firestoreData,
  SMSProviderStruct? sMSProvider,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sMSProvider == null) {
    return;
  }
  if (sMSProvider.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && sMSProvider.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sMSProviderData =
      getSMSProviderFirestoreData(sMSProvider, forFieldValue);
  final nestedData =
      sMSProviderData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = sMSProvider.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSMSProviderFirestoreData(
  SMSProviderStruct? sMSProvider, [
  bool forFieldValue = false,
]) {
  if (sMSProvider == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sMSProvider.toMap());

  // Add any Firestore field values
  sMSProvider.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSMSProviderListFirestoreData(
  List<SMSProviderStruct>? sMSProviders,
) =>
    sMSProviders?.map((e) => getSMSProviderFirestoreData(e, true)).toList() ??
    [];
