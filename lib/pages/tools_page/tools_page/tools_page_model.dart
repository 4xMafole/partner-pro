import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'tools_page_widget.dart' show ToolsPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
