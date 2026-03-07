// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FinancialsStruct extends FFFirebaseStruct {
  FinancialsStruct({
    String? loanType,
    int? downPaymentAmount,
    int? loanAmount,
    int? creditRequest,
    String? depositType,
    int? depositAmount,
    int? additionalEarnest,
    int? optionFee,
    int? coverageAmount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _loanType = loanType,
        _downPaymentAmount = downPaymentAmount,
        _loanAmount = loanAmount,
        _creditRequest = creditRequest,
        _depositType = depositType,
        _depositAmount = depositAmount,
        _additionalEarnest = additionalEarnest,
        _optionFee = optionFee,
        _coverageAmount = coverageAmount,
        super(firestoreUtilData);

  // "loan_type" field.
  String? _loanType;
  String get loanType => _loanType ?? '';
  set loanType(String? val) => _loanType = val;

  bool hasLoanType() => _loanType != null;

  // "down_payment_amount" field.
  int? _downPaymentAmount;
  int get downPaymentAmount => _downPaymentAmount ?? 0;
  set downPaymentAmount(int? val) => _downPaymentAmount = val;

  void incrementDownPaymentAmount(int amount) =>
      downPaymentAmount = downPaymentAmount + amount;

  bool hasDownPaymentAmount() => _downPaymentAmount != null;

  // "loan_amount" field.
  int? _loanAmount;
  int get loanAmount => _loanAmount ?? 0;
  set loanAmount(int? val) => _loanAmount = val;

  void incrementLoanAmount(int amount) => loanAmount = loanAmount + amount;

  bool hasLoanAmount() => _loanAmount != null;

  // "credit_request" field.
  int? _creditRequest;
  int get creditRequest => _creditRequest ?? 0;
  set creditRequest(int? val) => _creditRequest = val;

  void incrementCreditRequest(int amount) =>
      creditRequest = creditRequest + amount;

  bool hasCreditRequest() => _creditRequest != null;

  // "deposit_type" field.
  String? _depositType;
  String get depositType => _depositType ?? '';
  set depositType(String? val) => _depositType = val;

  bool hasDepositType() => _depositType != null;

  // "deposit_amount" field.
  int? _depositAmount;
  int get depositAmount => _depositAmount ?? 0;
  set depositAmount(int? val) => _depositAmount = val;

  void incrementDepositAmount(int amount) =>
      depositAmount = depositAmount + amount;

  bool hasDepositAmount() => _depositAmount != null;

  // "additional_earnest" field.
  int? _additionalEarnest;
  int get additionalEarnest => _additionalEarnest ?? 0;
  set additionalEarnest(int? val) => _additionalEarnest = val;

  void incrementAdditionalEarnest(int amount) =>
      additionalEarnest = additionalEarnest + amount;

  bool hasAdditionalEarnest() => _additionalEarnest != null;

  // "option_fee" field.
  int? _optionFee;
  int get optionFee => _optionFee ?? 0;
  set optionFee(int? val) => _optionFee = val;

  void incrementOptionFee(int amount) => optionFee = optionFee + amount;

  bool hasOptionFee() => _optionFee != null;

  // "coverage_amount" field.
  int? _coverageAmount;
  int get coverageAmount => _coverageAmount ?? 0;
  set coverageAmount(int? val) => _coverageAmount = val;

  void incrementCoverageAmount(int amount) =>
      coverageAmount = coverageAmount + amount;

  bool hasCoverageAmount() => _coverageAmount != null;

  static FinancialsStruct fromMap(Map<String, dynamic> data) =>
      FinancialsStruct(
        loanType: data['loan_type'] as String?,
        downPaymentAmount: castToType<int>(data['down_payment_amount']),
        loanAmount: castToType<int>(data['loan_amount']),
        creditRequest: castToType<int>(data['credit_request']),
        depositType: data['deposit_type'] as String?,
        depositAmount: castToType<int>(data['deposit_amount']),
        additionalEarnest: castToType<int>(data['additional_earnest']),
        optionFee: castToType<int>(data['option_fee']),
        coverageAmount: castToType<int>(data['coverage_amount']),
      );

  static FinancialsStruct? maybeFromMap(dynamic data) => data is Map
      ? FinancialsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'loan_type': _loanType,
        'down_payment_amount': _downPaymentAmount,
        'loan_amount': _loanAmount,
        'credit_request': _creditRequest,
        'deposit_type': _depositType,
        'deposit_amount': _depositAmount,
        'additional_earnest': _additionalEarnest,
        'option_fee': _optionFee,
        'coverage_amount': _coverageAmount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'loan_type': serializeParam(
          _loanType,
          ParamType.String,
        ),
        'down_payment_amount': serializeParam(
          _downPaymentAmount,
          ParamType.int,
        ),
        'loan_amount': serializeParam(
          _loanAmount,
          ParamType.int,
        ),
        'credit_request': serializeParam(
          _creditRequest,
          ParamType.int,
        ),
        'deposit_type': serializeParam(
          _depositType,
          ParamType.String,
        ),
        'deposit_amount': serializeParam(
          _depositAmount,
          ParamType.int,
        ),
        'additional_earnest': serializeParam(
          _additionalEarnest,
          ParamType.int,
        ),
        'option_fee': serializeParam(
          _optionFee,
          ParamType.int,
        ),
        'coverage_amount': serializeParam(
          _coverageAmount,
          ParamType.int,
        ),
      }.withoutNulls;

  static FinancialsStruct fromSerializableMap(Map<String, dynamic> data) =>
      FinancialsStruct(
        loanType: deserializeParam(
          data['loan_type'],
          ParamType.String,
          false,
        ),
        downPaymentAmount: deserializeParam(
          data['down_payment_amount'],
          ParamType.int,
          false,
        ),
        loanAmount: deserializeParam(
          data['loan_amount'],
          ParamType.int,
          false,
        ),
        creditRequest: deserializeParam(
          data['credit_request'],
          ParamType.int,
          false,
        ),
        depositType: deserializeParam(
          data['deposit_type'],
          ParamType.String,
          false,
        ),
        depositAmount: deserializeParam(
          data['deposit_amount'],
          ParamType.int,
          false,
        ),
        additionalEarnest: deserializeParam(
          data['additional_earnest'],
          ParamType.int,
          false,
        ),
        optionFee: deserializeParam(
          data['option_fee'],
          ParamType.int,
          false,
        ),
        coverageAmount: deserializeParam(
          data['coverage_amount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'FinancialsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FinancialsStruct &&
        loanType == other.loanType &&
        downPaymentAmount == other.downPaymentAmount &&
        loanAmount == other.loanAmount &&
        creditRequest == other.creditRequest &&
        depositType == other.depositType &&
        depositAmount == other.depositAmount &&
        additionalEarnest == other.additionalEarnest &&
        optionFee == other.optionFee &&
        coverageAmount == other.coverageAmount;
  }

  @override
  int get hashCode => const ListEquality().hash([
        loanType,
        downPaymentAmount,
        loanAmount,
        creditRequest,
        depositType,
        depositAmount,
        additionalEarnest,
        optionFee,
        coverageAmount
      ]);
}

FinancialsStruct createFinancialsStruct({
  String? loanType,
  int? downPaymentAmount,
  int? loanAmount,
  int? creditRequest,
  String? depositType,
  int? depositAmount,
  int? additionalEarnest,
  int? optionFee,
  int? coverageAmount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FinancialsStruct(
      loanType: loanType,
      downPaymentAmount: downPaymentAmount,
      loanAmount: loanAmount,
      creditRequest: creditRequest,
      depositType: depositType,
      depositAmount: depositAmount,
      additionalEarnest: additionalEarnest,
      optionFee: optionFee,
      coverageAmount: coverageAmount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FinancialsStruct? updateFinancialsStruct(
  FinancialsStruct? financials, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    financials
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFinancialsStructData(
  Map<String, dynamic> firestoreData,
  FinancialsStruct? financials,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (financials == null) {
    return;
  }
  if (financials.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && financials.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final financialsData = getFinancialsFirestoreData(financials, forFieldValue);
  final nestedData = financialsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = financials.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFinancialsFirestoreData(
  FinancialsStruct? financials, [
  bool forFieldValue = false,
]) {
  if (financials == null) {
    return {};
  }
  final firestoreData = mapToFirestore(financials.toMap());

  // Add any Firestore field values
  financials.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFinancialsListFirestoreData(
  List<FinancialsStruct>? financialss,
) =>
    financialss?.map((e) => getFinancialsFirestoreData(e, true)).toList() ?? [];
