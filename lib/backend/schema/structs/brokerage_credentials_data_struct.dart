// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BrokerageCredentialsDataStruct extends FFFirebaseStruct {
  BrokerageCredentialsDataStruct({
    String? name,
    String? licenceNumber,
    String? address,
    String? phoneNumber,
    String? agentLicenseNumber,
    CredentialsDataStruct? website,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _licenceNumber = licenceNumber,
        _address = address,
        _phoneNumber = phoneNumber,
        _agentLicenseNumber = agentLicenseNumber,
        _website = website,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "licenceNumber" field.
  String? _licenceNumber;
  String get licenceNumber => _licenceNumber ?? '';
  set licenceNumber(String? val) => _licenceNumber = val;

  bool hasLicenceNumber() => _licenceNumber != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "phoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  set phoneNumber(String? val) => _phoneNumber = val;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "agentLicenseNumber" field.
  String? _agentLicenseNumber;
  String get agentLicenseNumber => _agentLicenseNumber ?? '';
  set agentLicenseNumber(String? val) => _agentLicenseNumber = val;

  bool hasAgentLicenseNumber() => _agentLicenseNumber != null;

  // "website" field.
  CredentialsDataStruct? _website;
  CredentialsDataStruct get website => _website ?? CredentialsDataStruct();
  set website(CredentialsDataStruct? val) => _website = val;

  void updateWebsite(Function(CredentialsDataStruct) updateFn) {
    updateFn(_website ??= CredentialsDataStruct());
  }

  bool hasWebsite() => _website != null;

  static BrokerageCredentialsDataStruct fromMap(Map<String, dynamic> data) =>
      BrokerageCredentialsDataStruct(
        name: data['name'] as String?,
        licenceNumber: data['licenceNumber'] as String?,
        address: data['address'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
        agentLicenseNumber: data['agentLicenseNumber'] as String?,
        website: data['website'] is CredentialsDataStruct
            ? data['website']
            : CredentialsDataStruct.maybeFromMap(data['website']),
      );

  static BrokerageCredentialsDataStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? BrokerageCredentialsDataStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'licenceNumber': _licenceNumber,
        'address': _address,
        'phoneNumber': _phoneNumber,
        'agentLicenseNumber': _agentLicenseNumber,
        'website': _website?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'licenceNumber': serializeParam(
          _licenceNumber,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'phoneNumber': serializeParam(
          _phoneNumber,
          ParamType.String,
        ),
        'agentLicenseNumber': serializeParam(
          _agentLicenseNumber,
          ParamType.String,
        ),
        'website': serializeParam(
          _website,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static BrokerageCredentialsDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BrokerageCredentialsDataStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        licenceNumber: deserializeParam(
          data['licenceNumber'],
          ParamType.String,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phoneNumber'],
          ParamType.String,
          false,
        ),
        agentLicenseNumber: deserializeParam(
          data['agentLicenseNumber'],
          ParamType.String,
          false,
        ),
        website: deserializeStructParam(
          data['website'],
          ParamType.DataStruct,
          false,
          structBuilder: CredentialsDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'BrokerageCredentialsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BrokerageCredentialsDataStruct &&
        name == other.name &&
        licenceNumber == other.licenceNumber &&
        address == other.address &&
        phoneNumber == other.phoneNumber &&
        agentLicenseNumber == other.agentLicenseNumber &&
        website == other.website;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [name, licenceNumber, address, phoneNumber, agentLicenseNumber, website]);
}

BrokerageCredentialsDataStruct createBrokerageCredentialsDataStruct({
  String? name,
  String? licenceNumber,
  String? address,
  String? phoneNumber,
  String? agentLicenseNumber,
  CredentialsDataStruct? website,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BrokerageCredentialsDataStruct(
      name: name,
      licenceNumber: licenceNumber,
      address: address,
      phoneNumber: phoneNumber,
      agentLicenseNumber: agentLicenseNumber,
      website: website ?? (clearUnsetFields ? CredentialsDataStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BrokerageCredentialsDataStruct? updateBrokerageCredentialsDataStruct(
  BrokerageCredentialsDataStruct? brokerageCredentialsData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    brokerageCredentialsData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBrokerageCredentialsDataStructData(
  Map<String, dynamic> firestoreData,
  BrokerageCredentialsDataStruct? brokerageCredentialsData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (brokerageCredentialsData == null) {
    return;
  }
  if (brokerageCredentialsData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      brokerageCredentialsData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final brokerageCredentialsDataData = getBrokerageCredentialsDataFirestoreData(
      brokerageCredentialsData, forFieldValue);
  final nestedData =
      brokerageCredentialsDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      brokerageCredentialsData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBrokerageCredentialsDataFirestoreData(
  BrokerageCredentialsDataStruct? brokerageCredentialsData, [
  bool forFieldValue = false,
]) {
  if (brokerageCredentialsData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(brokerageCredentialsData.toMap());

  // Handle nested data for "website" field.
  addCredentialsDataStructData(
    firestoreData,
    brokerageCredentialsData.hasWebsite()
        ? brokerageCredentialsData.website
        : null,
    'website',
    forFieldValue,
  );

  // Add any Firestore field values
  brokerageCredentialsData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBrokerageCredentialsDataListFirestoreData(
  List<BrokerageCredentialsDataStruct>? brokerageCredentialsDatas,
) =>
    brokerageCredentialsDatas
        ?.map((e) => getBrokerageCredentialsDataFirestoreData(e, true))
        .toList() ??
    [];
