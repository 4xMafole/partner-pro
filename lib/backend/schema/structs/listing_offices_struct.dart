// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ListingOfficesStruct extends FFFirebaseStruct {
  ListingOfficesStruct({
    String? associatedOfficeType,
    String? officeName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _associatedOfficeType = associatedOfficeType,
        _officeName = officeName,
        super(firestoreUtilData);

  // "associatedOfficeType" field.
  String? _associatedOfficeType;
  String get associatedOfficeType => _associatedOfficeType ?? '';
  set associatedOfficeType(String? val) => _associatedOfficeType = val;

  bool hasAssociatedOfficeType() => _associatedOfficeType != null;

  // "officeName" field.
  String? _officeName;
  String get officeName => _officeName ?? '';
  set officeName(String? val) => _officeName = val;

  bool hasOfficeName() => _officeName != null;

  static ListingOfficesStruct fromMap(Map<String, dynamic> data) =>
      ListingOfficesStruct(
        associatedOfficeType: data['associatedOfficeType'] as String?,
        officeName: data['officeName'] as String?,
      );

  static ListingOfficesStruct? maybeFromMap(dynamic data) => data is Map
      ? ListingOfficesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'associatedOfficeType': _associatedOfficeType,
        'officeName': _officeName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'associatedOfficeType': serializeParam(
          _associatedOfficeType,
          ParamType.String,
        ),
        'officeName': serializeParam(
          _officeName,
          ParamType.String,
        ),
      }.withoutNulls;

  static ListingOfficesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListingOfficesStruct(
        associatedOfficeType: deserializeParam(
          data['associatedOfficeType'],
          ParamType.String,
          false,
        ),
        officeName: deserializeParam(
          data['officeName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ListingOfficesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListingOfficesStruct &&
        associatedOfficeType == other.associatedOfficeType &&
        officeName == other.officeName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([associatedOfficeType, officeName]);
}

ListingOfficesStruct createListingOfficesStruct({
  String? associatedOfficeType,
  String? officeName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListingOfficesStruct(
      associatedOfficeType: associatedOfficeType,
      officeName: officeName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListingOfficesStruct? updateListingOfficesStruct(
  ListingOfficesStruct? listingOffices, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listingOffices
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListingOfficesStructData(
  Map<String, dynamic> firestoreData,
  ListingOfficesStruct? listingOffices,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listingOffices == null) {
    return;
  }
  if (listingOffices.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listingOffices.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listingOfficesData =
      getListingOfficesFirestoreData(listingOffices, forFieldValue);
  final nestedData =
      listingOfficesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listingOffices.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListingOfficesFirestoreData(
  ListingOfficesStruct? listingOffices, [
  bool forFieldValue = false,
]) {
  if (listingOffices == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listingOffices.toMap());

  // Add any Firestore field values
  listingOffices.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListingOfficesListFirestoreData(
  List<ListingOfficesStruct>? listingOfficess,
) =>
    listingOfficess
        ?.map((e) => getListingOfficesFirestoreData(e, true))
        .toList() ??
    [];
