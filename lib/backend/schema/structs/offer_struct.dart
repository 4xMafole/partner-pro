// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OfferStruct extends FFFirebaseStruct {
  OfferStruct({
    String? id,
    BuyerStruct? buyer,
    BuyerStruct? agent,
    BuyerStruct? seller,
    PropertyStruct? property,
    String? propertyId,
    int? purchasePrice,
    int? counteredCount,
    Status? status,
    DateTime? createdTime,
    String? sellerId,
    String? buyerId,
    String? propertyCondition,
    String? chatId,
    List<AddendumsStruct>? addendums,
    String? listPrice,
    String? finalPrice,
    String? loanType,
    int? downPaymentAmount,
    int? loanAmount,
    int? requestForSellerCredit,
    String? depositType,
    int? depositAmount,
    DateTime? closingDate,
    int? coverageAmount,
    TitleCompanyStruct? titleCompany,
    int? additionalEarnest,
    int? optionFee,
    bool? preApproval,
    bool? survey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _buyer = buyer,
        _agent = agent,
        _seller = seller,
        _property = property,
        _propertyId = propertyId,
        _purchasePrice = purchasePrice,
        _counteredCount = counteredCount,
        _status = status,
        _createdTime = createdTime,
        _sellerId = sellerId,
        _buyerId = buyerId,
        _propertyCondition = propertyCondition,
        _chatId = chatId,
        _addendums = addendums,
        _listPrice = listPrice,
        _finalPrice = finalPrice,
        _loanType = loanType,
        _downPaymentAmount = downPaymentAmount,
        _loanAmount = loanAmount,
        _requestForSellerCredit = requestForSellerCredit,
        _depositType = depositType,
        _depositAmount = depositAmount,
        _closingDate = closingDate,
        _coverageAmount = coverageAmount,
        _titleCompany = titleCompany,
        _additionalEarnest = additionalEarnest,
        _optionFee = optionFee,
        _preApproval = preApproval,
        _survey = survey,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "buyer" field.
  BuyerStruct? _buyer;
  BuyerStruct get buyer => _buyer ?? BuyerStruct();
  set buyer(BuyerStruct? val) => _buyer = val;

  void updateBuyer(Function(BuyerStruct) updateFn) {
    updateFn(_buyer ??= BuyerStruct());
  }

  bool hasBuyer() => _buyer != null;

  // "agent" field.
  BuyerStruct? _agent;
  BuyerStruct get agent => _agent ?? BuyerStruct();
  set agent(BuyerStruct? val) => _agent = val;

  void updateAgent(Function(BuyerStruct) updateFn) {
    updateFn(_agent ??= BuyerStruct());
  }

  bool hasAgent() => _agent != null;

  // "seller" field.
  BuyerStruct? _seller;
  BuyerStruct get seller => _seller ?? BuyerStruct();
  set seller(BuyerStruct? val) => _seller = val;

  void updateSeller(Function(BuyerStruct) updateFn) {
    updateFn(_seller ??= BuyerStruct());
  }

  bool hasSeller() => _seller != null;

  // "property" field.
  PropertyStruct? _property;
  PropertyStruct get property => _property ?? PropertyStruct();
  set property(PropertyStruct? val) => _property = val;

  void updateProperty(Function(PropertyStruct) updateFn) {
    updateFn(_property ??= PropertyStruct());
  }

  bool hasProperty() => _property != null;

  // "property_id" field.
  String? _propertyId;
  String get propertyId => _propertyId ?? '';
  set propertyId(String? val) => _propertyId = val;

  bool hasPropertyId() => _propertyId != null;

  // "purchase_price" field.
  int? _purchasePrice;
  int get purchasePrice => _purchasePrice ?? 0;
  set purchasePrice(int? val) => _purchasePrice = val;

  void incrementPurchasePrice(int amount) =>
      purchasePrice = purchasePrice + amount;

  bool hasPurchasePrice() => _purchasePrice != null;

  // "countered_count" field.
  int? _counteredCount;
  int get counteredCount => _counteredCount ?? 0;
  set counteredCount(int? val) => _counteredCount = val;

  void incrementCounteredCount(int amount) =>
      counteredCount = counteredCount + amount;

  bool hasCounteredCount() => _counteredCount != null;

  // "status" field.
  Status? _status;
  Status get status => _status ?? Status.Pending;
  set status(Status? val) => _status = val;

  bool hasStatus() => _status != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  set createdTime(DateTime? val) => _createdTime = val;

  bool hasCreatedTime() => _createdTime != null;

  // "seller_id" field.
  String? _sellerId;
  String get sellerId => _sellerId ?? '';
  set sellerId(String? val) => _sellerId = val;

  bool hasSellerId() => _sellerId != null;

  // "buyer_id" field.
  String? _buyerId;
  String get buyerId => _buyerId ?? '';
  set buyerId(String? val) => _buyerId = val;

  bool hasBuyerId() => _buyerId != null;

  // "property_condition" field.
  String? _propertyCondition;
  String get propertyCondition => _propertyCondition ?? '';
  set propertyCondition(String? val) => _propertyCondition = val;

  bool hasPropertyCondition() => _propertyCondition != null;

  // "chat_id" field.
  String? _chatId;
  String get chatId => _chatId ?? '';
  set chatId(String? val) => _chatId = val;

  bool hasChatId() => _chatId != null;

  // "addendums" field.
  List<AddendumsStruct>? _addendums;
  List<AddendumsStruct> get addendums => _addendums ?? const [];
  set addendums(List<AddendumsStruct>? val) => _addendums = val;

  void updateAddendums(Function(List<AddendumsStruct>) updateFn) {
    updateFn(_addendums ??= []);
  }

  bool hasAddendums() => _addendums != null;

  // "list_price" field.
  String? _listPrice;
  String get listPrice => _listPrice ?? '';
  set listPrice(String? val) => _listPrice = val;

  bool hasListPrice() => _listPrice != null;

  // "final_price" field.
  String? _finalPrice;
  String get finalPrice => _finalPrice ?? '';
  set finalPrice(String? val) => _finalPrice = val;

  bool hasFinalPrice() => _finalPrice != null;

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

  // "request_for_seller_credit" field.
  int? _requestForSellerCredit;
  int get requestForSellerCredit => _requestForSellerCredit ?? 0;
  set requestForSellerCredit(int? val) => _requestForSellerCredit = val;

  void incrementRequestForSellerCredit(int amount) =>
      requestForSellerCredit = requestForSellerCredit + amount;

  bool hasRequestForSellerCredit() => _requestForSellerCredit != null;

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

  // "closing_date" field.
  DateTime? _closingDate;
  DateTime? get closingDate => _closingDate;
  set closingDate(DateTime? val) => _closingDate = val;

  bool hasClosingDate() => _closingDate != null;

  // "coverage_amount" field.
  int? _coverageAmount;
  int get coverageAmount => _coverageAmount ?? 0;
  set coverageAmount(int? val) => _coverageAmount = val;

  void incrementCoverageAmount(int amount) =>
      coverageAmount = coverageAmount + amount;

  bool hasCoverageAmount() => _coverageAmount != null;

  // "title_company" field.
  TitleCompanyStruct? _titleCompany;
  TitleCompanyStruct get titleCompany => _titleCompany ?? TitleCompanyStruct();
  set titleCompany(TitleCompanyStruct? val) => _titleCompany = val;

  void updateTitleCompany(Function(TitleCompanyStruct) updateFn) {
    updateFn(_titleCompany ??= TitleCompanyStruct());
  }

  bool hasTitleCompany() => _titleCompany != null;

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

  // "pre_approval" field.
  bool? _preApproval;
  bool get preApproval => _preApproval ?? false;
  set preApproval(bool? val) => _preApproval = val;

  bool hasPreApproval() => _preApproval != null;

  // "survey" field.
  bool? _survey;
  bool get survey => _survey ?? false;
  set survey(bool? val) => _survey = val;

  bool hasSurvey() => _survey != null;

  static OfferStruct fromMap(Map<String, dynamic> data) => OfferStruct(
        id: data['id'] as String?,
        buyer: data['buyer'] is BuyerStruct
            ? data['buyer']
            : BuyerStruct.maybeFromMap(data['buyer']),
        agent: data['agent'] is BuyerStruct
            ? data['agent']
            : BuyerStruct.maybeFromMap(data['agent']),
        seller: data['seller'] is BuyerStruct
            ? data['seller']
            : BuyerStruct.maybeFromMap(data['seller']),
        property: data['property'] is PropertyStruct
            ? data['property']
            : PropertyStruct.maybeFromMap(data['property']),
        propertyId: data['property_id'] as String?,
        purchasePrice: castToType<int>(data['purchase_price']),
        counteredCount: castToType<int>(data['countered_count']),
        status: data['status'] is Status
            ? data['status']
            : deserializeEnum<Status>(data['status']),
        createdTime: data['created_time'] as DateTime?,
        sellerId: data['seller_id'] as String?,
        buyerId: data['buyer_id'] as String?,
        propertyCondition: data['property_condition'] as String?,
        chatId: data['chat_id'] as String?,
        addendums: getStructList(
          data['addendums'],
          AddendumsStruct.fromMap,
        ),
        listPrice: data['list_price'] as String?,
        finalPrice: data['final_price'] as String?,
        loanType: data['loan_type'] as String?,
        downPaymentAmount: castToType<int>(data['down_payment_amount']),
        loanAmount: castToType<int>(data['loan_amount']),
        requestForSellerCredit:
            castToType<int>(data['request_for_seller_credit']),
        depositType: data['deposit_type'] as String?,
        depositAmount: castToType<int>(data['deposit_amount']),
        closingDate: data['closing_date'] as DateTime?,
        coverageAmount: castToType<int>(data['coverage_amount']),
        titleCompany: data['title_company'] is TitleCompanyStruct
            ? data['title_company']
            : TitleCompanyStruct.maybeFromMap(data['title_company']),
        additionalEarnest: castToType<int>(data['additional_earnest']),
        optionFee: castToType<int>(data['option_fee']),
        preApproval: data['pre_approval'] as bool?,
        survey: data['survey'] as bool?,
      );

  static OfferStruct? maybeFromMap(dynamic data) =>
      data is Map ? OfferStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'buyer': _buyer?.toMap(),
        'agent': _agent?.toMap(),
        'seller': _seller?.toMap(),
        'property': _property?.toMap(),
        'property_id': _propertyId,
        'purchase_price': _purchasePrice,
        'countered_count': _counteredCount,
        'status': _status?.serialize(),
        'created_time': _createdTime,
        'seller_id': _sellerId,
        'buyer_id': _buyerId,
        'property_condition': _propertyCondition,
        'chat_id': _chatId,
        'addendums': _addendums?.map((e) => e.toMap()).toList(),
        'list_price': _listPrice,
        'final_price': _finalPrice,
        'loan_type': _loanType,
        'down_payment_amount': _downPaymentAmount,
        'loan_amount': _loanAmount,
        'request_for_seller_credit': _requestForSellerCredit,
        'deposit_type': _depositType,
        'deposit_amount': _depositAmount,
        'closing_date': _closingDate,
        'coverage_amount': _coverageAmount,
        'title_company': _titleCompany?.toMap(),
        'additional_earnest': _additionalEarnest,
        'option_fee': _optionFee,
        'pre_approval': _preApproval,
        'survey': _survey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'buyer': serializeParam(
          _buyer,
          ParamType.DataStruct,
        ),
        'agent': serializeParam(
          _agent,
          ParamType.DataStruct,
        ),
        'seller': serializeParam(
          _seller,
          ParamType.DataStruct,
        ),
        'property': serializeParam(
          _property,
          ParamType.DataStruct,
        ),
        'property_id': serializeParam(
          _propertyId,
          ParamType.String,
        ),
        'purchase_price': serializeParam(
          _purchasePrice,
          ParamType.int,
        ),
        'countered_count': serializeParam(
          _counteredCount,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
        'created_time': serializeParam(
          _createdTime,
          ParamType.DateTime,
        ),
        'seller_id': serializeParam(
          _sellerId,
          ParamType.String,
        ),
        'buyer_id': serializeParam(
          _buyerId,
          ParamType.String,
        ),
        'property_condition': serializeParam(
          _propertyCondition,
          ParamType.String,
        ),
        'chat_id': serializeParam(
          _chatId,
          ParamType.String,
        ),
        'addendums': serializeParam(
          _addendums,
          ParamType.DataStruct,
          isList: true,
        ),
        'list_price': serializeParam(
          _listPrice,
          ParamType.String,
        ),
        'final_price': serializeParam(
          _finalPrice,
          ParamType.String,
        ),
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
        'request_for_seller_credit': serializeParam(
          _requestForSellerCredit,
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
        'closing_date': serializeParam(
          _closingDate,
          ParamType.DateTime,
        ),
        'coverage_amount': serializeParam(
          _coverageAmount,
          ParamType.int,
        ),
        'title_company': serializeParam(
          _titleCompany,
          ParamType.DataStruct,
        ),
        'additional_earnest': serializeParam(
          _additionalEarnest,
          ParamType.int,
        ),
        'option_fee': serializeParam(
          _optionFee,
          ParamType.int,
        ),
        'pre_approval': serializeParam(
          _preApproval,
          ParamType.bool,
        ),
        'survey': serializeParam(
          _survey,
          ParamType.bool,
        ),
      }.withoutNulls;

  static OfferStruct fromSerializableMap(Map<String, dynamic> data) =>
      OfferStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        buyer: deserializeStructParam(
          data['buyer'],
          ParamType.DataStruct,
          false,
          structBuilder: BuyerStruct.fromSerializableMap,
        ),
        agent: deserializeStructParam(
          data['agent'],
          ParamType.DataStruct,
          false,
          structBuilder: BuyerStruct.fromSerializableMap,
        ),
        seller: deserializeStructParam(
          data['seller'],
          ParamType.DataStruct,
          false,
          structBuilder: BuyerStruct.fromSerializableMap,
        ),
        property: deserializeStructParam(
          data['property'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyStruct.fromSerializableMap,
        ),
        propertyId: deserializeParam(
          data['property_id'],
          ParamType.String,
          false,
        ),
        purchasePrice: deserializeParam(
          data['purchase_price'],
          ParamType.int,
          false,
        ),
        counteredCount: deserializeParam(
          data['countered_count'],
          ParamType.int,
          false,
        ),
        status: deserializeParam<Status>(
          data['status'],
          ParamType.Enum,
          false,
        ),
        createdTime: deserializeParam(
          data['created_time'],
          ParamType.DateTime,
          false,
        ),
        sellerId: deserializeParam(
          data['seller_id'],
          ParamType.String,
          false,
        ),
        buyerId: deserializeParam(
          data['buyer_id'],
          ParamType.String,
          false,
        ),
        propertyCondition: deserializeParam(
          data['property_condition'],
          ParamType.String,
          false,
        ),
        chatId: deserializeParam(
          data['chat_id'],
          ParamType.String,
          false,
        ),
        addendums: deserializeStructParam<AddendumsStruct>(
          data['addendums'],
          ParamType.DataStruct,
          true,
          structBuilder: AddendumsStruct.fromSerializableMap,
        ),
        listPrice: deserializeParam(
          data['list_price'],
          ParamType.String,
          false,
        ),
        finalPrice: deserializeParam(
          data['final_price'],
          ParamType.String,
          false,
        ),
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
        requestForSellerCredit: deserializeParam(
          data['request_for_seller_credit'],
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
        closingDate: deserializeParam(
          data['closing_date'],
          ParamType.DateTime,
          false,
        ),
        coverageAmount: deserializeParam(
          data['coverage_amount'],
          ParamType.int,
          false,
        ),
        titleCompany: deserializeStructParam(
          data['title_company'],
          ParamType.DataStruct,
          false,
          structBuilder: TitleCompanyStruct.fromSerializableMap,
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
        preApproval: deserializeParam(
          data['pre_approval'],
          ParamType.bool,
          false,
        ),
        survey: deserializeParam(
          data['survey'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'OfferStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OfferStruct &&
        id == other.id &&
        buyer == other.buyer &&
        agent == other.agent &&
        seller == other.seller &&
        property == other.property &&
        propertyId == other.propertyId &&
        purchasePrice == other.purchasePrice &&
        counteredCount == other.counteredCount &&
        status == other.status &&
        createdTime == other.createdTime &&
        sellerId == other.sellerId &&
        buyerId == other.buyerId &&
        propertyCondition == other.propertyCondition &&
        chatId == other.chatId &&
        listEquality.equals(addendums, other.addendums) &&
        listPrice == other.listPrice &&
        finalPrice == other.finalPrice &&
        loanType == other.loanType &&
        downPaymentAmount == other.downPaymentAmount &&
        loanAmount == other.loanAmount &&
        requestForSellerCredit == other.requestForSellerCredit &&
        depositType == other.depositType &&
        depositAmount == other.depositAmount &&
        closingDate == other.closingDate &&
        coverageAmount == other.coverageAmount &&
        titleCompany == other.titleCompany &&
        additionalEarnest == other.additionalEarnest &&
        optionFee == other.optionFee &&
        preApproval == other.preApproval &&
        survey == other.survey;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        buyer,
        agent,
        seller,
        property,
        propertyId,
        purchasePrice,
        counteredCount,
        status,
        createdTime,
        sellerId,
        buyerId,
        propertyCondition,
        chatId,
        addendums,
        listPrice,
        finalPrice,
        loanType,
        downPaymentAmount,
        loanAmount,
        requestForSellerCredit,
        depositType,
        depositAmount,
        closingDate,
        coverageAmount,
        titleCompany,
        additionalEarnest,
        optionFee,
        preApproval,
        survey
      ]);
}

OfferStruct createOfferStruct({
  String? id,
  BuyerStruct? buyer,
  BuyerStruct? agent,
  BuyerStruct? seller,
  PropertyStruct? property,
  String? propertyId,
  int? purchasePrice,
  int? counteredCount,
  Status? status,
  DateTime? createdTime,
  String? sellerId,
  String? buyerId,
  String? propertyCondition,
  String? chatId,
  String? listPrice,
  String? finalPrice,
  String? loanType,
  int? downPaymentAmount,
  int? loanAmount,
  int? requestForSellerCredit,
  String? depositType,
  int? depositAmount,
  DateTime? closingDate,
  int? coverageAmount,
  TitleCompanyStruct? titleCompany,
  int? additionalEarnest,
  int? optionFee,
  bool? preApproval,
  bool? survey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OfferStruct(
      id: id,
      buyer: buyer ?? (clearUnsetFields ? BuyerStruct() : null),
      agent: agent ?? (clearUnsetFields ? BuyerStruct() : null),
      seller: seller ?? (clearUnsetFields ? BuyerStruct() : null),
      property: property ?? (clearUnsetFields ? PropertyStruct() : null),
      propertyId: propertyId,
      purchasePrice: purchasePrice,
      counteredCount: counteredCount,
      status: status,
      createdTime: createdTime,
      sellerId: sellerId,
      buyerId: buyerId,
      propertyCondition: propertyCondition,
      chatId: chatId,
      listPrice: listPrice,
      finalPrice: finalPrice,
      loanType: loanType,
      downPaymentAmount: downPaymentAmount,
      loanAmount: loanAmount,
      requestForSellerCredit: requestForSellerCredit,
      depositType: depositType,
      depositAmount: depositAmount,
      closingDate: closingDate,
      coverageAmount: coverageAmount,
      titleCompany:
          titleCompany ?? (clearUnsetFields ? TitleCompanyStruct() : null),
      additionalEarnest: additionalEarnest,
      optionFee: optionFee,
      preApproval: preApproval,
      survey: survey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OfferStruct? updateOfferStruct(
  OfferStruct? offer, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    offer
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOfferStructData(
  Map<String, dynamic> firestoreData,
  OfferStruct? offer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (offer == null) {
    return;
  }
  if (offer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && offer.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final offerData = getOfferFirestoreData(offer, forFieldValue);
  final nestedData = offerData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = offer.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOfferFirestoreData(
  OfferStruct? offer, [
  bool forFieldValue = false,
]) {
  if (offer == null) {
    return {};
  }
  final firestoreData = mapToFirestore(offer.toMap());

  // Handle nested data for "buyer" field.
  addBuyerStructData(
    firestoreData,
    offer.hasBuyer() ? offer.buyer : null,
    'buyer',
    forFieldValue,
  );

  // Handle nested data for "agent" field.
  addBuyerStructData(
    firestoreData,
    offer.hasAgent() ? offer.agent : null,
    'agent',
    forFieldValue,
  );

  // Handle nested data for "seller" field.
  addBuyerStructData(
    firestoreData,
    offer.hasSeller() ? offer.seller : null,
    'seller',
    forFieldValue,
  );

  // Handle nested data for "property" field.
  addPropertyStructData(
    firestoreData,
    offer.hasProperty() ? offer.property : null,
    'property',
    forFieldValue,
  );

  // Handle nested data for "title_company" field.
  addTitleCompanyStructData(
    firestoreData,
    offer.hasTitleCompany() ? offer.titleCompany : null,
    'title_company',
    forFieldValue,
  );

  // Add any Firestore field values
  offer.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOfferListFirestoreData(
  List<OfferStruct>? offers,
) =>
    offers?.map((e) => getOfferFirestoreData(e, true)).toList() ?? [];
