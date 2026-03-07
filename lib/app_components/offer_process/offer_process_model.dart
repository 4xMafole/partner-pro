import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/downpayment_component/downpayment_component_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/stripe/payment_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'offer_process_widget.dart' show OfferProcessWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class OfferProcessModel extends FlutterFlowModel<OfferProcessWidget> {
  ///  Local state fields for this component.

  bool? isShowDetails = true;

  bool isBuyerAdded = true;

  String downPaymentType = 'Select a down payment type';

  String downPaymentTypePercentage = '0';

  double? loanAmount;

  double? downPaymentAmount;

  String? purchasePrice;

  String? creditRequest;

  DateTime? closingDate;

  String? coverageAmount;

  String? additionalEarnest;

  String? optionFee;

  double? depositAmount;

  NewOfferStruct? newOfferData;
  void updateNewOfferDataStruct(Function(NewOfferStruct) updateFn) {
    updateFn(newOfferData ??= NewOfferStruct());
  }

  EmailProviderStruct? emailProvider;
  void updateEmailProviderStruct(Function(EmailProviderStruct) updateFn) {
    updateFn(emailProvider ??= EmailProviderStruct());
  }

  String? fullName;

  SMSProviderStruct? smsProvider;
  void updateSmsProviderStruct(Function(SMSProviderStruct) updateFn) {
    updateFn(smsProvider ??= SMSProviderStruct());
  }

  NewOfferStruct? localOffer;
  void updateLocalOfferStruct(Function(NewOfferStruct) updateFn) {
    updateFn(localOffer ??= NewOfferStruct());
  }

  int closingDays = 0;

  bool hasSecondBuyer = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for firstBuyersName widget.
  FocusNode? firstBuyersNameFocusNode;
  TextEditingController? firstBuyersNameTextController;
  String? Function(BuildContext, String?)?
      firstBuyersNameTextControllerValidator;
  String? _firstBuyersNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for lastBuyersName widget.
  FocusNode? lastBuyersNameFocusNode;
  TextEditingController? lastBuyersNameTextController;
  String? Function(BuildContext, String?)?
      lastBuyersNameTextControllerValidator;
  String? _lastBuyersNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for buyersPhone widget.
  FocusNode? buyersPhoneFocusNode;
  TextEditingController? buyersPhoneTextController;
  late MaskTextInputFormatter buyersPhoneMask;
  String? Function(BuildContext, String?)? buyersPhoneTextControllerValidator;
  String? _buyersPhoneTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for buyersEmail widget.
  FocusNode? buyersEmailFocusNode;
  TextEditingController? buyersEmailTextController;
  String? Function(BuildContext, String?)? buyersEmailTextControllerValidator;
  String? _buyersEmailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for secondBuyerName widget.
  FocusNode? secondBuyerNameFocusNode;
  TextEditingController? secondBuyerNameTextController;
  String? Function(BuildContext, String?)?
      secondBuyerNameTextControllerValidator;
  // State field(s) for secondBuyerLastName widget.
  FocusNode? secondBuyerLastNameFocusNode;
  TextEditingController? secondBuyerLastNameTextController;
  String? Function(BuildContext, String?)?
      secondBuyerLastNameTextControllerValidator;
  // State field(s) for secondBuyerPhone widget.
  FocusNode? secondBuyerPhoneFocusNode;
  TextEditingController? secondBuyerPhoneTextController;
  late MaskTextInputFormatter secondBuyerPhoneMask;
  String? Function(BuildContext, String?)?
      secondBuyerPhoneTextControllerValidator;
  // State field(s) for secondBuyerEmail widget.
  FocusNode? secondBuyerEmailFocusNode;
  TextEditingController? secondBuyerEmailTextController;
  String? Function(BuildContext, String?)?
      secondBuyerEmailTextControllerValidator;
  // State field(s) for depositDropDown widget.
  String? depositDropDownValue;
  FormFieldController<String>? depositDropDownValueController;
  // State field(s) for closingDays widget.
  FocusNode? closingDaysFocusNode;
  TextEditingController? closingDaysTextController;
  String? Function(BuildContext, String?)? closingDaysTextControllerValidator;
  DateTime? datePicked;
  // State field(s) for propertyConditionRadioButton widget.
  FormFieldController<String>? propertyConditionRadioButtonValueController;
  // State field(s) for preApprovalRadio widget.
  FormFieldController<String>? preApprovalRadioValueController;
  // State field(s) for surveyRadio widget.
  FormFieldController<String>? surveyRadioValueController;
  // State field(s) for TitileCompanyName widget.
  FocusNode? titileCompanyNameFocusNode;
  TextEditingController? titileCompanyNameTextController;
  String? Function(BuildContext, String?)?
      titileCompanyNameTextControllerValidator;
  // State field(s) for choiceRadioButton widget.
  FormFieldController<String>? choiceRadioButtonValueController;
  // Stores action output result for [Custom Action - compareOffers] action in makeOfferButton widget.
  bool? hasOfferChanged;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  RelationshipsRecord? clientRelationDoc0;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  UsersRecord? agentDoc0;
  // Stores action output result for [Backend Call - API (insertOffer)] action in makeOfferButton widget.
  ApiCallResponse? offerCreated;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  RelationshipsRecord? clientRelationDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  UsersRecord? agentDoc;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? creationBuyerToAgent;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in makeOfferButton widget.
  String? creationBuyerToAgentSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? postEmail13j12;
  // Stores action output result for [Backend Call - API (postSMS)] action in makeOfferButton widget.
  ApiCallResponse? postSms13j12;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  RelationshipsRecord? agentRelationDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  UsersRecord? clientDoc;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? creationAgentToBuyer;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in makeOfferButton widget.
  String? creationAgentToBuyerSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? apiResulte4h;
  // Stores action output result for [Backend Call - API (postSMS)] action in makeOfferButton widget.
  ApiCallResponse? postSms13j134;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? creationToTC;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? postEmail13j;
  // Stores action output result for [Backend Call - API (updateOfferById)] action in makeOfferButton widget.
  ApiCallResponse? revisedOffer;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  RelationshipsRecord? clientRelationDoc1;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  UsersRecord? agentDoc1;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? updateBuyerToAgent;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in makeOfferButton widget.
  String? updateBuyerToAgentSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? postEmail13j121;
  // Stores action output result for [Backend Call - API (postSMS)] action in makeOfferButton widget.
  ApiCallResponse? postSms13j134f4;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  RelationshipsRecord? agentRelationDoc1;
  // Stores action output result for [Firestore Query - Query a collection] action in makeOfferButton widget.
  UsersRecord? clientDoc1;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? updateAgentToBuyer;
  // Stores action output result for [Custom Action - generateOfferSMSContent] action in makeOfferButton widget.
  String? updateAgentToBuyerSMS;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? apiResulte4h1;
  // Stores action output result for [Backend Call - API (postSMS)] action in makeOfferButton widget.
  ApiCallResponse? postSms13j134f4n43kj;
  // Stores action output result for [Custom Action - generateOfferEmailNotification] action in makeOfferButton widget.
  String? updateToTC;
  // Stores action output result for [Backend Call - API (postEmail)] action in makeOfferButton widget.
  ApiCallResponse? postEmail13j1;
  // Stores action output result for [Stripe Payment] action in unlockButton widget.
  String? stripePaymentID;
  // Stores action output result for [Backend Call - Create Document] action in unlockButton widget.
  OfferPaymentsRecord? offerPaymentDoc;

  @override
  void initState(BuildContext context) {
    firstBuyersNameTextControllerValidator =
        _firstBuyersNameTextControllerValidator;
    lastBuyersNameTextControllerValidator =
        _lastBuyersNameTextControllerValidator;
    buyersPhoneTextControllerValidator = _buyersPhoneTextControllerValidator;
    buyersEmailTextControllerValidator = _buyersEmailTextControllerValidator;
  }

  @override
  void dispose() {
    firstBuyersNameFocusNode?.dispose();
    firstBuyersNameTextController?.dispose();

    lastBuyersNameFocusNode?.dispose();
    lastBuyersNameTextController?.dispose();

    buyersPhoneFocusNode?.dispose();
    buyersPhoneTextController?.dispose();

    buyersEmailFocusNode?.dispose();
    buyersEmailTextController?.dispose();

    secondBuyerNameFocusNode?.dispose();
    secondBuyerNameTextController?.dispose();

    secondBuyerLastNameFocusNode?.dispose();
    secondBuyerLastNameTextController?.dispose();

    secondBuyerPhoneFocusNode?.dispose();
    secondBuyerPhoneTextController?.dispose();

    secondBuyerEmailFocusNode?.dispose();
    secondBuyerEmailTextController?.dispose();

    closingDaysFocusNode?.dispose();
    closingDaysTextController?.dispose();

    titileCompanyNameFocusNode?.dispose();
    titileCompanyNameTextController?.dispose();
  }

  /// Additional helper methods.
  String? get propertyConditionRadioButtonValue =>
      propertyConditionRadioButtonValueController?.value;
  String? get preApprovalRadioValue => preApprovalRadioValueController?.value;
  String? get surveyRadioValue => surveyRadioValueController?.value;
  String? get choiceRadioButtonValue => choiceRadioButtonValueController?.value;
}
