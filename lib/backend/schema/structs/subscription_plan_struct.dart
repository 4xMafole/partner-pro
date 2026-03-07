// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionPlanStruct extends FFFirebaseStruct {
  SubscriptionPlanStruct({
    bool? active,
    String? interval,
    int? amount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _active = active,
        _interval = interval,
        _amount = amount,
        super(firestoreUtilData);

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "interval" field.
  String? _interval;
  String get interval => _interval ?? '';
  set interval(String? val) => _interval = val;

  bool hasInterval() => _interval != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  static SubscriptionPlanStruct fromMap(Map<String, dynamic> data) =>
      SubscriptionPlanStruct(
        active: data['active'] as bool?,
        interval: data['interval'] as String?,
        amount: castToType<int>(data['amount']),
      );

  static SubscriptionPlanStruct? maybeFromMap(dynamic data) => data is Map
      ? SubscriptionPlanStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'active': _active,
        'interval': _interval,
        'amount': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'active': serializeParam(
          _active,
          ParamType.bool,
        ),
        'interval': serializeParam(
          _interval,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
      }.withoutNulls;

  static SubscriptionPlanStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubscriptionPlanStruct(
        active: deserializeParam(
          data['active'],
          ParamType.bool,
          false,
        ),
        interval: deserializeParam(
          data['interval'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SubscriptionPlanStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubscriptionPlanStruct &&
        active == other.active &&
        interval == other.interval &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([active, interval, amount]);
}

SubscriptionPlanStruct createSubscriptionPlanStruct({
  bool? active,
  String? interval,
  int? amount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubscriptionPlanStruct(
      active: active,
      interval: interval,
      amount: amount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubscriptionPlanStruct? updateSubscriptionPlanStruct(
  SubscriptionPlanStruct? subscriptionPlan, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    subscriptionPlan
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubscriptionPlanStructData(
  Map<String, dynamic> firestoreData,
  SubscriptionPlanStruct? subscriptionPlan,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (subscriptionPlan == null) {
    return;
  }
  if (subscriptionPlan.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && subscriptionPlan.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final subscriptionPlanData =
      getSubscriptionPlanFirestoreData(subscriptionPlan, forFieldValue);
  final nestedData =
      subscriptionPlanData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = subscriptionPlan.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubscriptionPlanFirestoreData(
  SubscriptionPlanStruct? subscriptionPlan, [
  bool forFieldValue = false,
]) {
  if (subscriptionPlan == null) {
    return {};
  }
  final firestoreData = mapToFirestore(subscriptionPlan.toMap());

  // Add any Firestore field values
  subscriptionPlan.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubscriptionPlanListFirestoreData(
  List<SubscriptionPlanStruct>? subscriptionPlans,
) =>
    subscriptionPlans
        ?.map((e) => getSubscriptionPlanFirestoreData(e, true))
        .toList() ??
    [];
