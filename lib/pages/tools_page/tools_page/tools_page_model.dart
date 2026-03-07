import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'tools_page_widget.dart' show ToolsPageWidget;
import 'package:flutter/material.dart';

class ToolsPageModel extends FlutterFlowModel<ToolsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for buyer_bottom_navbar component.
  late BuyerBottomNavbarModel buyerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    buyerBottomNavbarModel =
        createModel(context, () => BuyerBottomNavbarModel());
  }

  @override
  void dispose() {
    buyerBottomNavbarModel.dispose();
  }
}
