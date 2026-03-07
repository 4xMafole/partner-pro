import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'buyer_bottom_navbar_widget.dart' show BuyerBottomNavbarWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BuyerBottomNavbarModel extends FlutterFlowModel<BuyerBottomNavbarWidget> {
  ///  Local state fields for this component.

  bool dashboardisOff = true;

  ///  State fields for stateful widgets in this component.

  // Model for navbar.
  late NavbarItemModel navbarModel1;
  // Model for activeNavbar.
  late NavbarItemModel activeNavbarModel1;
  // Model for navbar.
  late NavbarItemModel navbarModel2;
  // Model for activeNavbar.
  late NavbarItemModel activeNavbarModel2;
  // Model for navbar.
  late NavbarItemModel navbarModel3;
  // Model for activeNavbar.
  late NavbarItemModel activeNavbarModel3;
  // Model for navbar.
  late NavbarItemModel navbarModel4;
  // Model for activeNavbar.
  late NavbarItemModel activeNavbarModel4;

  @override
  void initState(BuildContext context) {
    navbarModel1 = createModel(context, () => NavbarItemModel());
    activeNavbarModel1 = createModel(context, () => NavbarItemModel());
    navbarModel2 = createModel(context, () => NavbarItemModel());
    activeNavbarModel2 = createModel(context, () => NavbarItemModel());
    navbarModel3 = createModel(context, () => NavbarItemModel());
    activeNavbarModel3 = createModel(context, () => NavbarItemModel());
    navbarModel4 = createModel(context, () => NavbarItemModel());
    activeNavbarModel4 = createModel(context, () => NavbarItemModel());
  }

  @override
  void dispose() {
    navbarModel1.dispose();
    activeNavbarModel1.dispose();
    navbarModel2.dispose();
    activeNavbarModel2.dispose();
    navbarModel3.dispose();
    activeNavbarModel3.dispose();
    navbarModel4.dispose();
    activeNavbarModel4.dispose();
  }
}
