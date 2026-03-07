// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BuyerAgentStruct extends FFFirebaseStruct {
  BuyerAgentStruct({
    String? name,
    PhotoStruct? photo,
    String? profileUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _photo = photo,
        _profileUrl = profileUrl,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "photo" field.
  PhotoStruct? _photo;
  PhotoStruct get photo => _photo ?? PhotoStruct();
  set photo(PhotoStruct? val) => _photo = val;

  void updatePhoto(Function(PhotoStruct) updateFn) {
    updateFn(_photo ??= PhotoStruct());
  }

  bool hasPhoto() => _photo != null;

  // "profileUrl" field.
  String? _profileUrl;
  String get profileUrl => _profileUrl ?? '';
  set profileUrl(String? val) => _profileUrl = val;

  bool hasProfileUrl() => _profileUrl != null;

  static BuyerAgentStruct fromMap(Map<String, dynamic> data) =>
      BuyerAgentStruct(
        name: data['name'] as String?,
        photo: data['photo'] is PhotoStruct
            ? data['photo']
            : PhotoStruct.maybeFromMap(data['photo']),
        profileUrl: data['profileUrl'] as String?,
      );

  static BuyerAgentStruct? maybeFromMap(dynamic data) => data is Map
      ? BuyerAgentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'photo': _photo?.toMap(),
        'profileUrl': _profileUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'photo': serializeParam(
          _photo,
          ParamType.DataStruct,
        ),
        'profileUrl': serializeParam(
          _profileUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static BuyerAgentStruct fromSerializableMap(Map<String, dynamic> data) =>
      BuyerAgentStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        photo: deserializeStructParam(
          data['photo'],
          ParamType.DataStruct,
          false,
          structBuilder: PhotoStruct.fromSerializableMap,
        ),
        profileUrl: deserializeParam(
          data['profileUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BuyerAgentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BuyerAgentStruct &&
        name == other.name &&
        photo == other.photo &&
        profileUrl == other.profileUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([name, photo, profileUrl]);
}

BuyerAgentStruct createBuyerAgentStruct({
  String? name,
  PhotoStruct? photo,
  String? profileUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BuyerAgentStruct(
      name: name,
      photo: photo ?? (clearUnsetFields ? PhotoStruct() : null),
      profileUrl: profileUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BuyerAgentStruct? updateBuyerAgentStruct(
  BuyerAgentStruct? buyerAgent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    buyerAgent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBuyerAgentStructData(
  Map<String, dynamic> firestoreData,
  BuyerAgentStruct? buyerAgent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (buyerAgent == null) {
    return;
  }
  if (buyerAgent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && buyerAgent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final buyerAgentData = getBuyerAgentFirestoreData(buyerAgent, forFieldValue);
  final nestedData = buyerAgentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = buyerAgent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBuyerAgentFirestoreData(
  BuyerAgentStruct? buyerAgent, [
  bool forFieldValue = false,
]) {
  if (buyerAgent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(buyerAgent.toMap());

  // Handle nested data for "photo" field.
  addPhotoStructData(
    firestoreData,
    buyerAgent.hasPhoto() ? buyerAgent.photo : null,
    'photo',
    forFieldValue,
  );

  // Add any Firestore field values
  buyerAgent.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBuyerAgentListFirestoreData(
  List<BuyerAgentStruct>? buyerAgents,
) =>
    buyerAgents?.map((e) => getBuyerAgentFirestoreData(e, true)).toList() ?? [];
