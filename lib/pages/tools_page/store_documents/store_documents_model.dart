import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/tools_page/property_document/property_document_widget.dart';
import 'dart:ui';
import 'store_documents_widget.dart' show StoreDocumentsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StoreDocumentsModel extends FlutterFlowModel<StoreDocumentsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for property_document component.
  late PropertyDocumentModel propertyDocumentModel1;
  // Model for property_document component.
  late PropertyDocumentModel propertyDocumentModel2;
  // Model for property_document component.
  late PropertyDocumentModel propertyDocumentModel3;

  @override
  void initState(BuildContext context) {
    propertyDocumentModel1 =
        createModel(context, () => PropertyDocumentModel());
    propertyDocumentModel2 =
        createModel(context, () => PropertyDocumentModel());
    propertyDocumentModel3 =
        createModel(context, () => PropertyDocumentModel());
  }

  @override
  void dispose() {
    propertyDocumentModel1.dispose();
    propertyDocumentModel2.dispose();
    propertyDocumentModel3.dispose();
  }
}
