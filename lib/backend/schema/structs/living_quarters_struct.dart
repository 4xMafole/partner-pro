// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LivingQuartersStruct extends FFFirebaseStruct {
  LivingQuartersStruct({
    String? temporary,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _temporary = temporary,
        super(firestoreUtilData);

  // "temporary" field.
  String? _temporary;
  String get temporary => _temporary ?? '';
  set temporary(String? val) => _temporary = val;

  bool hasTemporary() => _temporary != null;

  static LivingQuartersStruct fromMap(Map<String, dynamic> data) =>
      LivingQuartersStruct(
        temporary: data['temporary'] as String?,
      );

  static LivingQuartersStruct? maybeFromMap(dynamic data) => data is Map
      ? LivingQuartersStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'temporary': _temporary,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'temporary': serializeParam(
          _temporary,
          ParamType.String,
        ),
      }.withoutNulls;

  static LivingQuartersStruct fromSerializableMap(Map<String, dynamic> data) =>
      LivingQuartersStruct(
        temporary: deserializeParam(
          data['temporary'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LivingQuartersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LivingQuartersStruct && temporary == other.temporary;
  }

  @override
  int get hashCode => const ListEquality().hash([temporary]);
}

LivingQuartersStruct createLivingQuartersStruct({
  String? temporary,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LivingQuartersStruct(
      temporary: temporary,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LivingQuartersStruct? updateLivingQuartersStruct(
  LivingQuartersStruct? livingQuarters, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    livingQuarters
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLivingQuartersStructData(
  Map<String, dynamic> firestoreData,
  LivingQuartersStruct? livingQuarters,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (livingQuarters == null) {
    return;
  }
  if (livingQuarters.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && livingQuarters.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final livingQuartersData =
      getLivingQuartersFirestoreData(livingQuarters, forFieldValue);
  final nestedData =
      livingQuartersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = livingQuarters.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLivingQuartersFirestoreData(
  LivingQuartersStruct? livingQuarters, [
  bool forFieldValue = false,
]) {
  if (livingQuarters == null) {
    return {};
  }
  final firestoreData = mapToFirestore(livingQuarters.toMap());

  // Add any Firestore field values
  livingQuarters.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLivingQuartersListFirestoreData(
  List<LivingQuartersStruct>? livingQuarterss,
) =>
    livingQuarterss
        ?.map((e) => getLivingQuartersFirestoreData(e, true))
        .toList() ??
    [];
