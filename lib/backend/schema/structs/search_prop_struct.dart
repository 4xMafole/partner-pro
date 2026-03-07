// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SearchPropStruct extends FFFirebaseStruct {
  SearchPropStruct({
    List<PropertyModelStruct>? prop,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _prop = prop,
        super(firestoreUtilData);

  // "prop" field.
  List<PropertyModelStruct>? _prop;
  List<PropertyModelStruct> get prop => _prop ?? const [];
  set prop(List<PropertyModelStruct>? val) => _prop = val;

  void updateProp(Function(List<PropertyModelStruct>) updateFn) {
    updateFn(_prop ??= []);
  }

  bool hasProp() => _prop != null;

  static SearchPropStruct fromMap(Map<String, dynamic> data) =>
      SearchPropStruct(
        prop: getStructList(
          data['prop'],
          PropertyModelStruct.fromMap,
        ),
      );

  static SearchPropStruct? maybeFromMap(dynamic data) => data is Map
      ? SearchPropStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'prop': _prop?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'prop': serializeParam(
          _prop,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SearchPropStruct fromSerializableMap(Map<String, dynamic> data) =>
      SearchPropStruct(
        prop: deserializeStructParam<PropertyModelStruct>(
          data['prop'],
          ParamType.DataStruct,
          true,
          structBuilder: PropertyModelStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SearchPropStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SearchPropStruct && listEquality.equals(prop, other.prop);
  }

  @override
  int get hashCode => const ListEquality().hash([prop]);
}

SearchPropStruct createSearchPropStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SearchPropStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SearchPropStruct? updateSearchPropStruct(
  SearchPropStruct? searchProp, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    searchProp
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSearchPropStructData(
  Map<String, dynamic> firestoreData,
  SearchPropStruct? searchProp,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (searchProp == null) {
    return;
  }
  if (searchProp.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && searchProp.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final searchPropData = getSearchPropFirestoreData(searchProp, forFieldValue);
  final nestedData = searchPropData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = searchProp.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSearchPropFirestoreData(
  SearchPropStruct? searchProp, [
  bool forFieldValue = false,
]) {
  if (searchProp == null) {
    return {};
  }
  final firestoreData = mapToFirestore(searchProp.toMap());

  // Add any Firestore field values
  searchProp.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSearchPropListFirestoreData(
  List<SearchPropStruct>? searchProps,
) =>
    searchProps?.map((e) => getSearchPropFirestoreData(e, true)).toList() ?? [];
