// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserIDCardStruct extends FFFirebaseStruct {
  UserIDCardStruct({
    String? front,
    String? back,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _front = front,
        _back = back,
        super(firestoreUtilData);

  // "Front" field.
  String? _front;
  String get front => _front ?? '';
  set front(String? val) => _front = val;

  bool hasFront() => _front != null;

  // "Back" field.
  String? _back;
  String get back => _back ?? '';
  set back(String? val) => _back = val;

  bool hasBack() => _back != null;

  static UserIDCardStruct fromMap(Map<String, dynamic> data) =>
      UserIDCardStruct(
        front: data['Front'] as String?,
        back: data['Back'] as String?,
      );

  static UserIDCardStruct? maybeFromMap(dynamic data) => data is Map
      ? UserIDCardStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Front': _front,
        'Back': _back,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Front': serializeParam(
          _front,
          ParamType.String,
        ),
        'Back': serializeParam(
          _back,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserIDCardStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserIDCardStruct(
        front: deserializeParam(
          data['Front'],
          ParamType.String,
          false,
        ),
        back: deserializeParam(
          data['Back'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserIDCardStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserIDCardStruct &&
        front == other.front &&
        back == other.back;
  }

  @override
  int get hashCode => const ListEquality().hash([front, back]);
}

UserIDCardStruct createUserIDCardStruct({
  String? front,
  String? back,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserIDCardStruct(
      front: front,
      back: back,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserIDCardStruct? updateUserIDCardStruct(
  UserIDCardStruct? userIDCard, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userIDCard
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserIDCardStructData(
  Map<String, dynamic> firestoreData,
  UserIDCardStruct? userIDCard,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userIDCard == null) {
    return;
  }
  if (userIDCard.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userIDCard.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userIDCardData = getUserIDCardFirestoreData(userIDCard, forFieldValue);
  final nestedData = userIDCardData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userIDCard.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserIDCardFirestoreData(
  UserIDCardStruct? userIDCard, [
  bool forFieldValue = false,
]) {
  if (userIDCard == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userIDCard.toMap());

  // Add any Firestore field values
  userIDCard.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserIDCardListFirestoreData(
  List<UserIDCardStruct>? userIDCards,
) =>
    userIDCards?.map((e) => getUserIDCardFirestoreData(e, true)).toList() ?? [];
