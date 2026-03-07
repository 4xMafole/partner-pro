// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MemberStruct extends FFFirebaseStruct {
  MemberStruct({
    String? clientID,
    String? agentID,
    String? fullName,
    String? email,
    String? id,
    String? photoUrl,
    String? phoneNumber,
    Status? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _clientID = clientID,
        _agentID = agentID,
        _fullName = fullName,
        _email = email,
        _id = id,
        _photoUrl = photoUrl,
        _phoneNumber = phoneNumber,
        _status = status,
        super(firestoreUtilData);

  // "clientID" field.
  String? _clientID;
  String get clientID => _clientID ?? '';
  set clientID(String? val) => _clientID = val;

  bool hasClientID() => _clientID != null;

  // "agentID" field.
  String? _agentID;
  String get agentID => _agentID ?? '';
  set agentID(String? val) => _agentID = val;

  bool hasAgentID() => _agentID != null;

  // "fullName" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  set fullName(String? val) => _fullName = val;

  bool hasFullName() => _fullName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "photoUrl" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  set photoUrl(String? val) => _photoUrl = val;

  bool hasPhotoUrl() => _photoUrl != null;

  // "phoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "status" field.
  Status? _status;
  Status? get status => _status;
  set status(Status? val) => _status = val;

  bool hasStatus() => _status != null;

  static MemberStruct fromMap(Map<String, dynamic> data) => MemberStruct(
        clientID: data['clientID'] as String?,
        agentID: data['agentID'] as String?,
        fullName: data['fullName'] as String?,
        email: data['email'] as String?,
        id: data['id'] as String?,
        photoUrl: data['photoUrl'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
        status: data['status'] is Status
            ? data['status']
            : deserializeEnum<Status>(data['status']),
      );

  static MemberStruct? maybeFromMap(dynamic data) =>
      data is Map ? MemberStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'clientID': _clientID,
        'agentID': _agentID,
        'fullName': _fullName,
        'email': _email,
        'id': _id,
        'photoUrl': _photoUrl,
        'phoneNumber': _phoneNumber,
        'status': _status?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clientID': serializeParam(
          _clientID,
          ParamType.String,
        ),
        'agentID': serializeParam(
          _agentID,
          ParamType.String,
        ),
        'fullName': serializeParam(
          _fullName,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'photoUrl': serializeParam(
          _photoUrl,
          ParamType.String,
        ),
        'phoneNumber': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static MemberStruct fromSerializableMap(Map<String, dynamic> data) =>
      MemberStruct(
        clientID: deserializeParam(
          data['clientID'],
          ParamType.String,
          false,
        ),
        agentID: deserializeParam(
          data['agentID'],
          ParamType.String,
          false,
        ),
        fullName: deserializeParam(
          data['fullName'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        photoUrl: deserializeParam(
          data['photoUrl'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phoneNumber'],
          ParamType.String,
          false,
        ),
        status: deserializeParam<Status>(
          data['status'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'MemberStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MemberStruct &&
        clientID == other.clientID &&
        agentID == other.agentID &&
        fullName == other.fullName &&
        email == other.email &&
        id == other.id &&
        photoUrl == other.photoUrl &&
        phoneNumber == other.phoneNumber &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [clientID, agentID, fullName, email, id, photoUrl, phoneNumber, status]);
}

MemberStruct createMemberStruct({
  String? clientID,
  String? agentID,
  String? fullName,
  String? email,
  String? id,
  String? photoUrl,
  String? phoneNumber,
  Status? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MemberStruct(
      clientID: clientID,
      agentID: agentID,
      fullName: fullName,
      email: email,
      id: id,
      photoUrl: photoUrl,
      phoneNumber: phoneNumber,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MemberStruct? updateMemberStruct(
  MemberStruct? member, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    member
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMemberStructData(
  Map<String, dynamic> firestoreData,
  MemberStruct? member,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (member == null) {
    return;
  }
  if (member.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && member.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final memberData = getMemberFirestoreData(member, forFieldValue);
  final nestedData = memberData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = member.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMemberFirestoreData(
  MemberStruct? member, [
  bool forFieldValue = false,
]) {
  if (member == null) {
    return {};
  }
  final firestoreData = mapToFirestore(member.toMap());

  // Add any Firestore field values
  member.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMemberListFirestoreData(
  List<MemberStruct>? members,
) =>
    members?.map((e) => getMemberFirestoreData(e, true)).toList() ?? [];
