import '/backend/schema/enums/enums.dart';
import '/components/chat_bubble_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'buyer_chat_widget.dart' show BuyerChatWidget;
import 'package:flutter/material.dart';

class BuyerChatModel extends FlutterFlowModel<BuyerChatWidget> {
  ///  Local state fields for this page.

  UserStatus? userStatus = UserStatus.Online;

  ///  State fields for stateful widgets in this page.

  // Models for chat_bubble dynamic component.
  late FlutterFlowDynamicModels<ChatBubbleModel> chatBubbleModels;
  // State field(s) for chatTextField widget.
  FocusNode? chatTextFieldFocusNode;
  TextEditingController? chatTextFieldTextController;
  String? Function(BuildContext, String?)? chatTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    chatBubbleModels = FlutterFlowDynamicModels(() => ChatBubbleModel());
  }

  @override
  void dispose() {
    chatBubbleModels.dispose();
    chatTextFieldFocusNode?.dispose();
    chatTextFieldTextController?.dispose();
  }
}
