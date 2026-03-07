import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/document/document_widget.dart';
import 'dart:ui';
import 'property_document_widget.dart' show PropertyDocumentWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PropertyDocumentModel extends FlutterFlowModel<PropertyDocumentWidget> {
  ///  Local state fields for this component.

  bool isDocumentsShow = false;

  ///  State fields for stateful widgets in this component.

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
