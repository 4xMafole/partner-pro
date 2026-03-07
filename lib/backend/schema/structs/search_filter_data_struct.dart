// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SearchFilterDataStruct extends FFFirebaseStruct {
  SearchFilterDataStruct({
    String? minPrice,
    String? maxPrice,
    String? minBeds,
    String? maxBeds,
    String? minBaths,
    String? maxBaths,
    String? minSqft,
    String? maxSqft,
    String? minYearBuilt,
    String? maxYearBuilt,
    List<String>? homeTypes,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _minPrice = minPrice,
        _maxPrice = maxPrice,
        _minBeds = minBeds,
        _maxBeds = maxBeds,
        _minBaths = minBaths,
        _maxBaths = maxBaths,
        _minSqft = minSqft,
        _maxSqft = maxSqft,
        _minYearBuilt = minYearBuilt,
        _maxYearBuilt = maxYearBuilt,
        _homeTypes = homeTypes,
        super(firestoreUtilData);

  // "minPrice" field.
  String? _minPrice;
  String get minPrice => _minPrice ?? '';
  set minPrice(String? val) => _minPrice = val;

  bool hasMinPrice() => _minPrice != null;

  // "maxPrice" field.
  String? _maxPrice;
  String get maxPrice => _maxPrice ?? '';
  set maxPrice(String? val) => _maxPrice = val;

  bool hasMaxPrice() => _maxPrice != null;

  // "minBeds" field.
  String? _minBeds;
  String get minBeds => _minBeds ?? '';
  set minBeds(String? val) => _minBeds = val;

  bool hasMinBeds() => _minBeds != null;

  // "maxBeds" field.
  String? _maxBeds;
  String get maxBeds => _maxBeds ?? '';
  set maxBeds(String? val) => _maxBeds = val;

  bool hasMaxBeds() => _maxBeds != null;

  // "minBaths" field.
  String? _minBaths;
  String get minBaths => _minBaths ?? '';
  set minBaths(String? val) => _minBaths = val;

  bool hasMinBaths() => _minBaths != null;

  // "maxBaths" field.
  String? _maxBaths;
  String get maxBaths => _maxBaths ?? '';
  set maxBaths(String? val) => _maxBaths = val;

  bool hasMaxBaths() => _maxBaths != null;

  // "minSqft" field.
  String? _minSqft;
  String get minSqft => _minSqft ?? '';
  set minSqft(String? val) => _minSqft = val;

  bool hasMinSqft() => _minSqft != null;

  // "maxSqft" field.
  String? _maxSqft;
  String get maxSqft => _maxSqft ?? '';
  set maxSqft(String? val) => _maxSqft = val;

  bool hasMaxSqft() => _maxSqft != null;

  // "minYearBuilt" field.
  String? _minYearBuilt;
  String get minYearBuilt => _minYearBuilt ?? '';
  set minYearBuilt(String? val) => _minYearBuilt = val;

  bool hasMinYearBuilt() => _minYearBuilt != null;

  // "maxYearBuilt" field.
  String? _maxYearBuilt;
  String get maxYearBuilt => _maxYearBuilt ?? '';
  set maxYearBuilt(String? val) => _maxYearBuilt = val;

  bool hasMaxYearBuilt() => _maxYearBuilt != null;

  // "homeTypes" field.
  List<String>? _homeTypes;
  List<String> get homeTypes => _homeTypes ?? const [];
  set homeTypes(List<String>? val) => _homeTypes = val;

  void updateHomeTypes(Function(List<String>) updateFn) {
    updateFn(_homeTypes ??= []);
  }

  bool hasHomeTypes() => _homeTypes != null;

  static SearchFilterDataStruct fromMap(Map<String, dynamic> data) =>
      SearchFilterDataStruct(
        minPrice: data['minPrice'] as String?,
        maxPrice: data['maxPrice'] as String?,
        minBeds: data['minBeds'] as String?,
        maxBeds: data['maxBeds'] as String?,
        minBaths: data['minBaths'] as String?,
        maxBaths: data['maxBaths'] as String?,
        minSqft: data['minSqft'] as String?,
        maxSqft: data['maxSqft'] as String?,
        minYearBuilt: data['minYearBuilt'] as String?,
        maxYearBuilt: data['maxYearBuilt'] as String?,
        homeTypes: getDataList(data['homeTypes']),
      );

  static SearchFilterDataStruct? maybeFromMap(dynamic data) => data is Map
      ? SearchFilterDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'minPrice': _minPrice,
        'maxPrice': _maxPrice,
        'minBeds': _minBeds,
        'maxBeds': _maxBeds,
        'minBaths': _minBaths,
        'maxBaths': _maxBaths,
        'minSqft': _minSqft,
        'maxSqft': _maxSqft,
        'minYearBuilt': _minYearBuilt,
        'maxYearBuilt': _maxYearBuilt,
        'homeTypes': _homeTypes,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'minPrice': serializeParam(
          _minPrice,
          ParamType.String,
        ),
        'maxPrice': serializeParam(
          _maxPrice,
          ParamType.String,
        ),
        'minBeds': serializeParam(
          _minBeds,
          ParamType.String,
        ),
        'maxBeds': serializeParam(
          _maxBeds,
          ParamType.String,
        ),
        'minBaths': serializeParam(
          _minBaths,
          ParamType.String,
        ),
        'maxBaths': serializeParam(
          _maxBaths,
          ParamType.String,
        ),
        'minSqft': serializeParam(
          _minSqft,
          ParamType.String,
        ),
        'maxSqft': serializeParam(
          _maxSqft,
          ParamType.String,
        ),
        'minYearBuilt': serializeParam(
          _minYearBuilt,
          ParamType.String,
        ),
        'maxYearBuilt': serializeParam(
          _maxYearBuilt,
          ParamType.String,
        ),
        'homeTypes': serializeParam(
          _homeTypes,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SearchFilterDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SearchFilterDataStruct(
        minPrice: deserializeParam(
          data['minPrice'],
          ParamType.String,
          false,
        ),
        maxPrice: deserializeParam(
          data['maxPrice'],
          ParamType.String,
          false,
        ),
        minBeds: deserializeParam(
          data['minBeds'],
          ParamType.String,
          false,
        ),
        maxBeds: deserializeParam(
          data['maxBeds'],
          ParamType.String,
          false,
        ),
        minBaths: deserializeParam(
          data['minBaths'],
          ParamType.String,
          false,
        ),
        maxBaths: deserializeParam(
          data['maxBaths'],
          ParamType.String,
          false,
        ),
        minSqft: deserializeParam(
          data['minSqft'],
          ParamType.String,
          false,
        ),
        maxSqft: deserializeParam(
          data['maxSqft'],
          ParamType.String,
          false,
        ),
        minYearBuilt: deserializeParam(
          data['minYearBuilt'],
          ParamType.String,
          false,
        ),
        maxYearBuilt: deserializeParam(
          data['maxYearBuilt'],
          ParamType.String,
          false,
        ),
        homeTypes: deserializeParam<String>(
          data['homeTypes'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'SearchFilterDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SearchFilterDataStruct &&
        minPrice == other.minPrice &&
        maxPrice == other.maxPrice &&
        minBeds == other.minBeds &&
        maxBeds == other.maxBeds &&
        minBaths == other.minBaths &&
        maxBaths == other.maxBaths &&
        minSqft == other.minSqft &&
        maxSqft == other.maxSqft &&
        minYearBuilt == other.minYearBuilt &&
        maxYearBuilt == other.maxYearBuilt &&
        listEquality.equals(homeTypes, other.homeTypes);
  }

  @override
  int get hashCode => const ListEquality().hash([
        minPrice,
        maxPrice,
        minBeds,
        maxBeds,
        minBaths,
        maxBaths,
        minSqft,
        maxSqft,
        minYearBuilt,
        maxYearBuilt,
        homeTypes
      ]);
}

SearchFilterDataStruct createSearchFilterDataStruct({
  String? minPrice,
  String? maxPrice,
  String? minBeds,
  String? maxBeds,
  String? minBaths,
  String? maxBaths,
  String? minSqft,
  String? maxSqft,
  String? minYearBuilt,
  String? maxYearBuilt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SearchFilterDataStruct(
      minPrice: minPrice,
      maxPrice: maxPrice,
      minBeds: minBeds,
      maxBeds: maxBeds,
      minBaths: minBaths,
      maxBaths: maxBaths,
      minSqft: minSqft,
      maxSqft: maxSqft,
      minYearBuilt: minYearBuilt,
      maxYearBuilt: maxYearBuilt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SearchFilterDataStruct? updateSearchFilterDataStruct(
  SearchFilterDataStruct? searchFilterData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    searchFilterData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSearchFilterDataStructData(
  Map<String, dynamic> firestoreData,
  SearchFilterDataStruct? searchFilterData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (searchFilterData == null) {
    return;
  }
  if (searchFilterData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && searchFilterData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final searchFilterDataData =
      getSearchFilterDataFirestoreData(searchFilterData, forFieldValue);
  final nestedData =
      searchFilterDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = searchFilterData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSearchFilterDataFirestoreData(
  SearchFilterDataStruct? searchFilterData, [
  bool forFieldValue = false,
]) {
  if (searchFilterData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(searchFilterData.toMap());

  // Add any Firestore field values
  searchFilterData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSearchFilterDataListFirestoreData(
  List<SearchFilterDataStruct>? searchFilterDatas,
) =>
    searchFilterDatas
        ?.map((e) => getSearchFilterDataFirestoreData(e, true))
        .toList() ??
    [];
