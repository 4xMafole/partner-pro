import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/components/profile_list_item_widget.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'seller_profile_page_widget.dart' show SellerProfilePageWidget;
import 'package:flutter/material.dart';

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
