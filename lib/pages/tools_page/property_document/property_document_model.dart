import '/flutter_flow/flutter_flow_util.dart';
import '/pages/document/document_widget.dart';
import 'property_document_widget.dart' show PropertyDocumentWidget;
import 'package:flutter/material.dart';

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
