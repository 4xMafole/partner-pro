// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShowingPartnerProStruct extends FFFirebaseStruct {
  ShowingPartnerProStruct({
    String? stripeCustomerId,
    int? amount,
    String? currency,
    String? description,
    String? agentID,
    String? bookingID,
    MetadataStruct? metadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _stripeCustomerId = stripeCustomerId,
        _amount = amount,
        _currency = currency,
        _description = description,
        _agentID = agentID,
        _bookingID = bookingID,
        _metadata = metadata,
        super(firestoreUtilData);

  // "stripeCustomerId" field.
  String? _stripeCustomerId;
  String get stripeCustomerId => _stripeCustomerId ?? '';
  set stripeCustomerId(String? val) => _stripeCustomerId = val;

  bool hasStripeCustomerId() => _stripeCustomerId != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "agentID" field.
  String? _agentID;
  String get agentID => _agentID ?? '';
  set agentID(String? val) => _agentID = val;

  bool hasAgentID() => _agentID != null;

  // "bookingID" field.
  String? _bookingID;
  String get bookingID => _bookingID ?? '';
  set bookingID(String? val) => _bookingID = val;

  bool hasBookingID() => _bookingID != null;

  // "metadata" field.
  MetadataStruct? _metadata;
  MetadataStruct get metadata => _metadata ?? MetadataStruct();
  set metadata(MetadataStruct? val) => _metadata = val;

  void updateMetadata(Function(MetadataStruct) updateFn) {
    updateFn(_metadata ??= MetadataStruct());
  }

  bool hasMetadata() => _metadata != null;

  static ShowingPartnerProStruct fromMap(Map<String, dynamic> data) =>
      ShowingPartnerProStruct(
        stripeCustomerId: data['stripeCustomerId'] as String?,
        amount: castToType<int>(data['amount']),
        currency: data['currency'] as String?,
        description: data['description'] as String?,
        agentID: data['agentID'] as String?,
        bookingID: data['bookingID'] as String?,
        metadata: data['metadata'] is MetadataStruct
            ? data['metadata']
            : MetadataStruct.maybeFromMap(data['metadata']),
      );

  static ShowingPartnerProStruct? maybeFromMap(dynamic data) => data is Map
      ? ShowingPartnerProStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'stripeCustomerId': _stripeCustomerId,
        'amount': _amount,
        'currency': _currency,
        'description': _description,
        'agentID': _agentID,
        'bookingID': _bookingID,
        'metadata': _metadata?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'stripeCustomerId': serializeParam(
          _stripeCustomerId,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'agentID': serializeParam(
          _agentID,
          ParamType.String,
        ),
        'bookingID': serializeParam(
          _bookingID,
          ParamType.String,
        ),
        'metadata': serializeParam(
          _metadata,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ShowingPartnerProStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ShowingPartnerProStruct(
        stripeCustomerId: deserializeParam(
          data['stripeCustomerId'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        agentID: deserializeParam(
          data['agentID'],
          ParamType.String,
          false,
        ),
        bookingID: deserializeParam(
          data['bookingID'],
          ParamType.String,
          false,
        ),
        metadata: deserializeStructParam(
          data['metadata'],
          ParamType.DataStruct,
          false,
          structBuilder: MetadataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ShowingPartnerProStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ShowingPartnerProStruct &&
        stripeCustomerId == other.stripeCustomerId &&
        amount == other.amount &&
        currency == other.currency &&
        description == other.description &&
        agentID == other.agentID &&
        bookingID == other.bookingID &&
        metadata == other.metadata;
  }

  @override
  int get hashCode => const ListEquality().hash([
        stripeCustomerId,
        amount,
        currency,
        description,
        agentID,
        bookingID,
        metadata
      ]);
}

ShowingPartnerProStruct createShowingPartnerProStruct({
  String? stripeCustomerId,
  int? amount,
  String? currency,
  String? description,
  String? agentID,
  String? bookingID,
  MetadataStruct? metadata,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ShowingPartnerProStruct(
      stripeCustomerId: stripeCustomerId,
      amount: amount,
      currency: currency,
      description: description,
      agentID: agentID,
      bookingID: bookingID,
      metadata: metadata ?? (clearUnsetFields ? MetadataStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ShowingPartnerProStruct? updateShowingPartnerProStruct(
  ShowingPartnerProStruct? showingPartnerPro, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    showingPartnerPro
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addShowingPartnerProStructData(
  Map<String, dynamic> firestoreData,
  ShowingPartnerProStruct? showingPartnerPro,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (showingPartnerPro == null) {
    return;
  }
  if (showingPartnerPro.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && showingPartnerPro.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final showingPartnerProData =
      getShowingPartnerProFirestoreData(showingPartnerPro, forFieldValue);
  final nestedData =
      showingPartnerProData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = showingPartnerPro.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getShowingPartnerProFirestoreData(
  ShowingPartnerProStruct? showingPartnerPro, [
  bool forFieldValue = false,
]) {
  if (showingPartnerPro == null) {
    return {};
  }
  final firestoreData = mapToFirestore(showingPartnerPro.toMap());

  // Handle nested data for "metadata" field.
  addMetadataStructData(
    firestoreData,
    showingPartnerPro.hasMetadata() ? showingPartnerPro.metadata : null,
    'metadata',
    forFieldValue,
  );

  // Add any Firestore field values
  showingPartnerPro.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getShowingPartnerProListFirestoreData(
  List<ShowingPartnerProStruct>? showingPartnerPros,
) =>
    showingPartnerPros
        ?.map((e) => getShowingPartnerProFirestoreData(e, true))
        .toList() ??
    [];
