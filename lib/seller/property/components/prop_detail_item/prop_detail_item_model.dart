import '/flutter_flow/flutter_flow_util.dart';
import 'prop_detail_item_widget.dart' show PropDetailItemWidget;
import 'package:flutter/material.dart';

class PropDetailItemModel extends FlutterFlowModel<PropDetailItemWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
