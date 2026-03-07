import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'seller_bottom_navbar_widget.dart' show SellerBottomNavbarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerBottomNavbarModel
    extends FlutterFlowModel<SellerBottomNavbarWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for dashNavbar.
  late NavbarItemModel dashNavbarModel;
  // Model for activeDashNavbar.
  late NavbarItemModel activeDashNavbarModel;
  // Model for navbar.
  late NavbarItemModel navbarModel;
  // Model for activeNavbar.
  late NavbarItemModel activeNavbarModel;
  // Model for propertyNavbar.
  late NavbarItemModel propertyNavbarModel;
  // Model for activePropertyNavbar.
  late NavbarItemModel activePropertyNavbarModel;
  // Model for offerNavbar.
  late NavbarItemModel offerNavbarModel;
  // Model for activeOfferNavbar.
  late NavbarItemModel activeOfferNavbarModel;
  // Model for profileNavbar.
  late NavbarItemModel profileNavbarModel;
  // Model for activeProfileNavbar.
  late NavbarItemModel activeProfileNavbarModel;

  @override
  void initState(BuildContext context) {
    dashNavbarModel = createModel(context, () => NavbarItemModel());
    activeDashNavbarModel = createModel(context, () => NavbarItemModel());
    navbarModel = createModel(context, () => NavbarItemModel());
    activeNavbarModel = createModel(context, () => NavbarItemModel());
    propertyNavbarModel = createModel(context, () => NavbarItemModel());
    activePropertyNavbarModel = createModel(context, () => NavbarItemModel());
    offerNavbarModel = createModel(context, () => NavbarItemModel());
    activeOfferNavbarModel = createModel(context, () => NavbarItemModel());
    profileNavbarModel = createModel(context, () => NavbarItemModel());
    activeProfileNavbarModel = createModel(context, () => NavbarItemModel());
  }

  @override
  void dispose() {
    dashNavbarModel.dispose();
    activeDashNavbarModel.dispose();
    navbarModel.dispose();
    activeNavbarModel.dispose();
    propertyNavbarModel.dispose();
    activePropertyNavbarModel.dispose();
    offerNavbarModel.dispose();
    activeOfferNavbarModel.dispose();
    profileNavbarModel.dispose();
    activeProfileNavbarModel.dispose();
  }
}
