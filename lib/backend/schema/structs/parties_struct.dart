// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PartiesStruct extends FFFirebaseStruct {
  PartiesStruct({
    SellerStruct? seller,
    NewBuyerStruct? buyer,
    SecondBuyerStruct? agent,
    SecondBuyerStruct? secondBuyer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _seller = seller,
        _buyer = buyer,
        _agent = agent,
        _secondBuyer = secondBuyer,
        super(firestoreUtilData);

  // "seller" field.
  SellerStruct? _seller;
  SellerStruct get seller => _seller ?? SellerStruct();
  set seller(SellerStruct? val) => _seller = val;

  void updateSeller(Function(SellerStruct) updateFn) {
    updateFn(_seller ??= SellerStruct());
  }

  bool hasSeller() => _seller != null;

  // "buyer" field.
  NewBuyerStruct? _buyer;
  NewBuyerStruct get buyer => _buyer ?? NewBuyerStruct();
  set buyer(NewBuyerStruct? val) => _buyer = val;

  void updateBuyer(Function(NewBuyerStruct) updateFn) {
    updateFn(_buyer ??= NewBuyerStruct());
  }

  bool hasBuyer() => _buyer != null;

  // "agent" field.
  SecondBuyerStruct? _agent;
  SecondBuyerStruct get agent => _agent ?? SecondBuyerStruct();
  set agent(SecondBuyerStruct? val) => _agent = val;

  void updateAgent(Function(SecondBuyerStruct) updateFn) {
    updateFn(_agent ??= SecondBuyerStruct());
  }

  bool hasAgent() => _agent != null;

  // "second_buyer" field.
  SecondBuyerStruct? _secondBuyer;
  SecondBuyerStruct get secondBuyer => _secondBuyer ?? SecondBuyerStruct();
  set secondBuyer(SecondBuyerStruct? val) => _secondBuyer = val;

  void updateSecondBuyer(Function(SecondBuyerStruct) updateFn) {
    updateFn(_secondBuyer ??= SecondBuyerStruct());
  }

  bool hasSecondBuyer() => _secondBuyer != null;

  static PartiesStruct fromMap(Map<String, dynamic> data) => PartiesStruct(
        seller: data['seller'] is SellerStruct
            ? data['seller']
            : SellerStruct.maybeFromMap(data['seller']),
        buyer: data['buyer'] is NewBuyerStruct
            ? data['buyer']
            : NewBuyerStruct.maybeFromMap(data['buyer']),
        agent: data['agent'] is SecondBuyerStruct
            ? data['agent']
            : SecondBuyerStruct.maybeFromMap(data['agent']),
        secondBuyer: data['second_buyer'] is SecondBuyerStruct
            ? data['second_buyer']
            : SecondBuyerStruct.maybeFromMap(data['second_buyer']),
      );

  static PartiesStruct? maybeFromMap(dynamic data) =>
      data is Map ? PartiesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'seller': _seller?.toMap(),
        'buyer': _buyer?.toMap(),
        'agent': _agent?.toMap(),
        'second_buyer': _secondBuyer?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'seller': serializeParam(
          _seller,
          ParamType.DataStruct,
        ),
        'buyer': serializeParam(
          _buyer,
          ParamType.DataStruct,
        ),
        'agent': serializeParam(
          _agent,
          ParamType.DataStruct,
        ),
        'second_buyer': serializeParam(
          _secondBuyer,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static PartiesStruct fromSerializableMap(Map<String, dynamic> data) =>
      PartiesStruct(
        seller: deserializeStructParam(
          data['seller'],
          ParamType.DataStruct,
          false,
          structBuilder: SellerStruct.fromSerializableMap,
        ),
        buyer: deserializeStructParam(
          data['buyer'],
          ParamType.DataStruct,
          false,
          structBuilder: NewBuyerStruct.fromSerializableMap,
        ),
        agent: deserializeStructParam(
          data['agent'],
          ParamType.DataStruct,
          false,
          structBuilder: SecondBuyerStruct.fromSerializableMap,
        ),
        secondBuyer: deserializeStructParam(
          data['second_buyer'],
          ParamType.DataStruct,
          false,
          structBuilder: SecondBuyerStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PartiesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PartiesStruct &&
        seller == other.seller &&
        buyer == other.buyer &&
        agent == other.agent &&
        secondBuyer == other.secondBuyer;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([seller, buyer, agent, secondBuyer]);
}

PartiesStruct createPartiesStruct({
  SellerStruct? seller,
  NewBuyerStruct? buyer,
  SecondBuyerStruct? agent,
  SecondBuyerStruct? secondBuyer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PartiesStruct(
      seller: seller ?? (clearUnsetFields ? SellerStruct() : null),
      buyer: buyer ?? (clearUnsetFields ? NewBuyerStruct() : null),
      agent: agent ?? (clearUnsetFields ? SecondBuyerStruct() : null),
      secondBuyer:
          secondBuyer ?? (clearUnsetFields ? SecondBuyerStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PartiesStruct? updatePartiesStruct(
  PartiesStruct? parties, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    parties
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPartiesStructData(
  Map<String, dynamic> firestoreData,
  PartiesStruct? parties,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (parties == null) {
    return;
  }
  if (parties.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && parties.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final partiesData = getPartiesFirestoreData(parties, forFieldValue);
  final nestedData = partiesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = parties.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPartiesFirestoreData(
  PartiesStruct? parties, [
  bool forFieldValue = false,
]) {
  if (parties == null) {
    return {};
  }
  final firestoreData = mapToFirestore(parties.toMap());

  // Handle nested data for "seller" field.
  addSellerStructData(
    firestoreData,
    parties.hasSeller() ? parties.seller : null,
    'seller',
    forFieldValue,
  );

  // Handle nested data for "buyer" field.
  addNewBuyerStructData(
    firestoreData,
    parties.hasBuyer() ? parties.buyer : null,
    'buyer',
    forFieldValue,
  );

  // Handle nested data for "agent" field.
  addSecondBuyerStructData(
    firestoreData,
    parties.hasAgent() ? parties.agent : null,
    'agent',
    forFieldValue,
  );

  // Handle nested data for "second_buyer" field.
  addSecondBuyerStructData(
    firestoreData,
    parties.hasSecondBuyer() ? parties.secondBuyer : null,
    'second_buyer',
    forFieldValue,
  );

  // Add any Firestore field values
  parties.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPartiesListFirestoreData(
  List<PartiesStruct>? partiess,
) =>
    partiess?.map((e) => getPartiesFirestoreData(e, true)).toList() ?? [];
