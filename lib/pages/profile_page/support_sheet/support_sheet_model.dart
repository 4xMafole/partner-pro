import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'support_sheet_widget.dart' show SupportSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SupportSheetModel extends FlutterFlowModel<SupportSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel;
  // State field(s) for supportMessage widget.
  FocusNode? supportMessageFocusNode;
  TextEditingController? supportMessageTextController;
  String? Function(BuildContext, String?)?
      supportMessageTextControllerValidator;

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
    supportMessageFocusNode?.dispose();
    supportMessageTextController?.dispose();
  }
}
