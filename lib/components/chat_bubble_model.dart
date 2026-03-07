import '/flutter_flow/flutter_flow_util.dart';
import '/seller/offers/components/user1_message/user1_message_widget.dart';
import '/seller/offers/user_message/user_message_widget.dart';
import 'chat_bubble_widget.dart' show ChatBubbleWidget;
import 'package:flutter/material.dart';

class ChatBubbleModel extends FlutterFlowModel<ChatBubbleWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for user_message component.
  late UserMessageModel userMessageModel;
  // Model for user1_message component.
  late User1MessageModel user1MessageModel;

  @override
  void initState(BuildContext context) {
    userMessageModel = createModel(context, () => UserMessageModel());
    user1MessageModel = createModel(context, () => User1MessageModel());
  }

  @override
  void dispose() {
    userMessageModel.dispose();
    user1MessageModel.dispose();
  }
}
