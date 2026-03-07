// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActivityItemTypeStruct extends FFFirebaseStruct {
  ActivityItemTypeStruct({
    String? activityType,
    DateTime? timestamp,
    PropertyDataClassStruct? searchData,
    NewOfferStruct? offerData,
    String? memberName,
    String? memberPhotoUrl,
    String? info,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _activityType = activityType,
        _timestamp = timestamp,
        _searchData = searchData,
        _offerData = offerData,
        _memberName = memberName,
        _memberPhotoUrl = memberPhotoUrl,
        _info = info,
        super(firestoreUtilData);

  // "activityType" field.
  String? _activityType;
  String get activityType => _activityType ?? '';
  set activityType(String? val) => _activityType = val;

  bool hasActivityType() => _activityType != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  set timestamp(DateTime? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  // "searchData" field.
  PropertyDataClassStruct? _searchData;
  PropertyDataClassStruct get searchData =>
      _searchData ?? PropertyDataClassStruct();
  set searchData(PropertyDataClassStruct? val) => _searchData = val;

  void updateSearchData(Function(PropertyDataClassStruct) updateFn) {
    updateFn(_searchData ??= PropertyDataClassStruct());
  }

  bool hasSearchData() => _searchData != null;

  // "offerData" field.
  NewOfferStruct? _offerData;
  NewOfferStruct get offerData => _offerData ?? NewOfferStruct();
  set offerData(NewOfferStruct? val) => _offerData = val;

  void updateOfferData(Function(NewOfferStruct) updateFn) {
    updateFn(_offerData ??= NewOfferStruct());
  }

  bool hasOfferData() => _offerData != null;

  // "memberName" field.
  String? _memberName;
  String get memberName => _memberName ?? '';
  set memberName(String? val) => _memberName = val;

  bool hasMemberName() => _memberName != null;

  // "memberPhotoUrl" field.
  String? _memberPhotoUrl;
  String get memberPhotoUrl => _memberPhotoUrl ?? '';
  set memberPhotoUrl(String? val) => _memberPhotoUrl = val;

  bool hasMemberPhotoUrl() => _memberPhotoUrl != null;

  // "info" field.
  String? _info;
  String get info => _info ?? '';
  set info(String? val) => _info = val;

  bool hasInfo() => _info != null;

  static ActivityItemTypeStruct fromMap(Map<String, dynamic> data) =>
      ActivityItemTypeStruct(
        activityType: data['activityType'] as String?,
        timestamp: data['timestamp'] as DateTime?,
        searchData: data['searchData'] is PropertyDataClassStruct
            ? data['searchData']
            : PropertyDataClassStruct.maybeFromMap(data['searchData']),
        offerData: data['offerData'] is NewOfferStruct
            ? data['offerData']
            : NewOfferStruct.maybeFromMap(data['offerData']),
        memberName: data['memberName'] as String?,
        memberPhotoUrl: data['memberPhotoUrl'] as String?,
        info: data['info'] as String?,
      );

  static ActivityItemTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? ActivityItemTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'activityType': _activityType,
        'timestamp': _timestamp,
        'searchData': _searchData?.toMap(),
        'offerData': _offerData?.toMap(),
        'memberName': _memberName,
        'memberPhotoUrl': _memberPhotoUrl,
        'info': _info,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'activityType': serializeParam(
          _activityType,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.DateTime,
        ),
        'searchData': serializeParam(
          _searchData,
          ParamType.DataStruct,
        ),
        'offerData': serializeParam(
          _offerData,
          ParamType.DataStruct,
        ),
        'memberName': serializeParam(
          _memberName,
          ParamType.String,
        ),
        'memberPhotoUrl': serializeParam(
          _memberPhotoUrl,
          ParamType.String,
        ),
        'info': serializeParam(
          _info,
          ParamType.String,
        ),
      }.withoutNulls;

  static ActivityItemTypeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ActivityItemTypeStruct(
        activityType: deserializeParam(
          data['activityType'],
          ParamType.String,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.DateTime,
          false,
        ),
        searchData: deserializeStructParam(
          data['searchData'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyDataClassStruct.fromSerializableMap,
        ),
        offerData: deserializeStructParam(
          data['offerData'],
          ParamType.DataStruct,
          false,
          structBuilder: NewOfferStruct.fromSerializableMap,
        ),
        memberName: deserializeParam(
          data['memberName'],
          ParamType.String,
          false,
        ),
        memberPhotoUrl: deserializeParam(
          data['memberPhotoUrl'],
          ParamType.String,
          false,
        ),
        info: deserializeParam(
          data['info'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ActivityItemTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ActivityItemTypeStruct &&
        activityType == other.activityType &&
        timestamp == other.timestamp &&
        searchData == other.searchData &&
        offerData == other.offerData &&
        memberName == other.memberName &&
        memberPhotoUrl == other.memberPhotoUrl &&
        info == other.info;
  }

  @override
  int get hashCode => const ListEquality().hash([
        activityType,
        timestamp,
        searchData,
        offerData,
        memberName,
        memberPhotoUrl,
        info
      ]);
}

ActivityItemTypeStruct createActivityItemTypeStruct({
  String? activityType,
  DateTime? timestamp,
  PropertyDataClassStruct? searchData,
  NewOfferStruct? offerData,
  String? memberName,
  String? memberPhotoUrl,
  String? info,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ActivityItemTypeStruct(
      activityType: activityType,
      timestamp: timestamp,
      searchData:
          searchData ?? (clearUnsetFields ? PropertyDataClassStruct() : null),
      offerData: offerData ?? (clearUnsetFields ? NewOfferStruct() : null),
      memberName: memberName,
      memberPhotoUrl: memberPhotoUrl,
      info: info,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ActivityItemTypeStruct? updateActivityItemTypeStruct(
  ActivityItemTypeStruct? activityItemType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    activityItemType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addActivityItemTypeStructData(
  Map<String, dynamic> firestoreData,
  ActivityItemTypeStruct? activityItemType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (activityItemType == null) {
    return;
  }
  if (activityItemType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && activityItemType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final activityItemTypeData =
      getActivityItemTypeFirestoreData(activityItemType, forFieldValue);
  final nestedData =
      activityItemTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = activityItemType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getActivityItemTypeFirestoreData(
  ActivityItemTypeStruct? activityItemType, [
  bool forFieldValue = false,
]) {
  if (activityItemType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(activityItemType.toMap());

  // Handle nested data for "searchData" field.
  addPropertyDataClassStructData(
    firestoreData,
    activityItemType.hasSearchData() ? activityItemType.searchData : null,
    'searchData',
    forFieldValue,
  );

  // Handle nested data for "offerData" field.
  addNewOfferStructData(
    firestoreData,
    activityItemType.hasOfferData() ? activityItemType.offerData : null,
    'offerData',
    forFieldValue,
  );

  // Add any Firestore field values
  activityItemType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getActivityItemTypeListFirestoreData(
  List<ActivityItemTypeStruct>? activityItemTypes,
) =>
    activityItemTypes
        ?.map((e) => getActivityItemTypeFirestoreData(e, true))
        .toList() ??
    [];
