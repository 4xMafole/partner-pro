import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/chat_bubble_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'seller_chat_page_widget.dart' show SellerChatPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerChatPageModel extends FlutterFlowModel<SellerChatPageWidget> {
  ///  Local state fields for this page.

  UserStatus? userStatus = UserStatus.Online;

  MessageStruct? messages;
  void updateMessagesStruct(Function(MessageStruct) updateFn) {
    updateFn(messages ??= MessageStruct());
  }

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
