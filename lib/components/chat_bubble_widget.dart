import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/offers/components/user1_message/user1_message_widget.dart';
import '/seller/offers/user_message/user_message_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_bubble_model.dart';
export 'chat_bubble_model.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({
    super.key,
    required this.message,
  });

  final MessageStruct? message;

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  late ChatBubbleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatBubbleModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(
          builder: (context) {
            if (widget!.message?.isSeller ?? false) {
              return wrapWithModel(
                model: _model.userMessageModel,
                updateCallback: () => safeSetState(() {}),
                child: UserMessageWidget(
                  message: widget!.message,
                ),
              );
            } else {
              return wrapWithModel(
                model: _model.user1MessageModel,
                updateCallback: () => safeSetState(() {}),
                child: User1MessageWidget(
                  message: widget!.message,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
