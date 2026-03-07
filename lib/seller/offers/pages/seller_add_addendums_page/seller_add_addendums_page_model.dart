import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'seller_add_addendums_page_widget.dart'
    show SellerAddAddendumsPageWidget;
import 'package:flutter/material.dart';

class SellerAddAddendumsPageModel
    extends FlutterFlowModel<SellerAddAddendumsPageWidget> {
  ///  Local state fields for this page.

  bool isPreview = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for descTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  // Stores action output result for [Bottom Sheet - signature_modal] action in Image widget.
  String? signature2output;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();
  }
}
