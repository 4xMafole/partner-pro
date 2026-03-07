import '/flutter_flow/flutter_flow_util.dart';
import '/pages/document/document_widget.dart';
import 'preapprovals_widget.dart' show PreapprovalsWidget;
import 'package:flutter/material.dart';

class PreapprovalsModel extends FlutterFlowModel<PreapprovalsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for document component.
  late DocumentModel documentModel;

  @override
  void initState(BuildContext context) {
    documentModel = createModel(context, () => DocumentModel());
  }

  @override
  void dispose() {
    documentModel.dispose();
  }
}
