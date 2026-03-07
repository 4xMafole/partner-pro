// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProofOfFundsStruct extends FFFirebaseStruct {
  ProofOfFundsStruct({
    List<String>? urls,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _urls = urls,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "urls" field.
  List<String>? _urls;
  List<String> get urls => _urls ?? const [];
  set urls(List<String>? val) => _urls = val;

  void updateUrls(Function(List<String>) updateFn) {
    updateFn(_urls ??= []);
  }

  bool hasUrls() => _urls != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static ProofOfFundsStruct fromMap(Map<String, dynamic> data) =>
      ProofOfFundsStruct(
        urls: getDataList(data['urls']),
        createdAt: data['created_at'] as DateTime?,
      );

  static ProofOfFundsStruct? maybeFromMap(dynamic data) => data is Map
      ? ProofOfFundsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'urls': _urls,
        'created_at': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'urls': serializeParam(
          _urls,
          ParamType.String,
          isList: true,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ProofOfFundsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProofOfFundsStruct(
        urls: deserializeParam<String>(
          data['urls'],
          ParamType.String,
          true,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ProofOfFundsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ProofOfFundsStruct &&
        listEquality.equals(urls, other.urls) &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([urls, createdAt]);
}

ProofOfFundsStruct createProofOfFundsStruct({
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProofOfFundsStruct(
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProofOfFundsStruct? updateProofOfFundsStruct(
  ProofOfFundsStruct? proofOfFunds, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    proofOfFunds
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProofOfFundsStructData(
  Map<String, dynamic> firestoreData,
  ProofOfFundsStruct? proofOfFunds,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (proofOfFunds == null) {
    return;
  }
  if (proofOfFunds.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && proofOfFunds.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final proofOfFundsData =
      getProofOfFundsFirestoreData(proofOfFunds, forFieldValue);
  final nestedData =
      proofOfFundsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = proofOfFunds.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProofOfFundsFirestoreData(
  ProofOfFundsStruct? proofOfFunds, [
  bool forFieldValue = false,
]) {
  if (proofOfFunds == null) {
    return {};
  }
  final firestoreData = mapToFirestore(proofOfFunds.toMap());

  // Add any Firestore field values
  proofOfFunds.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProofOfFundsListFirestoreData(
  List<ProofOfFundsStruct>? proofOfFundss,
) =>
    proofOfFundss?.map((e) => getProofOfFundsFirestoreData(e, true)).toList() ??
    [];
