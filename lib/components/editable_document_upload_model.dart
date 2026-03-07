import '/flutter_flow/flutter_flow_util.dart';
import '/pages/profile_page/document_uploaded/document_uploaded_widget.dart';
import 'editable_document_upload_widget.dart' show EditableDocumentUploadWidget;
import 'package:flutter/material.dart';

class EditableDocumentUploadModel
    extends FlutterFlowModel<EditableDocumentUploadWidget> {
  ///  Local state fields for this component.

  bool isEdit = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Model for document_uploaded component.
  late DocumentUploadedModel documentUploadedModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'File name is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    documentUploadedModel = createModel(context, () => DocumentUploadedModel());
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    documentUploadedModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
