import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/profile_list_item_widget.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'seller_profile_page_widget.dart' show SellerProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerProfilePageModel extends FlutterFlowModel<SellerProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel;
  // Model for profile_list_item component.
  late ProfileListItemModel profileListItemModel1;
  // Model for profile_list_item component.
  late ProfileListItemModel profileListItemModel2;
  // Model for profile_list_item component.
  late ProfileListItemModel profileListItemModel3;
  // Model for profile_list_item component.
  late ProfileListItemModel profileListItemModel4;
  // Model for seller_bottom_navbar component.
  late SellerBottomNavbarModel sellerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
    profileListItemModel1 = createModel(context, () => ProfileListItemModel());
    profileListItemModel2 = createModel(context, () => ProfileListItemModel());
    profileListItemModel3 = createModel(context, () => ProfileListItemModel());
    profileListItemModel4 = createModel(context, () => ProfileListItemModel());
    sellerBottomNavbarModel =
        createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
    profileListItemModel1.dispose();
    profileListItemModel2.dispose();
    profileListItemModel3.dispose();
    profileListItemModel4.dispose();
    sellerBottomNavbarModel.dispose();
  }
}
