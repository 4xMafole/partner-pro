import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'agent_bottom_navbar_widget.dart' show AgentBottomNavbarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentBottomNavbarModel extends FlutterFlowModel<AgentBottomNavbarWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for navbar_item component.
  late NavbarItemModel navbarItemModel1;
  // Model for navbar_item component.
  late NavbarItemModel navbarItemModel2;
  // Model for navbar_item component.
  late NavbarItemModel navbarItemModel3;
  // Model for navbar_item component.
  late NavbarItemModel navbarItemModel4;

  @override
  void initState(BuildContext context) {
    navbarItemModel1 = createModel(context, () => NavbarItemModel());
    navbarItemModel2 = createModel(context, () => NavbarItemModel());
    navbarItemModel3 = createModel(context, () => NavbarItemModel());
    navbarItemModel4 = createModel(context, () => NavbarItemModel());
  }

  @override
  void dispose() {
    navbarItemModel1.dispose();
    navbarItemModel2.dispose();
    navbarItemModel3.dispose();
    navbarItemModel4.dispose();
  }
}
