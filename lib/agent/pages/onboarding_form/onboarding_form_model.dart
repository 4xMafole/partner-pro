import '/agent/components/app_logo/app_logo_widget.dart';
import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'onboarding_form_widget.dart' show OnboardingFormWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingFormModel extends FlutterFlowModel<OnboardingFormWidget> {
  ///  Local state fields for this page.

  CredentialsStruct? credentials;
  void updateCredentialsStruct(Function(CredentialsStruct) updateFn) {
    updateFn(credentials ??= CredentialsStruct());
  }

  bool isNewOnboarding = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (getAgentById)] action in onboarding_form widget.
  ApiCallResponse? apiResult64z;
  // Model for app_logo component.
  late AppLogoModel appLogoModel;
  // State field(s) for brokerageName widget.
  FocusNode? brokerageNameFocusNode;
  TextEditingController? brokerageNameTextController;
  String? Function(BuildContext, String?)? brokerageNameTextControllerValidator;
  // State field(s) for brokerageLicenseNo widget.
  FocusNode? brokerageLicenseNoFocusNode;
  TextEditingController? brokerageLicenseNoTextController;
  String? Function(BuildContext, String?)?
      brokerageLicenseNoTextControllerValidator;
  // State field(s) for brokerageAddress widget.
  FocusNode? brokerageAddressFocusNode;
  TextEditingController? brokerageAddressTextController;
  String? Function(BuildContext, String?)?
      brokerageAddressTextControllerValidator;
  // State field(s) for brokeragePhonenumber widget.
  FocusNode? brokeragePhonenumberFocusNode;
  TextEditingController? brokeragePhonenumberTextController;
  String? Function(BuildContext, String?)?
      brokeragePhonenumberTextControllerValidator;
  // State field(s) for agentLicenseNo widget.
  FocusNode? agentLicenseNoFocusNode;
  TextEditingController? agentLicenseNoTextController;
  String? Function(BuildContext, String?)?
      agentLicenseNoTextControllerValidator;
  // State field(s) for webEmailAddress widget.
  FocusNode? webEmailAddressFocusNode;
  TextEditingController? webEmailAddressTextController;
  String? Function(BuildContext, String?)?
      webEmailAddressTextControllerValidator;
  // State field(s) for webPassword widget.
  FocusNode? webPasswordFocusNode;
  TextEditingController? webPasswordTextController;
  late bool webPasswordVisibility;
  String? Function(BuildContext, String?)? webPasswordTextControllerValidator;
  // State field(s) for formNameAddress widget.
  FocusNode? formNameAddressFocusNode;
  TextEditingController? formNameAddressTextController;
  String? Function(BuildContext, String?)?
      formNameAddressTextControllerValidator;
  // State field(s) for formEmailAddress widget.
  FocusNode? formEmailAddressFocusNode;
  TextEditingController? formEmailAddressTextController;
  String? Function(BuildContext, String?)?
      formEmailAddressTextControllerValidator;
  // State field(s) for formPassword widget.
  FocusNode? formPasswordFocusNode;
  TextEditingController? formPasswordTextController;
  late bool formPasswordVisibility;
  String? Function(BuildContext, String?)? formPasswordTextControllerValidator;
  // State field(s) for mlsNameAddress widget.
  FocusNode? mlsNameAddressFocusNode;
  TextEditingController? mlsNameAddressTextController;
  String? Function(BuildContext, String?)?
      mlsNameAddressTextControllerValidator;
  // State field(s) for mlsEmailAddress widget.
  FocusNode? mlsEmailAddressFocusNode;
  TextEditingController? mlsEmailAddressTextController;
  String? Function(BuildContext, String?)?
      mlsEmailAddressTextControllerValidator;
  // State field(s) for mlsPassword widget.
  FocusNode? mlsPasswordFocusNode;
  TextEditingController? mlsPasswordTextController;
  late bool mlsPasswordVisibility;
  String? Function(BuildContext, String?)? mlsPasswordTextControllerValidator;
  // State field(s) for crmDropDown widget.
  String? crmDropDownValue;
  FormFieldController<String>? crmDropDownValueController;
  // State field(s) for crmEmailAddress widget.
  FocusNode? crmEmailAddressFocusNode;
  TextEditingController? crmEmailAddressTextController;
  String? Function(BuildContext, String?)?
      crmEmailAddressTextControllerValidator;
  // State field(s) for crmPassword widget.
  FocusNode? crmPasswordFocusNode;
  TextEditingController? crmPasswordTextController;
  late bool crmPasswordVisibility;
  String? Function(BuildContext, String?)? crmPasswordTextControllerValidator;
  // Stores action output result for [Backend Call - API (createAgent)] action in Button widget.
  ApiCallResponse? apiCredentials;

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
    webPasswordVisibility = false;
    formPasswordVisibility = false;
    mlsPasswordVisibility = false;
    crmPasswordVisibility = false;
  }

  @override
  void dispose() {
    appLogoModel.dispose();
    brokerageNameFocusNode?.dispose();
    brokerageNameTextController?.dispose();

    brokerageLicenseNoFocusNode?.dispose();
    brokerageLicenseNoTextController?.dispose();

    brokerageAddressFocusNode?.dispose();
    brokerageAddressTextController?.dispose();

    brokeragePhonenumberFocusNode?.dispose();
    brokeragePhonenumberTextController?.dispose();

    agentLicenseNoFocusNode?.dispose();
    agentLicenseNoTextController?.dispose();

    webEmailAddressFocusNode?.dispose();
    webEmailAddressTextController?.dispose();

    webPasswordFocusNode?.dispose();
    webPasswordTextController?.dispose();

    formNameAddressFocusNode?.dispose();
    formNameAddressTextController?.dispose();

    formEmailAddressFocusNode?.dispose();
    formEmailAddressTextController?.dispose();

    formPasswordFocusNode?.dispose();
    formPasswordTextController?.dispose();

    mlsNameAddressFocusNode?.dispose();
    mlsNameAddressTextController?.dispose();

    mlsEmailAddressFocusNode?.dispose();
    mlsEmailAddressTextController?.dispose();

    mlsPasswordFocusNode?.dispose();
    mlsPasswordTextController?.dispose();

    crmEmailAddressFocusNode?.dispose();
    crmEmailAddressTextController?.dispose();

    crmPasswordFocusNode?.dispose();
    crmPasswordTextController?.dispose();
  }
}
