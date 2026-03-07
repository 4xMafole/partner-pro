// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitationTypeStruct extends FFFirebaseStruct {
  InvitationTypeStruct({
    String? inviterUid,
    String? inviterName,
    String? inviteeEmail,
    String? inviteeName,
    String? inviteePhoneNumber,
    String? inviteeType,
    String? status,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _inviterUid = inviterUid,
        _inviterName = inviterName,
        _inviteeEmail = inviteeEmail,
        _inviteeName = inviteeName,
        _inviteePhoneNumber = inviteePhoneNumber,
        _inviteeType = inviteeType,
        _status = status,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "inviterUid" field.
  String? _inviterUid;
  String get inviterUid => _inviterUid ?? '';
  set inviterUid(String? val) => _inviterUid = val;

  bool hasInviterUid() => _inviterUid != null;

  // "inviterName" field.
  String? _inviterName;
  String get inviterName => _inviterName ?? '';
  set inviterName(String? val) => _inviterName = val;

  bool hasInviterName() => _inviterName != null;

  // "inviteeEmail" field.
  String? _inviteeEmail;
  String get inviteeEmail => _inviteeEmail ?? '';
  set inviteeEmail(String? val) => _inviteeEmail = val;

  bool hasInviteeEmail() => _inviteeEmail != null;

  // "inviteeName" field.
  String? _inviteeName;
  String get inviteeName => _inviteeName ?? '';
  set inviteeName(String? val) => _inviteeName = val;

  bool hasInviteeName() => _inviteeName != null;

  // "inviteePhoneNumber" field.
  String? _inviteePhoneNumber;
  String get inviteePhoneNumber => _inviteePhoneNumber ?? '';
  set inviteePhoneNumber(String? val) => _inviteePhoneNumber = val;

  bool hasInviteePhoneNumber() => _inviteePhoneNumber != null;

  // "inviteeType" field.
  String? _inviteeType;
  String get inviteeType => _inviteeType ?? '';
  set inviteeType(String? val) => _inviteeType = val;

  bool hasInviteeType() => _inviteeType != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static InvitationTypeStruct fromMap(Map<String, dynamic> data) =>
      InvitationTypeStruct(
        inviterUid: data['inviterUid'] as String?,
        inviterName: data['inviterName'] as String?,
        inviteeEmail: data['inviteeEmail'] as String?,
        inviteeName: data['inviteeName'] as String?,
        inviteePhoneNumber: data['inviteePhoneNumber'] as String?,
        inviteeType: data['inviteeType'] as String?,
        status: data['status'] as String?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static InvitationTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? InvitationTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'inviterUid': _inviterUid,
        'inviterName': _inviterName,
        'inviteeEmail': _inviteeEmail,
        'inviteeName': _inviteeName,
        'inviteePhoneNumber': _inviteePhoneNumber,
        'inviteeType': _inviteeType,
        'status': _status,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'inviterUid': serializeParam(
          _inviterUid,
          ParamType.String,
        ),
        'inviterName': serializeParam(
          _inviterName,
          ParamType.String,
        ),
        'inviteeEmail': serializeParam(
          _inviteeEmail,
          ParamType.String,
        ),
        'inviteeName': serializeParam(
          _inviteeName,
          ParamType.String,
        ),
        'inviteePhoneNumber': serializeParam(
          _inviteePhoneNumber,
          ParamType.String,
        ),
        'inviteeType': serializeParam(
          _inviteeType,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static InvitationTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      InvitationTypeStruct(
        inviterUid: deserializeParam(
          data['inviterUid'],
          ParamType.String,
          false,
        ),
        inviterName: deserializeParam(
          data['inviterName'],
          ParamType.String,
          false,
        ),
        inviteeEmail: deserializeParam(
          data['inviteeEmail'],
          ParamType.String,
          false,
        ),
        inviteeName: deserializeParam(
          data['inviteeName'],
          ParamType.String,
          false,
        ),
        inviteePhoneNumber: deserializeParam(
          data['inviteePhoneNumber'],
          ParamType.String,
          false,
        ),
        inviteeType: deserializeParam(
          data['inviteeType'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'InvitationTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InvitationTypeStruct &&
        inviterUid == other.inviterUid &&
        inviterName == other.inviterName &&
        inviteeEmail == other.inviteeEmail &&
        inviteeName == other.inviteeName &&
        inviteePhoneNumber == other.inviteePhoneNumber &&
        inviteeType == other.inviteeType &&
        status == other.status &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        inviterUid,
        inviterName,
        inviteeEmail,
        inviteeName,
        inviteePhoneNumber,
        inviteeType,
        status,
        createdAt
      ]);
}

InvitationTypeStruct createInvitationTypeStruct({
  String? inviterUid,
  String? inviterName,
  String? inviteeEmail,
  String? inviteeName,
  String? inviteePhoneNumber,
  String? inviteeType,
  String? status,
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    InvitationTypeStruct(
      inviterUid: inviterUid,
      inviterName: inviterName,
      inviteeEmail: inviteeEmail,
      inviteeName: inviteeName,
      inviteePhoneNumber: inviteePhoneNumber,
      inviteeType: inviteeType,
      status: status,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

InvitationTypeStruct? updateInvitationTypeStruct(
  InvitationTypeStruct? invitationType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    invitationType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addInvitationTypeStructData(
  Map<String, dynamic> firestoreData,
  InvitationTypeStruct? invitationType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (invitationType == null) {
    return;
  }
  if (invitationType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && invitationType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final invitationTypeData =
      getInvitationTypeFirestoreData(invitationType, forFieldValue);
  final nestedData =
      invitationTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = invitationType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getInvitationTypeFirestoreData(
  InvitationTypeStruct? invitationType, [
  bool forFieldValue = false,
]) {
  if (invitationType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(invitationType.toMap());

  // Add any Firestore field values
  invitationType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getInvitationTypeListFirestoreData(
  List<InvitationTypeStruct>? invitationTypes,
) =>
    invitationTypes
        ?.map((e) => getInvitationTypeFirestoreData(e, true))
        .toList() ??
    [];
