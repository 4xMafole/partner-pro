import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/document/document_widget.dart';
import 'dart:ui';
import 'preapprovals_widget.dart' show PreapprovalsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
