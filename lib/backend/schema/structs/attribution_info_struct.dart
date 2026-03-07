// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttributionInfoStruct extends FFFirebaseStruct {
  AttributionInfoStruct({
    String? buyerAgentName,
    String? mlsName,
    String? coAgentLicenseNumber,
    List<ListingOfficesStruct>? listingOffices,
    String? lastUpdated,
    String? buyerAgentMemberStateLicense,
    String? brokerName,
    String? listingAgreement,
    String? infoString10,
    String? trueStatus,
    String? infoString3,
    String? agentEmail,
    String? agentName,
    String? attributionTitle,
    String? mlsId,
    String? coAgentName,
    String? coAgentNumber,
    String? infoString5,
    List<ListingAgentsStruct>? listingAgents,
    String? agentPhoneNumber,
    String? agentLicenseNumber,
    String? providerLogo,
    String? infoString16,
    String? buyerBrokerageName,
    String? mlsDisclaimer,
    String? brokerPhoneNumber,
    String? lastChecked,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _buyerAgentName = buyerAgentName,
        _mlsName = mlsName,
        _coAgentLicenseNumber = coAgentLicenseNumber,
        _listingOffices = listingOffices,
        _lastUpdated = lastUpdated,
        _buyerAgentMemberStateLicense = buyerAgentMemberStateLicense,
        _brokerName = brokerName,
        _listingAgreement = listingAgreement,
        _infoString10 = infoString10,
        _trueStatus = trueStatus,
        _infoString3 = infoString3,
        _agentEmail = agentEmail,
        _agentName = agentName,
        _attributionTitle = attributionTitle,
        _mlsId = mlsId,
        _coAgentName = coAgentName,
        _coAgentNumber = coAgentNumber,
        _infoString5 = infoString5,
        _listingAgents = listingAgents,
        _agentPhoneNumber = agentPhoneNumber,
        _agentLicenseNumber = agentLicenseNumber,
        _providerLogo = providerLogo,
        _infoString16 = infoString16,
        _buyerBrokerageName = buyerBrokerageName,
        _mlsDisclaimer = mlsDisclaimer,
        _brokerPhoneNumber = brokerPhoneNumber,
        _lastChecked = lastChecked,
        super(firestoreUtilData);

  // "buyerAgentName" field.
  String? _buyerAgentName;
  String get buyerAgentName => _buyerAgentName ?? '';
  set buyerAgentName(String? val) => _buyerAgentName = val;

  bool hasBuyerAgentName() => _buyerAgentName != null;

  // "mlsName" field.
  String? _mlsName;
  String get mlsName => _mlsName ?? '';
  set mlsName(String? val) => _mlsName = val;

  bool hasMlsName() => _mlsName != null;

  // "coAgentLicenseNumber" field.
  String? _coAgentLicenseNumber;
  String get coAgentLicenseNumber => _coAgentLicenseNumber ?? '';
  set coAgentLicenseNumber(String? val) => _coAgentLicenseNumber = val;

  bool hasCoAgentLicenseNumber() => _coAgentLicenseNumber != null;

  // "listingOffices" field.
  List<ListingOfficesStruct>? _listingOffices;
  List<ListingOfficesStruct> get listingOffices => _listingOffices ?? const [];
  set listingOffices(List<ListingOfficesStruct>? val) => _listingOffices = val;

  void updateListingOffices(Function(List<ListingOfficesStruct>) updateFn) {
    updateFn(_listingOffices ??= []);
  }

  bool hasListingOffices() => _listingOffices != null;

  // "lastUpdated" field.
  String? _lastUpdated;
  String get lastUpdated => _lastUpdated ?? '';
  set lastUpdated(String? val) => _lastUpdated = val;

  bool hasLastUpdated() => _lastUpdated != null;

  // "buyerAgentMemberStateLicense" field.
  String? _buyerAgentMemberStateLicense;
  String get buyerAgentMemberStateLicense =>
      _buyerAgentMemberStateLicense ?? '';
  set buyerAgentMemberStateLicense(String? val) =>
      _buyerAgentMemberStateLicense = val;

  bool hasBuyerAgentMemberStateLicense() =>
      _buyerAgentMemberStateLicense != null;

  // "brokerName" field.
  String? _brokerName;
  String get brokerName => _brokerName ?? '';
  set brokerName(String? val) => _brokerName = val;

  bool hasBrokerName() => _brokerName != null;

  // "listingAgreement" field.
  String? _listingAgreement;
  String get listingAgreement => _listingAgreement ?? '';
  set listingAgreement(String? val) => _listingAgreement = val;

  bool hasListingAgreement() => _listingAgreement != null;

  // "infoString10" field.
  String? _infoString10;
  String get infoString10 => _infoString10 ?? '';
  set infoString10(String? val) => _infoString10 = val;

  bool hasInfoString10() => _infoString10 != null;

  // "trueStatus" field.
  String? _trueStatus;
  String get trueStatus => _trueStatus ?? '';
  set trueStatus(String? val) => _trueStatus = val;

  bool hasTrueStatus() => _trueStatus != null;

  // "infoString3" field.
  String? _infoString3;
  String get infoString3 => _infoString3 ?? '';
  set infoString3(String? val) => _infoString3 = val;

  bool hasInfoString3() => _infoString3 != null;

  // "agentEmail" field.
  String? _agentEmail;
  String get agentEmail => _agentEmail ?? '';
  set agentEmail(String? val) => _agentEmail = val;

  bool hasAgentEmail() => _agentEmail != null;

  // "agentName" field.
  String? _agentName;
  String get agentName => _agentName ?? '';
  set agentName(String? val) => _agentName = val;

  bool hasAgentName() => _agentName != null;

  // "attributionTitle" field.
  String? _attributionTitle;
  String get attributionTitle => _attributionTitle ?? '';
  set attributionTitle(String? val) => _attributionTitle = val;

  bool hasAttributionTitle() => _attributionTitle != null;

  // "mlsId" field.
  String? _mlsId;
  String get mlsId => _mlsId ?? '';
  set mlsId(String? val) => _mlsId = val;

  bool hasMlsId() => _mlsId != null;

  // "coAgentName" field.
  String? _coAgentName;
  String get coAgentName => _coAgentName ?? '';
  set coAgentName(String? val) => _coAgentName = val;

  bool hasCoAgentName() => _coAgentName != null;

  // "coAgentNumber" field.
  String? _coAgentNumber;
  String get coAgentNumber => _coAgentNumber ?? '';
  set coAgentNumber(String? val) => _coAgentNumber = val;

  bool hasCoAgentNumber() => _coAgentNumber != null;

  // "infoString5" field.
  String? _infoString5;
  String get infoString5 => _infoString5 ?? '';
  set infoString5(String? val) => _infoString5 = val;

  bool hasInfoString5() => _infoString5 != null;

  // "listingAgents" field.
  List<ListingAgentsStruct>? _listingAgents;
  List<ListingAgentsStruct> get listingAgents => _listingAgents ?? const [];
  set listingAgents(List<ListingAgentsStruct>? val) => _listingAgents = val;

  void updateListingAgents(Function(List<ListingAgentsStruct>) updateFn) {
    updateFn(_listingAgents ??= []);
  }

  bool hasListingAgents() => _listingAgents != null;

  // "agentPhoneNumber" field.
  String? _agentPhoneNumber;
  String get agentPhoneNumber => _agentPhoneNumber ?? '';
  set agentPhoneNumber(String? val) => _agentPhoneNumber = val;

  bool hasAgentPhoneNumber() => _agentPhoneNumber != null;

  // "agentLicenseNumber" field.
  String? _agentLicenseNumber;
  String get agentLicenseNumber => _agentLicenseNumber ?? '';
  set agentLicenseNumber(String? val) => _agentLicenseNumber = val;

  bool hasAgentLicenseNumber() => _agentLicenseNumber != null;

  // "providerLogo" field.
  String? _providerLogo;
  String get providerLogo => _providerLogo ?? '';
  set providerLogo(String? val) => _providerLogo = val;

  bool hasProviderLogo() => _providerLogo != null;

  // "infoString16" field.
  String? _infoString16;
  String get infoString16 => _infoString16 ?? '';
  set infoString16(String? val) => _infoString16 = val;

  bool hasInfoString16() => _infoString16 != null;

  // "buyerBrokerageName" field.
  String? _buyerBrokerageName;
  String get buyerBrokerageName => _buyerBrokerageName ?? '';
  set buyerBrokerageName(String? val) => _buyerBrokerageName = val;

  bool hasBuyerBrokerageName() => _buyerBrokerageName != null;

  // "mlsDisclaimer" field.
  String? _mlsDisclaimer;
  String get mlsDisclaimer => _mlsDisclaimer ?? '';
  set mlsDisclaimer(String? val) => _mlsDisclaimer = val;

  bool hasMlsDisclaimer() => _mlsDisclaimer != null;

  // "brokerPhoneNumber" field.
  String? _brokerPhoneNumber;
  String get brokerPhoneNumber => _brokerPhoneNumber ?? '';
  set brokerPhoneNumber(String? val) => _brokerPhoneNumber = val;

  bool hasBrokerPhoneNumber() => _brokerPhoneNumber != null;

  // "lastChecked" field.
  String? _lastChecked;
  String get lastChecked => _lastChecked ?? '';
  set lastChecked(String? val) => _lastChecked = val;

  bool hasLastChecked() => _lastChecked != null;

  static AttributionInfoStruct fromMap(Map<String, dynamic> data) =>
      AttributionInfoStruct(
        buyerAgentName: data['buyerAgentName'] as String?,
        mlsName: data['mlsName'] as String?,
        coAgentLicenseNumber: data['coAgentLicenseNumber'] as String?,
        listingOffices: getStructList(
          data['listingOffices'],
          ListingOfficesStruct.fromMap,
        ),
        lastUpdated: data['lastUpdated'] as String?,
        buyerAgentMemberStateLicense:
            data['buyerAgentMemberStateLicense'] as String?,
        brokerName: data['brokerName'] as String?,
        listingAgreement: data['listingAgreement'] as String?,
        infoString10: data['infoString10'] as String?,
        trueStatus: data['trueStatus'] as String?,
        infoString3: data['infoString3'] as String?,
        agentEmail: data['agentEmail'] as String?,
        agentName: data['agentName'] as String?,
        attributionTitle: data['attributionTitle'] as String?,
        mlsId: data['mlsId'] as String?,
        coAgentName: data['coAgentName'] as String?,
        coAgentNumber: data['coAgentNumber'] as String?,
        infoString5: data['infoString5'] as String?,
        listingAgents: getStructList(
          data['listingAgents'],
          ListingAgentsStruct.fromMap,
        ),
        agentPhoneNumber: data['agentPhoneNumber'] as String?,
        agentLicenseNumber: data['agentLicenseNumber'] as String?,
        providerLogo: data['providerLogo'] as String?,
        infoString16: data['infoString16'] as String?,
        buyerBrokerageName: data['buyerBrokerageName'] as String?,
        mlsDisclaimer: data['mlsDisclaimer'] as String?,
        brokerPhoneNumber: data['brokerPhoneNumber'] as String?,
        lastChecked: data['lastChecked'] as String?,
      );

  static AttributionInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? AttributionInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'buyerAgentName': _buyerAgentName,
        'mlsName': _mlsName,
        'coAgentLicenseNumber': _coAgentLicenseNumber,
        'listingOffices': _listingOffices?.map((e) => e.toMap()).toList(),
        'lastUpdated': _lastUpdated,
        'buyerAgentMemberStateLicense': _buyerAgentMemberStateLicense,
        'brokerName': _brokerName,
        'listingAgreement': _listingAgreement,
        'infoString10': _infoString10,
        'trueStatus': _trueStatus,
        'infoString3': _infoString3,
        'agentEmail': _agentEmail,
        'agentName': _agentName,
        'attributionTitle': _attributionTitle,
        'mlsId': _mlsId,
        'coAgentName': _coAgentName,
        'coAgentNumber': _coAgentNumber,
        'infoString5': _infoString5,
        'listingAgents': _listingAgents?.map((e) => e.toMap()).toList(),
        'agentPhoneNumber': _agentPhoneNumber,
        'agentLicenseNumber': _agentLicenseNumber,
        'providerLogo': _providerLogo,
        'infoString16': _infoString16,
        'buyerBrokerageName': _buyerBrokerageName,
        'mlsDisclaimer': _mlsDisclaimer,
        'brokerPhoneNumber': _brokerPhoneNumber,
        'lastChecked': _lastChecked,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'buyerAgentName': serializeParam(
          _buyerAgentName,
          ParamType.String,
        ),
        'mlsName': serializeParam(
          _mlsName,
          ParamType.String,
        ),
        'coAgentLicenseNumber': serializeParam(
          _coAgentLicenseNumber,
          ParamType.String,
        ),
        'listingOffices': serializeParam(
          _listingOffices,
          ParamType.DataStruct,
          isList: true,
        ),
        'lastUpdated': serializeParam(
          _lastUpdated,
          ParamType.String,
        ),
        'buyerAgentMemberStateLicense': serializeParam(
          _buyerAgentMemberStateLicense,
          ParamType.String,
        ),
        'brokerName': serializeParam(
          _brokerName,
          ParamType.String,
        ),
        'listingAgreement': serializeParam(
          _listingAgreement,
          ParamType.String,
        ),
        'infoString10': serializeParam(
          _infoString10,
          ParamType.String,
        ),
        'trueStatus': serializeParam(
          _trueStatus,
          ParamType.String,
        ),
        'infoString3': serializeParam(
          _infoString3,
          ParamType.String,
        ),
        'agentEmail': serializeParam(
          _agentEmail,
          ParamType.String,
        ),
        'agentName': serializeParam(
          _agentName,
          ParamType.String,
        ),
        'attributionTitle': serializeParam(
          _attributionTitle,
          ParamType.String,
        ),
        'mlsId': serializeParam(
          _mlsId,
          ParamType.String,
        ),
        'coAgentName': serializeParam(
          _coAgentName,
          ParamType.String,
        ),
        'coAgentNumber': serializeParam(
          _coAgentNumber,
          ParamType.String,
        ),
        'infoString5': serializeParam(
          _infoString5,
          ParamType.String,
        ),
        'listingAgents': serializeParam(
          _listingAgents,
          ParamType.DataStruct,
          isList: true,
        ),
        'agentPhoneNumber': serializeParam(
          _agentPhoneNumber,
          ParamType.String,
        ),
        'agentLicenseNumber': serializeParam(
          _agentLicenseNumber,
          ParamType.String,
        ),
        'providerLogo': serializeParam(
          _providerLogo,
          ParamType.String,
        ),
        'infoString16': serializeParam(
          _infoString16,
          ParamType.String,
        ),
        'buyerBrokerageName': serializeParam(
          _buyerBrokerageName,
          ParamType.String,
        ),
        'mlsDisclaimer': serializeParam(
          _mlsDisclaimer,
          ParamType.String,
        ),
        'brokerPhoneNumber': serializeParam(
          _brokerPhoneNumber,
          ParamType.String,
        ),
        'lastChecked': serializeParam(
          _lastChecked,
          ParamType.String,
        ),
      }.withoutNulls;

  static AttributionInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      AttributionInfoStruct(
        buyerAgentName: deserializeParam(
          data['buyerAgentName'],
          ParamType.String,
          false,
        ),
        mlsName: deserializeParam(
          data['mlsName'],
          ParamType.String,
          false,
        ),
        coAgentLicenseNumber: deserializeParam(
          data['coAgentLicenseNumber'],
          ParamType.String,
          false,
        ),
        listingOffices: deserializeStructParam<ListingOfficesStruct>(
          data['listingOffices'],
          ParamType.DataStruct,
          true,
          structBuilder: ListingOfficesStruct.fromSerializableMap,
        ),
        lastUpdated: deserializeParam(
          data['lastUpdated'],
          ParamType.String,
          false,
        ),
        buyerAgentMemberStateLicense: deserializeParam(
          data['buyerAgentMemberStateLicense'],
          ParamType.String,
          false,
        ),
        brokerName: deserializeParam(
          data['brokerName'],
          ParamType.String,
          false,
        ),
        listingAgreement: deserializeParam(
          data['listingAgreement'],
          ParamType.String,
          false,
        ),
        infoString10: deserializeParam(
          data['infoString10'],
          ParamType.String,
          false,
        ),
        trueStatus: deserializeParam(
          data['trueStatus'],
          ParamType.String,
          false,
        ),
        infoString3: deserializeParam(
          data['infoString3'],
          ParamType.String,
          false,
        ),
        agentEmail: deserializeParam(
          data['agentEmail'],
          ParamType.String,
          false,
        ),
        agentName: deserializeParam(
          data['agentName'],
          ParamType.String,
          false,
        ),
        attributionTitle: deserializeParam(
          data['attributionTitle'],
          ParamType.String,
          false,
        ),
        mlsId: deserializeParam(
          data['mlsId'],
          ParamType.String,
          false,
        ),
        coAgentName: deserializeParam(
          data['coAgentName'],
          ParamType.String,
          false,
        ),
        coAgentNumber: deserializeParam(
          data['coAgentNumber'],
          ParamType.String,
          false,
        ),
        infoString5: deserializeParam(
          data['infoString5'],
          ParamType.String,
          false,
        ),
        listingAgents: deserializeStructParam<ListingAgentsStruct>(
          data['listingAgents'],
          ParamType.DataStruct,
          true,
          structBuilder: ListingAgentsStruct.fromSerializableMap,
        ),
        agentPhoneNumber: deserializeParam(
          data['agentPhoneNumber'],
          ParamType.String,
          false,
        ),
        agentLicenseNumber: deserializeParam(
          data['agentLicenseNumber'],
          ParamType.String,
          false,
        ),
        providerLogo: deserializeParam(
          data['providerLogo'],
          ParamType.String,
          false,
        ),
        infoString16: deserializeParam(
          data['infoString16'],
          ParamType.String,
          false,
        ),
        buyerBrokerageName: deserializeParam(
          data['buyerBrokerageName'],
          ParamType.String,
          false,
        ),
        mlsDisclaimer: deserializeParam(
          data['mlsDisclaimer'],
          ParamType.String,
          false,
        ),
        brokerPhoneNumber: deserializeParam(
          data['brokerPhoneNumber'],
          ParamType.String,
          false,
        ),
        lastChecked: deserializeParam(
          data['lastChecked'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AttributionInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AttributionInfoStruct &&
        buyerAgentName == other.buyerAgentName &&
        mlsName == other.mlsName &&
        coAgentLicenseNumber == other.coAgentLicenseNumber &&
        listEquality.equals(listingOffices, other.listingOffices) &&
        lastUpdated == other.lastUpdated &&
        buyerAgentMemberStateLicense == other.buyerAgentMemberStateLicense &&
        brokerName == other.brokerName &&
        listingAgreement == other.listingAgreement &&
        infoString10 == other.infoString10 &&
        trueStatus == other.trueStatus &&
        infoString3 == other.infoString3 &&
        agentEmail == other.agentEmail &&
        agentName == other.agentName &&
        attributionTitle == other.attributionTitle &&
        mlsId == other.mlsId &&
        coAgentName == other.coAgentName &&
        coAgentNumber == other.coAgentNumber &&
        infoString5 == other.infoString5 &&
        listEquality.equals(listingAgents, other.listingAgents) &&
        agentPhoneNumber == other.agentPhoneNumber &&
        agentLicenseNumber == other.agentLicenseNumber &&
        providerLogo == other.providerLogo &&
        infoString16 == other.infoString16 &&
        buyerBrokerageName == other.buyerBrokerageName &&
        mlsDisclaimer == other.mlsDisclaimer &&
        brokerPhoneNumber == other.brokerPhoneNumber &&
        lastChecked == other.lastChecked;
  }

  @override
  int get hashCode => const ListEquality().hash([
        buyerAgentName,
        mlsName,
        coAgentLicenseNumber,
        listingOffices,
        lastUpdated,
        buyerAgentMemberStateLicense,
        brokerName,
        listingAgreement,
        infoString10,
        trueStatus,
        infoString3,
        agentEmail,
        agentName,
        attributionTitle,
        mlsId,
        coAgentName,
        coAgentNumber,
        infoString5,
        listingAgents,
        agentPhoneNumber,
        agentLicenseNumber,
        providerLogo,
        infoString16,
        buyerBrokerageName,
        mlsDisclaimer,
        brokerPhoneNumber,
        lastChecked
      ]);
}

AttributionInfoStruct createAttributionInfoStruct({
  String? buyerAgentName,
  String? mlsName,
  String? coAgentLicenseNumber,
  String? lastUpdated,
  String? buyerAgentMemberStateLicense,
  String? brokerName,
  String? listingAgreement,
  String? infoString10,
  String? trueStatus,
  String? infoString3,
  String? agentEmail,
  String? agentName,
  String? attributionTitle,
  String? mlsId,
  String? coAgentName,
  String? coAgentNumber,
  String? infoString5,
  String? agentPhoneNumber,
  String? agentLicenseNumber,
  String? providerLogo,
  String? infoString16,
  String? buyerBrokerageName,
  String? mlsDisclaimer,
  String? brokerPhoneNumber,
  String? lastChecked,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AttributionInfoStruct(
      buyerAgentName: buyerAgentName,
      mlsName: mlsName,
      coAgentLicenseNumber: coAgentLicenseNumber,
      lastUpdated: lastUpdated,
      buyerAgentMemberStateLicense: buyerAgentMemberStateLicense,
      brokerName: brokerName,
      listingAgreement: listingAgreement,
      infoString10: infoString10,
      trueStatus: trueStatus,
      infoString3: infoString3,
      agentEmail: agentEmail,
      agentName: agentName,
      attributionTitle: attributionTitle,
      mlsId: mlsId,
      coAgentName: coAgentName,
      coAgentNumber: coAgentNumber,
      infoString5: infoString5,
      agentPhoneNumber: agentPhoneNumber,
      agentLicenseNumber: agentLicenseNumber,
      providerLogo: providerLogo,
      infoString16: infoString16,
      buyerBrokerageName: buyerBrokerageName,
      mlsDisclaimer: mlsDisclaimer,
      brokerPhoneNumber: brokerPhoneNumber,
      lastChecked: lastChecked,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AttributionInfoStruct? updateAttributionInfoStruct(
  AttributionInfoStruct? attributionInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    attributionInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAttributionInfoStructData(
  Map<String, dynamic> firestoreData,
  AttributionInfoStruct? attributionInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (attributionInfo == null) {
    return;
  }
  if (attributionInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && attributionInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final attributionInfoData =
      getAttributionInfoFirestoreData(attributionInfo, forFieldValue);
  final nestedData =
      attributionInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = attributionInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAttributionInfoFirestoreData(
  AttributionInfoStruct? attributionInfo, [
  bool forFieldValue = false,
]) {
  if (attributionInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(attributionInfo.toMap());

  // Add any Firestore field values
  attributionInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAttributionInfoListFirestoreData(
  List<AttributionInfoStruct>? attributionInfos,
) =>
    attributionInfos
        ?.map((e) => getAttributionInfoFirestoreData(e, true))
        .toList() ??
    [];
