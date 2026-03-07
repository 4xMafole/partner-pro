import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'delete_acc_sheet_widget.dart' show DeleteAccSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeleteAccSheetModel extends FlutterFlowModel<DeleteAccSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
    passwordVisibility = false;
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
