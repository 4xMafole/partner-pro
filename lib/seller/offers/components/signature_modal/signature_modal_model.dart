import '/flutter_flow/flutter_flow_util.dart';
import 'signature_modal_widget.dart' show SignatureModalWidget;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureModalModel extends FlutterFlowModel<SignatureModalWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Signature widget.
  SignatureController? signatureController;
  String uploadedSignatureUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    signatureController?.dispose();
  }
}
