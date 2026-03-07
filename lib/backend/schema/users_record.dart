import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "short_desc" field.
  String? _shortDesc;
  String get shortDesc => _shortDesc ?? '';
  bool hasShortDesc() => _shortDesc != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "role" field.
  UserType? _role;
  UserType? get role => _role;
  bool hasRole() => _role != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "zip_code" field.
  String? _zipCode;
  String get zipCode => _zipCode ?? '';
  bool hasZipCode() => _zipCode != null;

  // "birth_day" field.
  DateTime? _birthDay;
  DateTime? get birthDay => _birthDay;
  bool hasBirthDay() => _birthDay != null;

  // "user_IDCard" field.
  UserIDCardStruct? _userIDCard;
  UserIDCardStruct get userIDCard => _userIDCard ?? UserIDCardStruct();
  bool hasUserIDCard() => _userIDCard != null;

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  bool hasLastName() => _lastName != null;

  // "updated_time" field.
  DateTime? _updatedTime;
  DateTime? get updatedTime => _updatedTime;
  bool hasUpdatedTime() => _updatedTime != null;

  // "approv_status" field.
  ApproveStatus? _approvStatus;
  ApproveStatus? get approvStatus => _approvStatus;
  bool hasApprovStatus() => _approvStatus != null;

  // "list_of_ID" field.
  List<String>? _listOfID;
  List<String> get listOfID => _listOfID ?? const [];
  bool hasListOfID() => _listOfID != null;

  // "notes_list" field.
  List<String>? _notesList;
  List<String> get notesList => _notesList ?? const [];
  bool hasNotesList() => _notesList != null;

  // "signature" field.
  String? _signature;
  String get signature => _signature ?? '';
  bool hasSignature() => _signature != null;

  // "proof_of_funds" field.
  ProofOfFundsStruct? _proofOfFunds;
  ProofOfFundsStruct get proofOfFunds => _proofOfFunds ?? ProofOfFundsStruct();
  bool hasProofOfFunds() => _proofOfFunds != null;

  // "agency" field.
  String? _agency;
  String get agency => _agency ?? '';
  bool hasAgency() => _agency != null;

  // "agent_app_logos" field.
  List<String>? _agentAppLogos;
  List<String> get agentAppLogos => _agentAppLogos ?? const [];
  bool hasAgentAppLogos() => _agentAppLogos != null;

  // "hasAutoApproved" field.
  bool? _hasAutoApproved;
  bool get hasAutoApproved => _hasAutoApproved ?? false;
  bool hasHasAutoApproved() => _hasAutoApproved != null;

  // "hasAcceptedSMS" field.
  bool? _hasAcceptedSMS;
  bool get hasAcceptedSMS => _hasAcceptedSMS ?? false;
  bool hasHasAcceptedSMS() => _hasAcceptedSMS != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _shortDesc = snapshotData['short_desc'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _role = snapshotData['role'] is UserType
        ? snapshotData['role']
        : deserializeEnum<UserType>(snapshotData['role']);
    _shortDescription = snapshotData['shortDescription'] as String?;
    _state = snapshotData['state'] as String?;
    _zipCode = snapshotData['zip_code'] as String?;
    _birthDay = snapshotData['birth_day'] as DateTime?;
    _userIDCard = snapshotData['user_IDCard'] is UserIDCardStruct
        ? snapshotData['user_IDCard']
        : UserIDCardStruct.maybeFromMap(snapshotData['user_IDCard']);
    _firstName = snapshotData['first_name'] as String?;
    _lastName = snapshotData['last_name'] as String?;
    _updatedTime = snapshotData['updated_time'] as DateTime?;
    _approvStatus = snapshotData['approv_status'] is ApproveStatus
        ? snapshotData['approv_status']
        : deserializeEnum<ApproveStatus>(snapshotData['approv_status']);
    _listOfID = getDataList(snapshotData['list_of_ID']);
    _notesList = getDataList(snapshotData['notes_list']);
    _signature = snapshotData['signature'] as String?;
    _proofOfFunds = snapshotData['proof_of_funds'] is ProofOfFundsStruct
        ? snapshotData['proof_of_funds']
        : ProofOfFundsStruct.maybeFromMap(snapshotData['proof_of_funds']);
    _agency = snapshotData['agency'] as String?;
    _agentAppLogos = getDataList(snapshotData['agent_app_logos']);
    _hasAutoApproved = snapshotData['hasAutoApproved'] as bool?;
    _hasAcceptedSMS = snapshotData['hasAcceptedSMS'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? shortDesc,
  DateTime? lastActiveTime,
  String? title,
  UserType? role,
  String? shortDescription,
  String? state,
  String? zipCode,
  DateTime? birthDay,
  UserIDCardStruct? userIDCard,
  String? firstName,
  String? lastName,
  DateTime? updatedTime,
  ApproveStatus? approvStatus,
  String? signature,
  ProofOfFundsStruct? proofOfFunds,
  String? agency,
  bool? hasAutoApproved,
  bool? hasAcceptedSMS,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'short_desc': shortDesc,
      'last_active_time': lastActiveTime,
      'title': title,
      'role': role,
      'shortDescription': shortDescription,
      'state': state,
      'zip_code': zipCode,
      'birth_day': birthDay,
      'user_IDCard': UserIDCardStruct().toMap(),
      'first_name': firstName,
      'last_name': lastName,
      'updated_time': updatedTime,
      'approv_status': approvStatus,
      'signature': signature,
      'proof_of_funds': ProofOfFundsStruct().toMap(),
      'agency': agency,
      'hasAutoApproved': hasAutoApproved,
      'hasAcceptedSMS': hasAcceptedSMS,
    }.withoutNulls,
  );

  // Handle nested data for "user_IDCard" field.
  addUserIDCardStructData(firestoreData, userIDCard, 'user_IDCard');

  // Handle nested data for "proof_of_funds" field.
  addProofOfFundsStructData(firestoreData, proofOfFunds, 'proof_of_funds');

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.shortDesc == e2?.shortDesc &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.title == e2?.title &&
        e1?.role == e2?.role &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.state == e2?.state &&
        e1?.zipCode == e2?.zipCode &&
        e1?.birthDay == e2?.birthDay &&
        e1?.userIDCard == e2?.userIDCard &&
        e1?.firstName == e2?.firstName &&
        e1?.lastName == e2?.lastName &&
        e1?.updatedTime == e2?.updatedTime &&
        e1?.approvStatus == e2?.approvStatus &&
        listEquality.equals(e1?.listOfID, e2?.listOfID) &&
        listEquality.equals(e1?.notesList, e2?.notesList) &&
        e1?.signature == e2?.signature &&
        e1?.proofOfFunds == e2?.proofOfFunds &&
        e1?.agency == e2?.agency &&
        listEquality.equals(e1?.agentAppLogos, e2?.agentAppLogos) &&
        e1?.hasAutoApproved == e2?.hasAutoApproved &&
        e1?.hasAcceptedSMS == e2?.hasAcceptedSMS;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.shortDesc,
        e?.lastActiveTime,
        e?.title,
        e?.role,
        e?.shortDescription,
        e?.state,
        e?.zipCode,
        e?.birthDay,
        e?.userIDCard,
        e?.firstName,
        e?.lastName,
        e?.updatedTime,
        e?.approvStatus,
        e?.listOfID,
        e?.notesList,
        e?.signature,
        e?.proofOfFunds,
        e?.agency,
        e?.agentAppLogos,
        e?.hasAutoApproved,
        e?.hasAcceptedSMS
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
