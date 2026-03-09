import '/agent/components/app_logo/app_logo_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'auth_register_widget.dart' show AuthRegisterWidget;
import 'package:flutter/material.dart';

class AuthRegisterModel extends FlutterFlowModel<AuthRegisterWidget> {
  ///  Local state fields for this page.

  ApiUserStruct? apiUser;
  void updateApiUserStruct(Function(ApiUserStruct) updateFn) {
    updateFn(apiUser ??= ApiUserStruct());
  }

  UserType? userRole;

  RelationshipTypeStruct? newRelationship;
  void updateNewRelationshipStruct(Function(RelationshipTypeStruct) updateFn) {
    updateFn(newRelationship ??= RelationshipTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for app_logo component.
  late AppLogoModel appLogoModel;
  // State field(s) for fullname widget.
  FocusNode? fullnameFocusNode;
  TextEditingController? fullnameTextController;
  String? Function(BuildContext, String?)? fullnameTextControllerValidator;
  String? _fullnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Phone Number is required';
    }

    return null;
  }

  // State field(s) for agency widget.
  FocusNode? agencyFocusNode;
  TextEditingController? agencyTextController;
  String? Function(BuildContext, String?)? agencyTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for confirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordTextController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordTextControllerValidator;
  String? _confirmPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for consentCheckbox widget.
  bool? consentCheckboxValue;
  // State field(s) for tosCheckbox widget.
  bool? tosCheckboxValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InvitationsRecord? pendingInviteDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InvitationsRecord? pendingBuyerInviteDoc;
  // Stores action output result for [Backend Call - API (createClientByAgentId)] action in Button widget.
  ApiCallResponse? apiInvitedClient;

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
    fullnameTextControllerValidator = _fullnameTextControllerValidator;
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordTextControllerValidator =
        _confirmPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    appLogoModel.dispose();
    fullnameFocusNode?.dispose();
    fullnameTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    agencyFocusNode?.dispose();
    agencyTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordTextController?.dispose();
  }

  /// Action blocks.
  Future apiRegister(BuildContext context) async {
    updateApiUserStruct(
      (e) => e
        ..createdBy = 'system'
        ..status = true
        ..userName = currentUserDisplayName
        ..email = currentUserEmail
        ..phone = currentPhoneNumber
        ..photoUrl = functions.imagePathToStr(currentUserPhoto)
        ..accountType = currentUserDocument?.role?.name
        ..userId = currentUserUid
        ..displayName = currentUserDisplayName,
    );
    await IwoAccountGroup.addUserCall.call(
      bodyJson: apiUser?.toMap(),
    );
  }
}
