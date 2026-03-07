// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MemberSuggestionStruct extends FFFirebaseStruct {
  MemberSuggestionStruct({
    DateTime? createdAt,
    MemberStruct? member,
    bool? isLinked,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _createdAt = createdAt,
        _member = member,
        _isLinked = isLinked,
        super(firestoreUtilData);

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "member" field.
  MemberStruct? _member;
  MemberStruct get member => _member ?? MemberStruct();
  set member(MemberStruct? val) => _member = val;

  void updateMember(Function(MemberStruct) updateFn) {
    updateFn(_member ??= MemberStruct());
  }

  bool hasMember() => _member != null;

  // "isLinked" field.
  bool? _isLinked;
  bool get isLinked => _isLinked ?? false;
  set isLinked(bool? val) => _isLinked = val;

  bool hasIsLinked() => _isLinked != null;

  static MemberSuggestionStruct fromMap(Map<String, dynamic> data) =>
      MemberSuggestionStruct(
        createdAt: data['created_at'] as DateTime?,
        member: data['member'] is MemberStruct
            ? data['member']
            : MemberStruct.maybeFromMap(data['member']),
        isLinked: data['isLinked'] as bool?,
      );

  static MemberSuggestionStruct? maybeFromMap(dynamic data) => data is Map
      ? MemberSuggestionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'member': _member?.toMap(),
        'isLinked': _isLinked,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'member': serializeParam(
          _member,
          ParamType.DataStruct,
        ),
        'isLinked': serializeParam(
          _isLinked,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MemberSuggestionStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MemberSuggestionStruct(
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        member: deserializeStructParam(
          data['member'],
          ParamType.DataStruct,
          false,
          structBuilder: MemberStruct.fromSerializableMap,
        ),
        isLinked: deserializeParam(
          data['isLinked'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MemberSuggestionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MemberSuggestionStruct &&
        createdAt == other.createdAt &&
        member == other.member &&
        isLinked == other.isLinked;
  }

  @override
  int get hashCode => const ListEquality().hash([createdAt, member, isLinked]);
}

MemberSuggestionStruct createMemberSuggestionStruct({
  DateTime? createdAt,
  MemberStruct? member,
  bool? isLinked,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MemberSuggestionStruct(
      createdAt: createdAt,
      member: member ?? (clearUnsetFields ? MemberStruct() : null),
      isLinked: isLinked,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MemberSuggestionStruct? updateMemberSuggestionStruct(
  MemberSuggestionStruct? memberSuggestion, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    memberSuggestion
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMemberSuggestionStructData(
  Map<String, dynamic> firestoreData,
  MemberSuggestionStruct? memberSuggestion,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (memberSuggestion == null) {
    return;
  }
  if (memberSuggestion.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && memberSuggestion.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final memberSuggestionData =
      getMemberSuggestionFirestoreData(memberSuggestion, forFieldValue);
  final nestedData =
      memberSuggestionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = memberSuggestion.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMemberSuggestionFirestoreData(
  MemberSuggestionStruct? memberSuggestion, [
  bool forFieldValue = false,
]) {
  if (memberSuggestion == null) {
    return {};
  }
  final firestoreData = mapToFirestore(memberSuggestion.toMap());

  // Handle nested data for "member" field.
  addMemberStructData(
    firestoreData,
    memberSuggestion.hasMember() ? memberSuggestion.member : null,
    'member',
    forFieldValue,
  );

  // Add any Firestore field values
  memberSuggestion.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMemberSuggestionListFirestoreData(
  List<MemberSuggestionStruct>? memberSuggestions,
) =>
    memberSuggestions
        ?.map((e) => getMemberSuggestionFirestoreData(e, true))
        .toList() ??
    [];
