// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListedByStruct extends FFFirebaseStruct {
  ListedByStruct({
    int? agentReason,
    bool? zpro,
    int? recentSales,
    String? zuid,
    int? reviewCount,
    String? displayName,
    String? profileUrl,
    String? businessName,
    int? ratingAverage,
    PhoneStruct? phone,
    String? badgeType,
    String? imageUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _agentReason = agentReason,
        _zpro = zpro,
        _recentSales = recentSales,
        _zuid = zuid,
        _reviewCount = reviewCount,
        _displayName = displayName,
        _profileUrl = profileUrl,
        _businessName = businessName,
        _ratingAverage = ratingAverage,
        _phone = phone,
        _badgeType = badgeType,
        _imageUrl = imageUrl,
        super(firestoreUtilData);

  // "agent_reason" field.
  int? _agentReason;
  int get agentReason => _agentReason ?? 0;
  set agentReason(int? val) => _agentReason = val;

  void incrementAgentReason(int amount) => agentReason = agentReason + amount;

  bool hasAgentReason() => _agentReason != null;

  // "zpro" field.
  bool? _zpro;
  bool get zpro => _zpro ?? false;
  set zpro(bool? val) => _zpro = val;

  bool hasZpro() => _zpro != null;

  // "recent_sales" field.
  int? _recentSales;
  int get recentSales => _recentSales ?? 0;
  set recentSales(int? val) => _recentSales = val;

  void incrementRecentSales(int amount) => recentSales = recentSales + amount;

  bool hasRecentSales() => _recentSales != null;

  // "zuid" field.
  String? _zuid;
  String get zuid => _zuid ?? '';
  set zuid(String? val) => _zuid = val;

  bool hasZuid() => _zuid != null;

  // "review_count" field.
  int? _reviewCount;
  int get reviewCount => _reviewCount ?? 0;
  set reviewCount(int? val) => _reviewCount = val;

  void incrementReviewCount(int amount) => reviewCount = reviewCount + amount;

  bool hasReviewCount() => _reviewCount != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "profile_url" field.
  String? _profileUrl;
  String get profileUrl => _profileUrl ?? '';
  set profileUrl(String? val) => _profileUrl = val;

  bool hasProfileUrl() => _profileUrl != null;

  // "business_name" field.
  String? _businessName;
  String get businessName => _businessName ?? '';
  set businessName(String? val) => _businessName = val;

  bool hasBusinessName() => _businessName != null;

  // "rating_average" field.
  int? _ratingAverage;
  int get ratingAverage => _ratingAverage ?? 0;
  set ratingAverage(int? val) => _ratingAverage = val;

  void incrementRatingAverage(int amount) =>
      ratingAverage = ratingAverage + amount;

  bool hasRatingAverage() => _ratingAverage != null;

  // "phone" field.
  PhoneStruct? _phone;
  PhoneStruct get phone => _phone ?? PhoneStruct();
  set phone(PhoneStruct? val) => _phone = val;

  void updatePhone(Function(PhoneStruct) updateFn) {
    updateFn(_phone ??= PhoneStruct());
  }

  bool hasPhone() => _phone != null;

  // "badge_type" field.
  String? _badgeType;
  String get badgeType => _badgeType ?? '';
  set badgeType(String? val) => _badgeType = val;

  bool hasBadgeType() => _badgeType != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  static ListedByStruct fromMap(Map<String, dynamic> data) => ListedByStruct(
        agentReason: castToType<int>(data['agent_reason']),
        zpro: data['zpro'] as bool?,
        recentSales: castToType<int>(data['recent_sales']),
        zuid: data['zuid'] as String?,
        reviewCount: castToType<int>(data['review_count']),
        displayName: data['display_name'] as String?,
        profileUrl: data['profile_url'] as String?,
        businessName: data['business_name'] as String?,
        ratingAverage: castToType<int>(data['rating_average']),
        phone: data['phone'] is PhoneStruct
            ? data['phone']
            : PhoneStruct.maybeFromMap(data['phone']),
        badgeType: data['badge_type'] as String?,
        imageUrl: data['image_url'] as String?,
      );

  static ListedByStruct? maybeFromMap(dynamic data) =>
      data is Map ? ListedByStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'agent_reason': _agentReason,
        'zpro': _zpro,
        'recent_sales': _recentSales,
        'zuid': _zuid,
        'review_count': _reviewCount,
        'display_name': _displayName,
        'profile_url': _profileUrl,
        'business_name': _businessName,
        'rating_average': _ratingAverage,
        'phone': _phone?.toMap(),
        'badge_type': _badgeType,
        'image_url': _imageUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'agent_reason': serializeParam(
          _agentReason,
          ParamType.int,
        ),
        'zpro': serializeParam(
          _zpro,
          ParamType.bool,
        ),
        'recent_sales': serializeParam(
          _recentSales,
          ParamType.int,
        ),
        'zuid': serializeParam(
          _zuid,
          ParamType.String,
        ),
        'review_count': serializeParam(
          _reviewCount,
          ParamType.int,
        ),
        'display_name': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'profile_url': serializeParam(
          _profileUrl,
          ParamType.String,
        ),
        'business_name': serializeParam(
          _businessName,
          ParamType.String,
        ),
        'rating_average': serializeParam(
          _ratingAverage,
          ParamType.int,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.DataStruct,
        ),
        'badge_type': serializeParam(
          _badgeType,
          ParamType.String,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static ListedByStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListedByStruct(
        agentReason: deserializeParam(
          data['agent_reason'],
          ParamType.int,
          false,
        ),
        zpro: deserializeParam(
          data['zpro'],
          ParamType.bool,
          false,
        ),
        recentSales: deserializeParam(
          data['recent_sales'],
          ParamType.int,
          false,
        ),
        zuid: deserializeParam(
          data['zuid'],
          ParamType.String,
          false,
        ),
        reviewCount: deserializeParam(
          data['review_count'],
          ParamType.int,
          false,
        ),
        displayName: deserializeParam(
          data['display_name'],
          ParamType.String,
          false,
        ),
        profileUrl: deserializeParam(
          data['profile_url'],
          ParamType.String,
          false,
        ),
        businessName: deserializeParam(
          data['business_name'],
          ParamType.String,
          false,
        ),
        ratingAverage: deserializeParam(
          data['rating_average'],
          ParamType.int,
          false,
        ),
        phone: deserializeStructParam(
          data['phone'],
          ParamType.DataStruct,
          false,
          structBuilder: PhoneStruct.fromSerializableMap,
        ),
        badgeType: deserializeParam(
          data['badge_type'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ListedByStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListedByStruct &&
        agentReason == other.agentReason &&
        zpro == other.zpro &&
        recentSales == other.recentSales &&
        zuid == other.zuid &&
        reviewCount == other.reviewCount &&
        displayName == other.displayName &&
        profileUrl == other.profileUrl &&
        businessName == other.businessName &&
        ratingAverage == other.ratingAverage &&
        phone == other.phone &&
        badgeType == other.badgeType &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        agentReason,
        zpro,
        recentSales,
        zuid,
        reviewCount,
        displayName,
        profileUrl,
        businessName,
        ratingAverage,
        phone,
        badgeType,
        imageUrl
      ]);
}

ListedByStruct createListedByStruct({
  int? agentReason,
  bool? zpro,
  int? recentSales,
  String? zuid,
  int? reviewCount,
  String? displayName,
  String? profileUrl,
  String? businessName,
  int? ratingAverage,
  PhoneStruct? phone,
  String? badgeType,
  String? imageUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListedByStruct(
      agentReason: agentReason,
      zpro: zpro,
      recentSales: recentSales,
      zuid: zuid,
      reviewCount: reviewCount,
      displayName: displayName,
      profileUrl: profileUrl,
      businessName: businessName,
      ratingAverage: ratingAverage,
      phone: phone ?? (clearUnsetFields ? PhoneStruct() : null),
      badgeType: badgeType,
      imageUrl: imageUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListedByStruct? updateListedByStruct(
  ListedByStruct? listedBy, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listedBy
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListedByStructData(
  Map<String, dynamic> firestoreData,
  ListedByStruct? listedBy,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listedBy == null) {
    return;
  }
  if (listedBy.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listedBy.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listedByData = getListedByFirestoreData(listedBy, forFieldValue);
  final nestedData = listedByData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listedBy.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListedByFirestoreData(
  ListedByStruct? listedBy, [
  bool forFieldValue = false,
]) {
  if (listedBy == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listedBy.toMap());

  // Handle nested data for "phone" field.
  addPhoneStructData(
    firestoreData,
    listedBy.hasPhone() ? listedBy.phone : null,
    'phone',
    forFieldValue,
  );

  // Add any Firestore field values
  listedBy.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListedByListFirestoreData(
  List<ListedByStruct>? listedBys,
) =>
    listedBys?.map((e) => getListedByFirestoreData(e, true)).toList() ?? [];
