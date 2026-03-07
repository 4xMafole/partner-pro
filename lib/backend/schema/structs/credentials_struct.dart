// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CredentialsStruct extends FFFirebaseStruct {
  CredentialsStruct({
    String? agentID,
    String? fullName,
    String? email,
    String? referredByAgentID,
    CredentialsDataStruct? zipforms,
    CredentialsDataStruct? mls,
    CredentialsDataStruct? crm,
    BrokerageCredentialsDataStruct? brokerage,
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _agentID = agentID,
        _fullName = fullName,
        _email = email,
        _referredByAgentID = referredByAgentID,
        _zipforms = zipforms,
        _mls = mls,
        _crm = crm,
        _brokerage = brokerage,
        _id = id,
        super(firestoreUtilData);

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

  // "referredByAgentID" field.
  String? _referredByAgentID;
  String get referredByAgentID => _referredByAgentID ?? '';
  set referredByAgentID(String? val) => _referredByAgentID = val;

  bool hasReferredByAgentID() => _referredByAgentID != null;

  // "zipforms" field.
  CredentialsDataStruct? _zipforms;
  CredentialsDataStruct get zipforms => _zipforms ?? CredentialsDataStruct();
  set zipforms(CredentialsDataStruct? val) => _zipforms = val;

  void updateZipforms(Function(CredentialsDataStruct) updateFn) {
    updateFn(_zipforms ??= CredentialsDataStruct());
  }

  bool hasZipforms() => _zipforms != null;

  // "mls" field.
  CredentialsDataStruct? _mls;
  CredentialsDataStruct get mls => _mls ?? CredentialsDataStruct();
  set mls(CredentialsDataStruct? val) => _mls = val;

  void updateMls(Function(CredentialsDataStruct) updateFn) {
    updateFn(_mls ??= CredentialsDataStruct());
  }

  bool hasMls() => _mls != null;

  // "crm" field.
  CredentialsDataStruct? _crm;
  CredentialsDataStruct get crm => _crm ?? CredentialsDataStruct();
  set crm(CredentialsDataStruct? val) => _crm = val;

  void updateCrm(Function(CredentialsDataStruct) updateFn) {
    updateFn(_crm ??= CredentialsDataStruct());
  }

  bool hasCrm() => _crm != null;

  // "brokerage" field.
  BrokerageCredentialsDataStruct? _brokerage;
  BrokerageCredentialsDataStruct get brokerage =>
      _brokerage ?? BrokerageCredentialsDataStruct();
  set brokerage(BrokerageCredentialsDataStruct? val) => _brokerage = val;

  void updateBrokerage(Function(BrokerageCredentialsDataStruct) updateFn) {
    updateFn(_brokerage ??= BrokerageCredentialsDataStruct());
  }

  bool hasBrokerage() => _brokerage != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static CredentialsStruct fromMap(Map<String, dynamic> data) =>
      CredentialsStruct(
        agentID: data['agentID'] as String?,
        fullName: data['fullName'] as String?,
        email: data['email'] as String?,
        referredByAgentID: data['referredByAgentID'] as String?,
        zipforms: data['zipforms'] is CredentialsDataStruct
            ? data['zipforms']
            : CredentialsDataStruct.maybeFromMap(data['zipforms']),
        mls: data['mls'] is CredentialsDataStruct
            ? data['mls']
            : CredentialsDataStruct.maybeFromMap(data['mls']),
        crm: data['crm'] is CredentialsDataStruct
            ? data['crm']
            : CredentialsDataStruct.maybeFromMap(data['crm']),
        brokerage: data['brokerage'] is BrokerageCredentialsDataStruct
            ? data['brokerage']
            : BrokerageCredentialsDataStruct.maybeFromMap(data['brokerage']),
        id: data['id'] as String?,
      );

  static CredentialsStruct? maybeFromMap(dynamic data) => data is Map
      ? CredentialsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'agentID': _agentID,
        'fullName': _fullName,
        'email': _email,
        'referredByAgentID': _referredByAgentID,
        'zipforms': _zipforms?.toMap(),
        'mls': _mls?.toMap(),
        'crm': _crm?.toMap(),
        'brokerage': _brokerage?.toMap(),
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
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
        'referredByAgentID': serializeParam(
          _referredByAgentID,
          ParamType.String,
        ),
        'zipforms': serializeParam(
          _zipforms,
          ParamType.DataStruct,
        ),
        'mls': serializeParam(
          _mls,
          ParamType.DataStruct,
        ),
        'crm': serializeParam(
          _crm,
          ParamType.DataStruct,
        ),
        'brokerage': serializeParam(
          _brokerage,
          ParamType.DataStruct,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static CredentialsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CredentialsStruct(
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
        referredByAgentID: deserializeParam(
          data['referredByAgentID'],
          ParamType.String,
          false,
        ),
        zipforms: deserializeStructParam(
          data['zipforms'],
          ParamType.DataStruct,
          false,
          structBuilder: CredentialsDataStruct.fromSerializableMap,
        ),
        mls: deserializeStructParam(
          data['mls'],
          ParamType.DataStruct,
          false,
          structBuilder: CredentialsDataStruct.fromSerializableMap,
        ),
        crm: deserializeStructParam(
          data['crm'],
          ParamType.DataStruct,
          false,
          structBuilder: CredentialsDataStruct.fromSerializableMap,
        ),
        brokerage: deserializeStructParam(
          data['brokerage'],
          ParamType.DataStruct,
          false,
          structBuilder: BrokerageCredentialsDataStruct.fromSerializableMap,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CredentialsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CredentialsStruct &&
        agentID == other.agentID &&
        fullName == other.fullName &&
        email == other.email &&
        referredByAgentID == other.referredByAgentID &&
        zipforms == other.zipforms &&
        mls == other.mls &&
        crm == other.crm &&
        brokerage == other.brokerage &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        agentID,
        fullName,
        email,
        referredByAgentID,
        zipforms,
        mls,
        crm,
        brokerage,
        id
      ]);
}

CredentialsStruct createCredentialsStruct({
  String? agentID,
  String? fullName,
  String? email,
  String? referredByAgentID,
  CredentialsDataStruct? zipforms,
  CredentialsDataStruct? mls,
  CredentialsDataStruct? crm,
  BrokerageCredentialsDataStruct? brokerage,
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CredentialsStruct(
      agentID: agentID,
      fullName: fullName,
      email: email,
      referredByAgentID: referredByAgentID,
      zipforms: zipforms ?? (clearUnsetFields ? CredentialsDataStruct() : null),
      mls: mls ?? (clearUnsetFields ? CredentialsDataStruct() : null),
      crm: crm ?? (clearUnsetFields ? CredentialsDataStruct() : null),
      brokerage: brokerage ??
          (clearUnsetFields ? BrokerageCredentialsDataStruct() : null),
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CredentialsStruct? updateCredentialsStruct(
  CredentialsStruct? credentials, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    credentials
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCredentialsStructData(
  Map<String, dynamic> firestoreData,
  CredentialsStruct? credentials,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (credentials == null) {
    return;
  }
  if (credentials.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && credentials.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final credentialsData =
      getCredentialsFirestoreData(credentials, forFieldValue);
  final nestedData =
      credentialsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = credentials.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCredentialsFirestoreData(
  CredentialsStruct? credentials, [
  bool forFieldValue = false,
]) {
  if (credentials == null) {
    return {};
  }
  final firestoreData = mapToFirestore(credentials.toMap());

  // Handle nested data for "zipforms" field.
  addCredentialsDataStructData(
    firestoreData,
    credentials.hasZipforms() ? credentials.zipforms : null,
    'zipforms',
    forFieldValue,
  );

  // Handle nested data for "mls" field.
  addCredentialsDataStructData(
    firestoreData,
    credentials.hasMls() ? credentials.mls : null,
    'mls',
    forFieldValue,
  );

  // Handle nested data for "crm" field.
  addCredentialsDataStructData(
    firestoreData,
    credentials.hasCrm() ? credentials.crm : null,
    'crm',
    forFieldValue,
  );

  // Handle nested data for "brokerage" field.
  addBrokerageCredentialsDataStructData(
    firestoreData,
    credentials.hasBrokerage() ? credentials.brokerage : null,
    'brokerage',
    forFieldValue,
  );

  // Add any Firestore field values
  credentials.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCredentialsListFirestoreData(
  List<CredentialsStruct>? credentialss,
) =>
    credentialss?.map((e) => getCredentialsFirestoreData(e, true)).toList() ??
    [];
