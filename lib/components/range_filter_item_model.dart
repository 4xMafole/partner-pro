import '/flutter_flow/flutter_flow_util.dart';
import 'range_filter_item_widget.dart' show RangeFilterItemWidget;
import 'package:flutter/material.dart';

class RangeFilterItemModel extends FlutterFlowModel<RangeFilterItemWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for minTextField widget.
  FocusNode? minTextFieldFocusNode;
  TextEditingController? minTextFieldTextController;
  String? Function(BuildContext, String?)? minTextFieldTextControllerValidator;
  // State field(s) for maxTextField widget.
  FocusNode? maxTextFieldFocusNode;
  TextEditingController? maxTextFieldTextController;
  String? Function(BuildContext, String?)? maxTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    minTextFieldFocusNode?.dispose();
    minTextFieldTextController?.dispose();

    maxTextFieldFocusNode?.dispose();
    maxTextFieldTextController?.dispose();
  }
}
