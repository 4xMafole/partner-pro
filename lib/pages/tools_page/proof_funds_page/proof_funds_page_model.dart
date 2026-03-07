import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/document/document_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'proof_funds_page_widget.dart' show ProofFundsPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
