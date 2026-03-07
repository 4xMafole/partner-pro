// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AssociationsStruct extends FFFirebaseStruct {
  AssociationsStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static AssociationsStruct fromMap(Map<String, dynamic> data) =>
      AssociationsStruct(
        id: data['id'] as String?,
      );

  static AssociationsStruct? maybeFromMap(dynamic data) => data is Map
      ? AssociationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static AssociationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      AssociationsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AssociationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AssociationsStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

AssociationsStruct createAssociationsStruct({
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AssociationsStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AssociationsStruct? updateAssociationsStruct(
  AssociationsStruct? associations, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    associations
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAssociationsStructData(
  Map<String, dynamic> firestoreData,
  AssociationsStruct? associations,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (associations == null) {
    return;
  }
  if (associations.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && associations.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final associationsData =
      getAssociationsFirestoreData(associations, forFieldValue);
  final nestedData =
      associationsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = associations.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAssociationsFirestoreData(
  AssociationsStruct? associations, [
  bool forFieldValue = false,
]) {
  if (associations == null) {
    return {};
  }
  final firestoreData = mapToFirestore(associations.toMap());

  // Add any Firestore field values
  associations.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAssociationsListFirestoreData(
  List<AssociationsStruct>? associationss,
) =>
    associationss?.map((e) => getAssociationsFirestoreData(e, true)).toList() ??
    [];
