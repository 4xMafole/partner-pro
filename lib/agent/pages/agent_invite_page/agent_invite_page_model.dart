import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'agent_invite_page_widget.dart' show AgentInvitePageWidget;
import 'package:flutter/material.dart';

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
