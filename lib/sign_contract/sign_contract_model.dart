import '/flutter_flow/flutter_flow_util.dart';
import 'sign_contract_widget.dart' show SignContractWidget;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignContractModel extends FlutterFlowModel<SignContractWidget> {
  ///  State fields for stateful widgets in this page.

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
