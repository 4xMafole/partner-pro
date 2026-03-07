// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactRecipientsStruct extends FFFirebaseStruct {
  ContactRecipientsStruct({
    int? agentReason,
    String? zpro,
    int? recentSales,
    int? reviewCount,
    String? displayName,
    String? zuid,
    String? badgeType,
    PhoneStruct? phone,
    String? imageUrl,
    double? ratingAverage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _agentReason = agentReason,
        _zpro = zpro,
        _recentSales = recentSales,
        _reviewCount = reviewCount,
        _displayName = displayName,
        _zuid = zuid,
        _badgeType = badgeType,
        _phone = phone,
        _imageUrl = imageUrl,
        _ratingAverage = ratingAverage,
        super(firestoreUtilData);

  // "agent_reason" field.
  int? _agentReason;
  int get agentReason => _agentReason ?? 0;
  set agentReason(int? val) => _agentReason = val;

  void incrementAgentReason(int amount) => agentReason = agentReason + amount;

  bool hasAgentReason() => _agentReason != null;

  // "zpro" field.
  String? _zpro;
  String get zpro => _zpro ?? '';
  set zpro(String? val) => _zpro = val;

  bool hasZpro() => _zpro != null;

  // "recent_sales" field.
  int? _recentSales;
  int get recentSales => _recentSales ?? 0;
  set recentSales(int? val) => _recentSales = val;

  void incrementRecentSales(int amount) => recentSales = recentSales + amount;

  bool hasRecentSales() => _recentSales != null;

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

  // "zuid" field.
  String? _zuid;
  String get zuid => _zuid ?? '';
  set zuid(String? val) => _zuid = val;

  bool hasZuid() => _zuid != null;

  // "badge_type" field.
  String? _badgeType;
  String get badgeType => _badgeType ?? '';
  set badgeType(String? val) => _badgeType = val;

  bool hasBadgeType() => _badgeType != null;

  // "phone" field.
  PhoneStruct? _phone;
  PhoneStruct get phone => _phone ?? PhoneStruct();
  set phone(PhoneStruct? val) => _phone = val;

  void updatePhone(Function(PhoneStruct) updateFn) {
    updateFn(_phone ??= PhoneStruct());
  }

  bool hasPhone() => _phone != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  // "rating_average" field.
  double? _ratingAverage;
  double get ratingAverage => _ratingAverage ?? 0.0;
  set ratingAverage(double? val) => _ratingAverage = val;

  void incrementRatingAverage(double amount) =>
      ratingAverage = ratingAverage + amount;

  bool hasRatingAverage() => _ratingAverage != null;

  static ContactRecipientsStruct fromMap(Map<String, dynamic> data) =>
      ContactRecipientsStruct(
        agentReason: castToType<int>(data['agent_reason']),
        zpro: data['zpro'] as String?,
        recentSales: castToType<int>(data['recent_sales']),
        reviewCount: castToType<int>(data['review_count']),
        displayName: data['display_name'] as String?,
        zuid: data['zuid'] as String?,
        badgeType: data['badge_type'] as String?,
        phone: data['phone'] is PhoneStruct
            ? data['phone']
            : PhoneStruct.maybeFromMap(data['phone']),
        imageUrl: data['image_url'] as String?,
        ratingAverage: castToType<double>(data['rating_average']),
      );

  static ContactRecipientsStruct? maybeFromMap(dynamic data) => data is Map
      ? ContactRecipientsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'agent_reason': _agentReason,
        'zpro': _zpro,
        'recent_sales': _recentSales,
        'review_count': _reviewCount,
        'display_name': _displayName,
        'zuid': _zuid,
        'badge_type': _badgeType,
        'phone': _phone?.toMap(),
        'image_url': _imageUrl,
        'rating_average': _ratingAverage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'agent_reason': serializeParam(
          _agentReason,
          ParamType.int,
        ),
        'zpro': serializeParam(
          _zpro,
          ParamType.String,
        ),
        'recent_sales': serializeParam(
          _recentSales,
          ParamType.int,
        ),
        'review_count': serializeParam(
          _reviewCount,
          ParamType.int,
        ),
        'display_name': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'zuid': serializeParam(
          _zuid,
          ParamType.String,
        ),
        'badge_type': serializeParam(
          _badgeType,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.DataStruct,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
        'rating_average': serializeParam(
          _ratingAverage,
          ParamType.double,
        ),
      }.withoutNulls;

  static ContactRecipientsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ContactRecipientsStruct(
        agentReason: deserializeParam(
          data['agent_reason'],
          ParamType.int,
          false,
        ),
        zpro: deserializeParam(
          data['zpro'],
          ParamType.String,
          false,
        ),
        recentSales: deserializeParam(
          data['recent_sales'],
          ParamType.int,
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
        zuid: deserializeParam(
          data['zuid'],
          ParamType.String,
          false,
        ),
        badgeType: deserializeParam(
          data['badge_type'],
          ParamType.String,
          false,
        ),
        phone: deserializeStructParam(
          data['phone'],
          ParamType.DataStruct,
          false,
          structBuilder: PhoneStruct.fromSerializableMap,
        ),
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
        ratingAverage: deserializeParam(
          data['rating_average'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'ContactRecipientsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactRecipientsStruct &&
        agentReason == other.agentReason &&
        zpro == other.zpro &&
        recentSales == other.recentSales &&
        reviewCount == other.reviewCount &&
        displayName == other.displayName &&
        zuid == other.zuid &&
        badgeType == other.badgeType &&
        phone == other.phone &&
        imageUrl == other.imageUrl &&
        ratingAverage == other.ratingAverage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        agentReason,
        zpro,
        recentSales,
        reviewCount,
        displayName,
        zuid,
        badgeType,
        phone,
        imageUrl,
        ratingAverage
      ]);
}

ContactRecipientsStruct createContactRecipientsStruct({
  int? agentReason,
  String? zpro,
  int? recentSales,
  int? reviewCount,
  String? displayName,
  String? zuid,
  String? badgeType,
  PhoneStruct? phone,
  String? imageUrl,
  double? ratingAverage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContactRecipientsStruct(
      agentReason: agentReason,
      zpro: zpro,
      recentSales: recentSales,
      reviewCount: reviewCount,
      displayName: displayName,
      zuid: zuid,
      badgeType: badgeType,
      phone: phone ?? (clearUnsetFields ? PhoneStruct() : null),
      imageUrl: imageUrl,
      ratingAverage: ratingAverage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContactRecipientsStruct? updateContactRecipientsStruct(
  ContactRecipientsStruct? contactRecipients, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contactRecipients
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContactRecipientsStructData(
  Map<String, dynamic> firestoreData,
  ContactRecipientsStruct? contactRecipients,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contactRecipients == null) {
    return;
  }
  if (contactRecipients.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contactRecipients.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contactRecipientsData =
      getContactRecipientsFirestoreData(contactRecipients, forFieldValue);
  final nestedData =
      contactRecipientsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contactRecipients.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContactRecipientsFirestoreData(
  ContactRecipientsStruct? contactRecipients, [
  bool forFieldValue = false,
]) {
  if (contactRecipients == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contactRecipients.toMap());

  // Handle nested data for "phone" field.
  addPhoneStructData(
    firestoreData,
    contactRecipients.hasPhone() ? contactRecipients.phone : null,
    'phone',
    forFieldValue,
  );

  // Add any Firestore field values
  contactRecipients.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContactRecipientsListFirestoreData(
  List<ContactRecipientsStruct>? contactRecipientss,
) =>
    contactRecipientss
        ?.map((e) => getContactRecipientsFirestoreData(e, true))
        .toList() ??
    [];
