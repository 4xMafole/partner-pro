import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'agent_invite_page_widget.dart' show AgentInvitePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentInvitePageModel extends FlutterFlowModel<AgentInvitePageWidget> {
  ///  Local state fields for this page.

  InvitationTypeStruct? newAgentInvitation;
  void updateNewAgentInvitationStruct(Function(InvitationTypeStruct) updateFn) {
    updateFn(newAgentInvitation ??= InvitationTypeStruct());
  }

  EmailProviderStruct? emailProvider;
  void updateEmailProviderStruct(Function(EmailProviderStruct) updateFn) {
    updateFn(emailProvider ??= EmailProviderStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // Stores action output result for [Custom Action - generateInvitationEmailHtml] action in Button widget.
  String? agentHtml;
  // Stores action output result for [Backend Call - API (postEmail)] action in Button widget.
  ApiCallResponse? emailSent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();
  }
}
