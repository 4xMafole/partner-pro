import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/editable_document_upload_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'funds_proof_sheet_widget.dart' show FundsProofSheetWidget;
import 'package:flutter/material.dart';

class FundsProofSheetModel extends FlutterFlowModel<FundsProofSheetWidget> {
  ///  Local state fields for this component.

  List<FileInfoStruct> documents = [];
  void addToDocuments(FileInfoStruct item) => documents.add(item);
  void removeFromDocuments(FileInfoStruct item) => documents.remove(item);
  void removeAtIndexFromDocuments(int index) => documents.removeAt(index);
  void insertAtIndexInDocuments(int index, FileInfoStruct item) =>
      documents.insert(index, item);
  void updateDocumentsAtIndex(int index, Function(FileInfoStruct) updateFn) =>
      documents[index] = updateFn(documents[index]);

  ///  State fields for stateful widgets in this component.

  // Models for editable_document_upload dynamic component.
  late FlutterFlowDynamicModels<EditableDocumentUploadModel>
      editableDocumentUploadModels;
  // Stores action output result for [Custom Action - pickFileOnly] action in Button widget.
  FileInfoStruct? pickedFile1;
  // Stores action output result for [Custom Action - uploadPickedFile] action in Button widget.
  FileInfoStruct? proofFunds;
  // Stores action output result for [Backend Call - API (postDocumentsByUser)] action in Button widget.
  ApiCallResponse? postDocumentsByUser1;
  // Stores action output result for [Custom Action - pickFileOnly] action in Button widget.
  FileInfoStruct? pickedFile;

  @override
  void initState(BuildContext context) {
    editableDocumentUploadModels =
        FlutterFlowDynamicModels(() => EditableDocumentUploadModel());
  }

  @override
  void dispose() {
    editableDocumentUploadModels.dispose();
  }
}
