// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ListingAgentsStruct extends FFFirebaseStruct {
  ListingAgentsStruct({
    String? memberStateLicense,
    String? memberFullName,
    String? associatedAgentType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _memberStateLicense = memberStateLicense,
        _memberFullName = memberFullName,
        _associatedAgentType = associatedAgentType,
        super(firestoreUtilData);

  // "memberStateLicense" field.
  String? _memberStateLicense;
  String get memberStateLicense => _memberStateLicense ?? '';
  set memberStateLicense(String? val) => _memberStateLicense = val;

  bool hasMemberStateLicense() => _memberStateLicense != null;

  // "memberFullName" field.
  String? _memberFullName;
  String get memberFullName => _memberFullName ?? '';
  set memberFullName(String? val) => _memberFullName = val;

  bool hasMemberFullName() => _memberFullName != null;

  // "associatedAgentType" field.
  String? _associatedAgentType;
  String get associatedAgentType => _associatedAgentType ?? '';
  set associatedAgentType(String? val) => _associatedAgentType = val;

  bool hasAssociatedAgentType() => _associatedAgentType != null;

  static ListingAgentsStruct fromMap(Map<String, dynamic> data) =>
      ListingAgentsStruct(
        memberStateLicense: data['memberStateLicense'] as String?,
        memberFullName: data['memberFullName'] as String?,
        associatedAgentType: data['associatedAgentType'] as String?,
      );

  static ListingAgentsStruct? maybeFromMap(dynamic data) => data is Map
      ? ListingAgentsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'memberStateLicense': _memberStateLicense,
        'memberFullName': _memberFullName,
        'associatedAgentType': _associatedAgentType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'memberStateLicense': serializeParam(
          _memberStateLicense,
          ParamType.String,
        ),
        'memberFullName': serializeParam(
          _memberFullName,
          ParamType.String,
        ),
        'associatedAgentType': serializeParam(
          _associatedAgentType,
          ParamType.String,
        ),
      }.withoutNulls;

  static ListingAgentsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListingAgentsStruct(
        memberStateLicense: deserializeParam(
          data['memberStateLicense'],
          ParamType.String,
          false,
        ),
        memberFullName: deserializeParam(
          data['memberFullName'],
          ParamType.String,
          false,
        ),
        associatedAgentType: deserializeParam(
          data['associatedAgentType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ListingAgentsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListingAgentsStruct &&
        memberStateLicense == other.memberStateLicense &&
        memberFullName == other.memberFullName &&
        associatedAgentType == other.associatedAgentType;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([memberStateLicense, memberFullName, associatedAgentType]);
}

ListingAgentsStruct createListingAgentsStruct({
  String? memberStateLicense,
  String? memberFullName,
  String? associatedAgentType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListingAgentsStruct(
      memberStateLicense: memberStateLicense,
      memberFullName: memberFullName,
      associatedAgentType: associatedAgentType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListingAgentsStruct? updateListingAgentsStruct(
  ListingAgentsStruct? listingAgents, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listingAgents
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListingAgentsStructData(
  Map<String, dynamic> firestoreData,
  ListingAgentsStruct? listingAgents,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listingAgents == null) {
    return;
  }
  if (listingAgents.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listingAgents.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listingAgentsData =
      getListingAgentsFirestoreData(listingAgents, forFieldValue);
  final nestedData =
      listingAgentsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listingAgents.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListingAgentsFirestoreData(
  ListingAgentsStruct? listingAgents, [
  bool forFieldValue = false,
]) {
  if (listingAgents == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listingAgents.toMap());

  // Add any Firestore field values
  listingAgents.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListingAgentsListFirestoreData(
  List<ListingAgentsStruct>? listingAgentss,
) =>
    listingAgentss
        ?.map((e) => getListingAgentsFirestoreData(e, true))
        .toList() ??
    [];
