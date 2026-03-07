import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/offers/components/seller_counter_sheet/seller_counter_sheet_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'seller_offers_page_widget.dart' show SellerOffersPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerOffersPageModel extends FlutterFlowModel<SellerOffersPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel1;
  // Model for title_label component.
  late TitleLabelModel titleLabelModel2;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels1;
  // Stores action output result for [Custom Action - indexOfOffer] action in seller_offer_item widget.
  int? offerIndexPending;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels2;
  // Stores action output result for [Custom Action - indexOfOffer] action in seller_offer_item widget.
  int? offerIndexAccepted;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels3;
  // Stores action output result for [Custom Action - indexOfOffer] action in seller_offer_item widget.
  int? offerIndexDeclined;
  // Model for seller_bottom_navbar component.
  late SellerBottomNavbarModel sellerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    titleLabelModel1 = createModel(context, () => TitleLabelModel());
    titleLabelModel2 = createModel(context, () => TitleLabelModel());
    sellerOfferItemModels1 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels2 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels3 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerBottomNavbarModel =
        createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    titleLabelModel1.dispose();
    titleLabelModel2.dispose();
    tabBarController?.dispose();
    sellerOfferItemModels1.dispose();
    sellerOfferItemModels2.dispose();
    sellerOfferItemModels3.dispose();
    sellerBottomNavbarModel.dispose();
  }
}
