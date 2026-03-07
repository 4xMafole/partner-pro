import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'support_sheet_widget.dart' show SupportSheetWidget;
import 'package:flutter/material.dart';

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
