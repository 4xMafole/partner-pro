import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/document/document_widget.dart';
import 'proof_funds_page_widget.dart' show ProofFundsPageWidget;
import 'package:flutter/material.dart';

class ProofFundsPageModel extends FlutterFlowModel<ProofFundsPageWidget> {
  ///  Local state fields for this page.

  List<DocumentStruct> emptyDocs = [];
  void addToEmptyDocs(DocumentStruct item) => emptyDocs.add(item);
  void removeFromEmptyDocs(DocumentStruct item) => emptyDocs.remove(item);
  void removeAtIndexFromEmptyDocs(int index) => emptyDocs.removeAt(index);
  void insertAtIndexInEmptyDocs(int index, DocumentStruct item) =>
      emptyDocs.insert(index, item);
  void updateEmptyDocsAtIndex(int index, Function(DocumentStruct) updateFn) =>
      emptyDocs[index] = updateFn(emptyDocs[index]);

  ///  State fields for stateful widgets in this page.

  // Models for document dynamic component.
  late FlutterFlowDynamicModels<DocumentModel> documentModels;

  @override
  void initState(BuildContext context) {
    documentModels = FlutterFlowDynamicModels(() => DocumentModel());
  }

  @override
  void dispose() {
    documentModels.dispose();
  }
}
