import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/profile_page/account_settings_page/delete_acc_sheet/delete_acc_sheet_widget.dart';
import '/pages/profile_page/confirm_popup/confirm_popup_widget.dart';
import '/pages/verification_sheet/verification_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'account_settings_widget.dart' show AccountSettingsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountSettingsModel extends FlutterFlowModel<AccountSettingsWidget> {
  ///  Local state fields for this page.

  bool showLanguage = false;

  String? accountProvider;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getUserSignInMethod] action in account_settings widget.
  String? signInMethod;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
