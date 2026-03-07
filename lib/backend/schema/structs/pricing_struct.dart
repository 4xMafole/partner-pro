// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PricingStruct extends FFFirebaseStruct {
  PricingStruct({
    int? listPrice,
    int? purchasePrice,
    int? finalPrice,
    int? counteredCount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _listPrice = listPrice,
        _purchasePrice = purchasePrice,
        _finalPrice = finalPrice,
        _counteredCount = counteredCount,
        super(firestoreUtilData);

  // "list_price" field.
  int? _listPrice;
  int get listPrice => _listPrice ?? 0;
  set listPrice(int? val) => _listPrice = val;

  void incrementListPrice(int amount) => listPrice = listPrice + amount;

  bool hasListPrice() => _listPrice != null;

  // "purchase_price" field.
  int? _purchasePrice;
  int get purchasePrice => _purchasePrice ?? 0;
  set purchasePrice(int? val) => _purchasePrice = val;

  void incrementPurchasePrice(int amount) =>
      purchasePrice = purchasePrice + amount;

  bool hasPurchasePrice() => _purchasePrice != null;

  // "final_price" field.
  int? _finalPrice;
  int get finalPrice => _finalPrice ?? 0;
  set finalPrice(int? val) => _finalPrice = val;

  void incrementFinalPrice(int amount) => finalPrice = finalPrice + amount;

  bool hasFinalPrice() => _finalPrice != null;

  // "countered_count" field.
  int? _counteredCount;
  int get counteredCount => _counteredCount ?? 0;
  set counteredCount(int? val) => _counteredCount = val;

  void incrementCounteredCount(int amount) =>
      counteredCount = counteredCount + amount;

  bool hasCounteredCount() => _counteredCount != null;

  static PricingStruct fromMap(Map<String, dynamic> data) => PricingStruct(
        listPrice: castToType<int>(data['list_price']),
        purchasePrice: castToType<int>(data['purchase_price']),
        finalPrice: castToType<int>(data['final_price']),
        counteredCount: castToType<int>(data['countered_count']),
      );

  static PricingStruct? maybeFromMap(dynamic data) =>
      data is Map ? PricingStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'list_price': _listPrice,
        'purchase_price': _purchasePrice,
        'final_price': _finalPrice,
        'countered_count': _counteredCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'list_price': serializeParam(
          _listPrice,
          ParamType.int,
        ),
        'purchase_price': serializeParam(
          _purchasePrice,
          ParamType.int,
        ),
        'final_price': serializeParam(
          _finalPrice,
          ParamType.int,
        ),
        'countered_count': serializeParam(
          _counteredCount,
          ParamType.int,
        ),
      }.withoutNulls;

  static PricingStruct fromSerializableMap(Map<String, dynamic> data) =>
      PricingStruct(
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.int,
          false,
        ),
        purchasePrice: deserializeParam(
          data['purchase_price'],
          ParamType.int,
          false,
        ),
        finalPrice: deserializeParam(
          data['final_price'],
          ParamType.int,
          false,
        ),
        counteredCount: deserializeParam(
          data['countered_count'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PricingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PricingStruct &&
        listPrice == other.listPrice &&
        purchasePrice == other.purchasePrice &&
        finalPrice == other.finalPrice &&
        counteredCount == other.counteredCount;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([listPrice, purchasePrice, finalPrice, counteredCount]);
}

PricingStruct createPricingStruct({
  int? listPrice,
  int? purchasePrice,
  int? finalPrice,
  int? counteredCount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PricingStruct(
      listPrice: listPrice,
      purchasePrice: purchasePrice,
      finalPrice: finalPrice,
      counteredCount: counteredCount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PricingStruct? updatePricingStruct(
  PricingStruct? pricing, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pricing
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPricingStructData(
  Map<String, dynamic> firestoreData,
  PricingStruct? pricing,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pricing == null) {
    return;
  }
  if (pricing.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pricing.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pricingData = getPricingFirestoreData(pricing, forFieldValue);
  final nestedData = pricingData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pricing.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPricingFirestoreData(
  PricingStruct? pricing, [
  bool forFieldValue = false,
]) {
  if (pricing == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pricing.toMap());

  // Add any Firestore field values
  pricing.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPricingListFirestoreData(
  List<PricingStruct>? pricings,
) =>
    pricings?.map((e) => getPricingFirestoreData(e, true)).toList() ?? [];
