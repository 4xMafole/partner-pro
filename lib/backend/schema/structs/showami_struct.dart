// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShowamiStruct extends FFFirebaseStruct {
  ShowamiStruct({
    int? showingId,
    int? showingRequestId,
    String? agentShowingId,
    String? showingDate,
    String? propertyId,
    int? showTimeLength,
    String? userId,
    String? showingAgent,
    String? showingNotes,
    AddressStruct? address,
    int? price,
    int? payout,
    String? createdAt,
    String? createdBy,
    bool? status,
    bool? isCancelled,
    bool? isRescheduled,
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _showingId = showingId,
        _showingRequestId = showingRequestId,
        _agentShowingId = agentShowingId,
        _showingDate = showingDate,
        _propertyId = propertyId,
        _showTimeLength = showTimeLength,
        _userId = userId,
        _showingAgent = showingAgent,
        _showingNotes = showingNotes,
        _address = address,
        _price = price,
        _payout = payout,
        _createdAt = createdAt,
        _createdBy = createdBy,
        _status = status,
        _isCancelled = isCancelled,
        _isRescheduled = isRescheduled,
        _id = id,
        super(firestoreUtilData);

  // "showing_id" field.
  int? _showingId;
  int get showingId => _showingId ?? 0;
  set showingId(int? val) => _showingId = val;

  void incrementShowingId(int amount) => showingId = showingId + amount;

  bool hasShowingId() => _showingId != null;

  // "showing_request_id" field.
  int? _showingRequestId;
  int get showingRequestId => _showingRequestId ?? 0;
  set showingRequestId(int? val) => _showingRequestId = val;

  void incrementShowingRequestId(int amount) =>
      showingRequestId = showingRequestId + amount;

  bool hasShowingRequestId() => _showingRequestId != null;

  // "agent_showing_id" field.
  String? _agentShowingId;
  String get agentShowingId => _agentShowingId ?? '';
  set agentShowingId(String? val) => _agentShowingId = val;

  bool hasAgentShowingId() => _agentShowingId != null;

  // "showing_date" field.
  String? _showingDate;
  String get showingDate => _showingDate ?? '';
  set showingDate(String? val) => _showingDate = val;

  bool hasShowingDate() => _showingDate != null;

  // "property_id" field.
  String? _propertyId;
  String get propertyId => _propertyId ?? '';
  set propertyId(String? val) => _propertyId = val;

  bool hasPropertyId() => _propertyId != null;

  // "show_time_length" field.
  int? _showTimeLength;
  int get showTimeLength => _showTimeLength ?? 0;
  set showTimeLength(int? val) => _showTimeLength = val;

  void incrementShowTimeLength(int amount) =>
      showTimeLength = showTimeLength + amount;

  bool hasShowTimeLength() => _showTimeLength != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "showing_agent" field.
  String? _showingAgent;
  String get showingAgent => _showingAgent ?? '';
  set showingAgent(String? val) => _showingAgent = val;

  bool hasShowingAgent() => _showingAgent != null;

  // "showing_notes" field.
  String? _showingNotes;
  String get showingNotes => _showingNotes ?? '';
  set showingNotes(String? val) => _showingNotes = val;

  bool hasShowingNotes() => _showingNotes != null;

  // "address" field.
  AddressStruct? _address;
  AddressStruct get address => _address ?? AddressStruct();
  set address(AddressStruct? val) => _address = val;

  void updateAddress(Function(AddressStruct) updateFn) {
    updateFn(_address ??= AddressStruct());
  }

  bool hasAddress() => _address != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "payout" field.
  int? _payout;
  int get payout => _payout ?? 0;
  set payout(int? val) => _payout = val;

  void incrementPayout(int amount) => payout = payout + amount;

  bool hasPayout() => _payout != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "is_cancelled" field.
  bool? _isCancelled;
  bool get isCancelled => _isCancelled ?? false;
  set isCancelled(bool? val) => _isCancelled = val;

  bool hasIsCancelled() => _isCancelled != null;

  // "is_rescheduled" field.
  bool? _isRescheduled;
  bool get isRescheduled => _isRescheduled ?? false;
  set isRescheduled(bool? val) => _isRescheduled = val;

  bool hasIsRescheduled() => _isRescheduled != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static ShowamiStruct fromMap(Map<String, dynamic> data) => ShowamiStruct(
        showingId: castToType<int>(data['showing_id']),
        showingRequestId: castToType<int>(data['showing_request_id']),
        agentShowingId: data['agent_showing_id'] as String?,
        showingDate: data['showing_date'] as String?,
        propertyId: data['property_id'] as String?,
        showTimeLength: castToType<int>(data['show_time_length']),
        userId: data['user_id'] as String?,
        showingAgent: data['showing_agent'] as String?,
        showingNotes: data['showing_notes'] as String?,
        address: data['address'] is AddressStruct
            ? data['address']
            : AddressStruct.maybeFromMap(data['address']),
        price: castToType<int>(data['price']),
        payout: castToType<int>(data['payout']),
        createdAt: data['created_at'] as String?,
        createdBy: data['created_by'] as String?,
        status: data['status'] as bool?,
        isCancelled: data['is_cancelled'] as bool?,
        isRescheduled: data['is_rescheduled'] as bool?,
        id: data['id'] as String?,
      );

  static ShowamiStruct? maybeFromMap(dynamic data) =>
      data is Map ? ShowamiStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'showing_id': _showingId,
        'showing_request_id': _showingRequestId,
        'agent_showing_id': _agentShowingId,
        'showing_date': _showingDate,
        'property_id': _propertyId,
        'show_time_length': _showTimeLength,
        'user_id': _userId,
        'showing_agent': _showingAgent,
        'showing_notes': _showingNotes,
        'address': _address?.toMap(),
        'price': _price,
        'payout': _payout,
        'created_at': _createdAt,
        'created_by': _createdBy,
        'status': _status,
        'is_cancelled': _isCancelled,
        'is_rescheduled': _isRescheduled,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'showing_id': serializeParam(
          _showingId,
          ParamType.int,
        ),
        'showing_request_id': serializeParam(
          _showingRequestId,
          ParamType.int,
        ),
        'agent_showing_id': serializeParam(
          _agentShowingId,
          ParamType.String,
        ),
        'showing_date': serializeParam(
          _showingDate,
          ParamType.String,
        ),
        'property_id': serializeParam(
          _propertyId,
          ParamType.String,
        ),
        'show_time_length': serializeParam(
          _showTimeLength,
          ParamType.int,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'showing_agent': serializeParam(
          _showingAgent,
          ParamType.String,
        ),
        'showing_notes': serializeParam(
          _showingNotes,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'payout': serializeParam(
          _payout,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'is_cancelled': serializeParam(
          _isCancelled,
          ParamType.bool,
        ),
        'is_rescheduled': serializeParam(
          _isRescheduled,
          ParamType.bool,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static ShowamiStruct fromSerializableMap(Map<String, dynamic> data) =>
      ShowamiStruct(
        showingId: deserializeParam(
          data['showing_id'],
          ParamType.int,
          false,
        ),
        showingRequestId: deserializeParam(
          data['showing_request_id'],
          ParamType.int,
          false,
        ),
        agentShowingId: deserializeParam(
          data['agent_showing_id'],
          ParamType.String,
          false,
        ),
        showingDate: deserializeParam(
          data['showing_date'],
          ParamType.String,
          false,
        ),
        propertyId: deserializeParam(
          data['property_id'],
          ParamType.String,
          false,
        ),
        showTimeLength: deserializeParam(
          data['show_time_length'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        showingAgent: deserializeParam(
          data['showing_agent'],
          ParamType.String,
          false,
        ),
        showingNotes: deserializeParam(
          data['showing_notes'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: AddressStruct.fromSerializableMap,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        payout: deserializeParam(
          data['payout'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        isCancelled: deserializeParam(
          data['is_cancelled'],
          ParamType.bool,
          false,
        ),
        isRescheduled: deserializeParam(
          data['is_rescheduled'],
          ParamType.bool,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ShowamiStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ShowamiStruct &&
        showingId == other.showingId &&
        showingRequestId == other.showingRequestId &&
        agentShowingId == other.agentShowingId &&
        showingDate == other.showingDate &&
        propertyId == other.propertyId &&
        showTimeLength == other.showTimeLength &&
        userId == other.userId &&
        showingAgent == other.showingAgent &&
        showingNotes == other.showingNotes &&
        address == other.address &&
        price == other.price &&
        payout == other.payout &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        status == other.status &&
        isCancelled == other.isCancelled &&
        isRescheduled == other.isRescheduled &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        showingId,
        showingRequestId,
        agentShowingId,
        showingDate,
        propertyId,
        showTimeLength,
        userId,
        showingAgent,
        showingNotes,
        address,
        price,
        payout,
        createdAt,
        createdBy,
        status,
        isCancelled,
        isRescheduled,
        id
      ]);
}

ShowamiStruct createShowamiStruct({
  int? showingId,
  int? showingRequestId,
  String? agentShowingId,
  String? showingDate,
  String? propertyId,
  int? showTimeLength,
  String? userId,
  String? showingAgent,
  String? showingNotes,
  AddressStruct? address,
  int? price,
  int? payout,
  String? createdAt,
  String? createdBy,
  bool? status,
  bool? isCancelled,
  bool? isRescheduled,
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ShowamiStruct(
      showingId: showingId,
      showingRequestId: showingRequestId,
      agentShowingId: agentShowingId,
      showingDate: showingDate,
      propertyId: propertyId,
      showTimeLength: showTimeLength,
      userId: userId,
      showingAgent: showingAgent,
      showingNotes: showingNotes,
      address: address ?? (clearUnsetFields ? AddressStruct() : null),
      price: price,
      payout: payout,
      createdAt: createdAt,
      createdBy: createdBy,
      status: status,
      isCancelled: isCancelled,
      isRescheduled: isRescheduled,
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ShowamiStruct? updateShowamiStruct(
  ShowamiStruct? showami, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    showami
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addShowamiStructData(
  Map<String, dynamic> firestoreData,
  ShowamiStruct? showami,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (showami == null) {
    return;
  }
  if (showami.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && showami.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final showamiData = getShowamiFirestoreData(showami, forFieldValue);
  final nestedData = showamiData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = showami.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getShowamiFirestoreData(
  ShowamiStruct? showami, [
  bool forFieldValue = false,
]) {
  if (showami == null) {
    return {};
  }
  final firestoreData = mapToFirestore(showami.toMap());

  // Handle nested data for "address" field.
  addAddressStructData(
    firestoreData,
    showami.hasAddress() ? showami.address : null,
    'address',
    forFieldValue,
  );

  // Add any Firestore field values
  showami.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getShowamiListFirestoreData(
  List<ShowamiStruct>? showamis,
) =>
    showamis?.map((e) => getShowamiFirestoreData(e, true)).toList() ?? [];
