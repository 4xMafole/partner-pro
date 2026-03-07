// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SearchStruct extends FFFirebaseStruct {
  SearchStruct({
    String? inputField,
    PropertyDataClassStruct? property,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _inputField = inputField,
        _property = property,
        super(firestoreUtilData);

  // "input_field" field.
  String? _inputField;
  String get inputField => _inputField ?? '';
  set inputField(String? val) => _inputField = val;

  bool hasInputField() => _inputField != null;

  // "property" field.
  PropertyDataClassStruct? _property;
  PropertyDataClassStruct get property =>
      _property ?? PropertyDataClassStruct();
  set property(PropertyDataClassStruct? val) => _property = val;

  void updateProperty(Function(PropertyDataClassStruct) updateFn) {
    updateFn(_property ??= PropertyDataClassStruct());
  }

  bool hasProperty() => _property != null;

  static SearchStruct fromMap(Map<String, dynamic> data) => SearchStruct(
        inputField: data['input_field'] as String?,
        property: data['property'] is PropertyDataClassStruct
            ? data['property']
            : PropertyDataClassStruct.maybeFromMap(data['property']),
      );

  static SearchStruct? maybeFromMap(dynamic data) =>
      data is Map ? SearchStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'input_field': _inputField,
        'property': _property?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'input_field': serializeParam(
          _inputField,
          ParamType.String,
        ),
        'property': serializeParam(
          _property,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static SearchStruct fromSerializableMap(Map<String, dynamic> data) =>
      SearchStruct(
        inputField: deserializeParam(
          data['input_field'],
          ParamType.String,
          false,
        ),
        property: deserializeStructParam(
          data['property'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyDataClassStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SearchStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SearchStruct &&
        inputField == other.inputField &&
        property == other.property;
  }

  @override
  int get hashCode => const ListEquality().hash([inputField, property]);
}

SearchStruct createSearchStruct({
  String? inputField,
  PropertyDataClassStruct? property,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SearchStruct(
      inputField: inputField,
      property:
          property ?? (clearUnsetFields ? PropertyDataClassStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SearchStruct? updateSearchStruct(
  SearchStruct? search, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    search
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSearchStructData(
  Map<String, dynamic> firestoreData,
  SearchStruct? search,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (search == null) {
    return;
  }
  if (search.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && search.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final searchData = getSearchFirestoreData(search, forFieldValue);
  final nestedData = searchData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = search.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSearchFirestoreData(
  SearchStruct? search, [
  bool forFieldValue = false,
]) {
  if (search == null) {
    return {};
  }
  final firestoreData = mapToFirestore(search.toMap());

  // Handle nested data for "property" field.
  addPropertyDataClassStructData(
    firestoreData,
    search.hasProperty() ? search.property : null,
    'property',
    forFieldValue,
  );

  // Add any Firestore field values
  search.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSearchListFirestoreData(
  List<SearchStruct>? searchs,
) =>
    searchs?.map((e) => getSearchFirestoreData(e, true)).toList() ?? [];
