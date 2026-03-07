import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'invite_code_sheet_widget.dart' show InviteCodeSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InviteCodeSheetModel extends FlutterFlowModel<InviteCodeSheetWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Model for title_label component.
  late TitleLabelModel titleLabelModel;
  // State field(s) for inviteCode widget.
  FocusNode? inviteCodeFocusNode;
  TextEditingController? inviteCodeTextController;
  String? Function(BuildContext, String?)? inviteCodeTextControllerValidator;
  String? _inviteCodeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Invite code is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
    inviteCodeTextControllerValidator = _inviteCodeTextControllerValidator;
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
    inviteCodeFocusNode?.dispose();
    inviteCodeTextController?.dispose();
  }
}
