// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ListingSubTypeStruct extends FFFirebaseStruct {
  ListingSubTypeStruct({
    bool? isFSBA,
    bool? isComingSoon,
    bool? isNewHome,
    bool? isPending,
    bool? isForAuction,
    bool? isForeclosure,
    bool? isBankOwned,
    bool? isOpenHouse,
    bool? isFSBO,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _isFSBA = isFSBA,
        _isComingSoon = isComingSoon,
        _isNewHome = isNewHome,
        _isPending = isPending,
        _isForAuction = isForAuction,
        _isForeclosure = isForeclosure,
        _isBankOwned = isBankOwned,
        _isOpenHouse = isOpenHouse,
        _isFSBO = isFSBO,
        super(firestoreUtilData);

  // "is_FSBA" field.
  bool? _isFSBA;
  bool get isFSBA => _isFSBA ?? false;
  set isFSBA(bool? val) => _isFSBA = val;

  bool hasIsFSBA() => _isFSBA != null;

  // "is_comingSoon" field.
  bool? _isComingSoon;
  bool get isComingSoon => _isComingSoon ?? false;
  set isComingSoon(bool? val) => _isComingSoon = val;

  bool hasIsComingSoon() => _isComingSoon != null;

  // "is_newHome" field.
  bool? _isNewHome;
  bool get isNewHome => _isNewHome ?? false;
  set isNewHome(bool? val) => _isNewHome = val;

  bool hasIsNewHome() => _isNewHome != null;

  // "is_pending" field.
  bool? _isPending;
  bool get isPending => _isPending ?? false;
  set isPending(bool? val) => _isPending = val;

  bool hasIsPending() => _isPending != null;

  // "is_forAuction" field.
  bool? _isForAuction;
  bool get isForAuction => _isForAuction ?? false;
  set isForAuction(bool? val) => _isForAuction = val;

  bool hasIsForAuction() => _isForAuction != null;

  // "is_foreclosure" field.
  bool? _isForeclosure;
  bool get isForeclosure => _isForeclosure ?? false;
  set isForeclosure(bool? val) => _isForeclosure = val;

  bool hasIsForeclosure() => _isForeclosure != null;

  // "is_bankOwned" field.
  bool? _isBankOwned;
  bool get isBankOwned => _isBankOwned ?? false;
  set isBankOwned(bool? val) => _isBankOwned = val;

  bool hasIsBankOwned() => _isBankOwned != null;

  // "is_openHouse" field.
  bool? _isOpenHouse;
  bool get isOpenHouse => _isOpenHouse ?? false;
  set isOpenHouse(bool? val) => _isOpenHouse = val;

  bool hasIsOpenHouse() => _isOpenHouse != null;

  // "is_FSBO" field.
  bool? _isFSBO;
  bool get isFSBO => _isFSBO ?? false;
  set isFSBO(bool? val) => _isFSBO = val;

  bool hasIsFSBO() => _isFSBO != null;

  static ListingSubTypeStruct fromMap(Map<String, dynamic> data) =>
      ListingSubTypeStruct(
        isFSBA: data['is_FSBA'] as bool?,
        isComingSoon: data['is_comingSoon'] as bool?,
        isNewHome: data['is_newHome'] as bool?,
        isPending: data['is_pending'] as bool?,
        isForAuction: data['is_forAuction'] as bool?,
        isForeclosure: data['is_foreclosure'] as bool?,
        isBankOwned: data['is_bankOwned'] as bool?,
        isOpenHouse: data['is_openHouse'] as bool?,
        isFSBO: data['is_FSBO'] as bool?,
      );

  static ListingSubTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? ListingSubTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'is_FSBA': _isFSBA,
        'is_comingSoon': _isComingSoon,
        'is_newHome': _isNewHome,
        'is_pending': _isPending,
        'is_forAuction': _isForAuction,
        'is_foreclosure': _isForeclosure,
        'is_bankOwned': _isBankOwned,
        'is_openHouse': _isOpenHouse,
        'is_FSBO': _isFSBO,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'is_FSBA': serializeParam(
          _isFSBA,
          ParamType.bool,
        ),
        'is_comingSoon': serializeParam(
          _isComingSoon,
          ParamType.bool,
        ),
        'is_newHome': serializeParam(
          _isNewHome,
          ParamType.bool,
        ),
        'is_pending': serializeParam(
          _isPending,
          ParamType.bool,
        ),
        'is_forAuction': serializeParam(
          _isForAuction,
          ParamType.bool,
        ),
        'is_foreclosure': serializeParam(
          _isForeclosure,
          ParamType.bool,
        ),
        'is_bankOwned': serializeParam(
          _isBankOwned,
          ParamType.bool,
        ),
        'is_openHouse': serializeParam(
          _isOpenHouse,
          ParamType.bool,
        ),
        'is_FSBO': serializeParam(
          _isFSBO,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ListingSubTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListingSubTypeStruct(
        isFSBA: deserializeParam(
          data['is_FSBA'],
          ParamType.bool,
          false,
        ),
        isComingSoon: deserializeParam(
          data['is_comingSoon'],
          ParamType.bool,
          false,
        ),
        isNewHome: deserializeParam(
          data['is_newHome'],
          ParamType.bool,
          false,
        ),
        isPending: deserializeParam(
          data['is_pending'],
          ParamType.bool,
          false,
        ),
        isForAuction: deserializeParam(
          data['is_forAuction'],
          ParamType.bool,
          false,
        ),
        isForeclosure: deserializeParam(
          data['is_foreclosure'],
          ParamType.bool,
          false,
        ),
        isBankOwned: deserializeParam(
          data['is_bankOwned'],
          ParamType.bool,
          false,
        ),
        isOpenHouse: deserializeParam(
          data['is_openHouse'],
          ParamType.bool,
          false,
        ),
        isFSBO: deserializeParam(
          data['is_FSBO'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ListingSubTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListingSubTypeStruct &&
        isFSBA == other.isFSBA &&
        isComingSoon == other.isComingSoon &&
        isNewHome == other.isNewHome &&
        isPending == other.isPending &&
        isForAuction == other.isForAuction &&
        isForeclosure == other.isForeclosure &&
        isBankOwned == other.isBankOwned &&
        isOpenHouse == other.isOpenHouse &&
        isFSBO == other.isFSBO;
  }

  @override
  int get hashCode => const ListEquality().hash([
        isFSBA,
        isComingSoon,
        isNewHome,
        isPending,
        isForAuction,
        isForeclosure,
        isBankOwned,
        isOpenHouse,
        isFSBO
      ]);
}

ListingSubTypeStruct createListingSubTypeStruct({
  bool? isFSBA,
  bool? isComingSoon,
  bool? isNewHome,
  bool? isPending,
  bool? isForAuction,
  bool? isForeclosure,
  bool? isBankOwned,
  bool? isOpenHouse,
  bool? isFSBO,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListingSubTypeStruct(
      isFSBA: isFSBA,
      isComingSoon: isComingSoon,
      isNewHome: isNewHome,
      isPending: isPending,
      isForAuction: isForAuction,
      isForeclosure: isForeclosure,
      isBankOwned: isBankOwned,
      isOpenHouse: isOpenHouse,
      isFSBO: isFSBO,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListingSubTypeStruct? updateListingSubTypeStruct(
  ListingSubTypeStruct? listingSubType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listingSubType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListingSubTypeStructData(
  Map<String, dynamic> firestoreData,
  ListingSubTypeStruct? listingSubType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listingSubType == null) {
    return;
  }
  if (listingSubType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listingSubType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listingSubTypeData =
      getListingSubTypeFirestoreData(listingSubType, forFieldValue);
  final nestedData =
      listingSubTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listingSubType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListingSubTypeFirestoreData(
  ListingSubTypeStruct? listingSubType, [
  bool forFieldValue = false,
]) {
  if (listingSubType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listingSubType.toMap());

  // Add any Firestore field values
  listingSubType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListingSubTypeListFirestoreData(
  List<ListingSubTypeStruct>? listingSubTypes,
) =>
    listingSubTypes
        ?.map((e) => getListingSubTypeFirestoreData(e, true))
        .toList() ??
    [];
