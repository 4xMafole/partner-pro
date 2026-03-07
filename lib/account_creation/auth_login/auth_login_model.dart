import '/agent/components/app_logo/app_logo_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'auth_login_widget.dart' show AuthLoginWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthLoginModel extends FlutterFlowModel<AuthLoginWidget> {
  ///  Local state fields for this page.

  ApiUserStruct? apiUser;
  void updateApiUserStruct(Function(ApiUserStruct) updateFn) {
    updateFn(apiUser ??= ApiUserStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for app_logo component.
  late AppLogoModel appLogoModel;
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

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    appLogoModel.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }

  /// Action blocks.
  Future apiRegister(BuildContext context) async {
    ApiCallResponse? apiAddUserResults;

    updateApiUserStruct(
      (e) => e
        ..createdBy = 'system'
        ..status = true
        ..userName = currentUserDisplayName
        ..email = currentUserEmail
        ..accountType = currentUserDocument?.role?.name
        ..userId = currentUserUid
        ..displayName = currentUserDisplayName,
    );
    apiAddUserResults = await IwoAccountGroup.addUserCall.call(
      bodyJson: apiUser?.toMap(),
    );

    await actions.oneSignalLogin(
      currentUserUid,
    );

    context.goNamed(FlowChooserPageWidget.routeName);
  }
}
