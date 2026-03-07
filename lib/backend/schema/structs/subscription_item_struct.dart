// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionItemStruct extends FFFirebaseStruct {
  SubscriptionItemStruct({
    SubscriptionPlanStruct? plan,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _plan = plan,
        super(firestoreUtilData);

  // "plan" field.
  SubscriptionPlanStruct? _plan;
  SubscriptionPlanStruct get plan => _plan ?? SubscriptionPlanStruct();
  set plan(SubscriptionPlanStruct? val) => _plan = val;

  void updatePlan(Function(SubscriptionPlanStruct) updateFn) {
    updateFn(_plan ??= SubscriptionPlanStruct());
  }

  bool hasPlan() => _plan != null;

  static SubscriptionItemStruct fromMap(Map<String, dynamic> data) =>
      SubscriptionItemStruct(
        plan: data['plan'] is SubscriptionPlanStruct
            ? data['plan']
            : SubscriptionPlanStruct.maybeFromMap(data['plan']),
      );

  static SubscriptionItemStruct? maybeFromMap(dynamic data) => data is Map
      ? SubscriptionItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'plan': _plan?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'plan': serializeParam(
          _plan,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static SubscriptionItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubscriptionItemStruct(
        plan: deserializeStructParam(
          data['plan'],
          ParamType.DataStruct,
          false,
          structBuilder: SubscriptionPlanStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SubscriptionItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubscriptionItemStruct && plan == other.plan;
  }

  @override
  int get hashCode => const ListEquality().hash([plan]);
}

SubscriptionItemStruct createSubscriptionItemStruct({
  SubscriptionPlanStruct? plan,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubscriptionItemStruct(
      plan: plan ?? (clearUnsetFields ? SubscriptionPlanStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubscriptionItemStruct? updateSubscriptionItemStruct(
  SubscriptionItemStruct? subscriptionItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    subscriptionItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubscriptionItemStructData(
  Map<String, dynamic> firestoreData,
  SubscriptionItemStruct? subscriptionItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (subscriptionItem == null) {
    return;
  }
  if (subscriptionItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && subscriptionItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final subscriptionItemData =
      getSubscriptionItemFirestoreData(subscriptionItem, forFieldValue);
  final nestedData =
      subscriptionItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = subscriptionItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubscriptionItemFirestoreData(
  SubscriptionItemStruct? subscriptionItem, [
  bool forFieldValue = false,
]) {
  if (subscriptionItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(subscriptionItem.toMap());

  // Handle nested data for "plan" field.
  addSubscriptionPlanStructData(
    firestoreData,
    subscriptionItem.hasPlan() ? subscriptionItem.plan : null,
    'plan',
    forFieldValue,
  );

  // Add any Firestore field values
  subscriptionItem.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubscriptionItemListFirestoreData(
  List<SubscriptionItemStruct>? subscriptionItems,
) =>
    subscriptionItems
        ?.map((e) => getSubscriptionItemFirestoreData(e, true))
        .toList() ??
    [];
