// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolsStruct extends FFFirebaseStruct {
  SchoolsStruct({
    String? link,
    int? rating,
    String? totalCount,
    double? distance,
    String? assigned,
    String? name,
    String? studentsPerTeacher,
    String? isAssigned,
    String? size,
    String? level,
    String? grades,
    String? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _link = link,
        _rating = rating,
        _totalCount = totalCount,
        _distance = distance,
        _assigned = assigned,
        _name = name,
        _studentsPerTeacher = studentsPerTeacher,
        _isAssigned = isAssigned,
        _size = size,
        _level = level,
        _grades = grades,
        _type = type,
        super(firestoreUtilData);

  // "link" field.
  String? _link;
  String get link => _link ?? '';
  set link(String? val) => _link = val;

  bool hasLink() => _link != null;

  // "rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  set rating(int? val) => _rating = val;

  void incrementRating(int amount) => rating = rating + amount;

  bool hasRating() => _rating != null;

  // "totalCount" field.
  String? _totalCount;
  String get totalCount => _totalCount ?? '';
  set totalCount(String? val) => _totalCount = val;

  bool hasTotalCount() => _totalCount != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "assigned" field.
  String? _assigned;
  String get assigned => _assigned ?? '';
  set assigned(String? val) => _assigned = val;

  bool hasAssigned() => _assigned != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "studentsPerTeacher" field.
  String? _studentsPerTeacher;
  String get studentsPerTeacher => _studentsPerTeacher ?? '';
  set studentsPerTeacher(String? val) => _studentsPerTeacher = val;

  bool hasStudentsPerTeacher() => _studentsPerTeacher != null;

  // "isAssigned" field.
  String? _isAssigned;
  String get isAssigned => _isAssigned ?? '';
  set isAssigned(String? val) => _isAssigned = val;

  bool hasIsAssigned() => _isAssigned != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  // "level" field.
  String? _level;
  String get level => _level ?? '';
  set level(String? val) => _level = val;

  bool hasLevel() => _level != null;

  // "grades" field.
  String? _grades;
  String get grades => _grades ?? '';
  set grades(String? val) => _grades = val;

  bool hasGrades() => _grades != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static SchoolsStruct fromMap(Map<String, dynamic> data) => SchoolsStruct(
        link: data['link'] as String?,
        rating: castToType<int>(data['rating']),
        totalCount: data['totalCount'] as String?,
        distance: castToType<double>(data['distance']),
        assigned: data['assigned'] as String?,
        name: data['name'] as String?,
        studentsPerTeacher: data['studentsPerTeacher'] as String?,
        isAssigned: data['isAssigned'] as String?,
        size: data['size'] as String?,
        level: data['level'] as String?,
        grades: data['grades'] as String?,
        type: data['type'] as String?,
      );

  static SchoolsStruct? maybeFromMap(dynamic data) =>
      data is Map ? SchoolsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'link': _link,
        'rating': _rating,
        'totalCount': _totalCount,
        'distance': _distance,
        'assigned': _assigned,
        'name': _name,
        'studentsPerTeacher': _studentsPerTeacher,
        'isAssigned': _isAssigned,
        'size': _size,
        'level': _level,
        'grades': _grades,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'link': serializeParam(
          _link,
          ParamType.String,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.int,
        ),
        'totalCount': serializeParam(
          _totalCount,
          ParamType.String,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'assigned': serializeParam(
          _assigned,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'studentsPerTeacher': serializeParam(
          _studentsPerTeacher,
          ParamType.String,
        ),
        'isAssigned': serializeParam(
          _isAssigned,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'level': serializeParam(
          _level,
          ParamType.String,
        ),
        'grades': serializeParam(
          _grades,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static SchoolsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SchoolsStruct(
        link: deserializeParam(
          data['link'],
          ParamType.String,
          false,
        ),
        rating: deserializeParam(
          data['rating'],
          ParamType.int,
          false,
        ),
        totalCount: deserializeParam(
          data['totalCount'],
          ParamType.String,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        assigned: deserializeParam(
          data['assigned'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        studentsPerTeacher: deserializeParam(
          data['studentsPerTeacher'],
          ParamType.String,
          false,
        ),
        isAssigned: deserializeParam(
          data['isAssigned'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        level: deserializeParam(
          data['level'],
          ParamType.String,
          false,
        ),
        grades: deserializeParam(
          data['grades'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SchoolsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SchoolsStruct &&
        link == other.link &&
        rating == other.rating &&
        totalCount == other.totalCount &&
        distance == other.distance &&
        assigned == other.assigned &&
        name == other.name &&
        studentsPerTeacher == other.studentsPerTeacher &&
        isAssigned == other.isAssigned &&
        size == other.size &&
        level == other.level &&
        grades == other.grades &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([
        link,
        rating,
        totalCount,
        distance,
        assigned,
        name,
        studentsPerTeacher,
        isAssigned,
        size,
        level,
        grades,
        type
      ]);
}

SchoolsStruct createSchoolsStruct({
  String? link,
  int? rating,
  String? totalCount,
  double? distance,
  String? assigned,
  String? name,
  String? studentsPerTeacher,
  String? isAssigned,
  String? size,
  String? level,
  String? grades,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SchoolsStruct(
      link: link,
      rating: rating,
      totalCount: totalCount,
      distance: distance,
      assigned: assigned,
      name: name,
      studentsPerTeacher: studentsPerTeacher,
      isAssigned: isAssigned,
      size: size,
      level: level,
      grades: grades,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SchoolsStruct? updateSchoolsStruct(
  SchoolsStruct? schools, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    schools
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSchoolsStructData(
  Map<String, dynamic> firestoreData,
  SchoolsStruct? schools,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (schools == null) {
    return;
  }
  if (schools.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && schools.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final schoolsData = getSchoolsFirestoreData(schools, forFieldValue);
  final nestedData = schoolsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = schools.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSchoolsFirestoreData(
  SchoolsStruct? schools, [
  bool forFieldValue = false,
]) {
  if (schools == null) {
    return {};
  }
  final firestoreData = mapToFirestore(schools.toMap());

  // Add any Firestore field values
  schools.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSchoolsListFirestoreData(
  List<SchoolsStruct>? schoolss,
) =>
    schoolss?.map((e) => getSchoolsFirestoreData(e, true)).toList() ?? [];
