import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'seller_property_listing_page_widget.dart'
    show SellerPropertyListingPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerPropertyListingPageModel
    extends FlutterFlowModel<SellerPropertyListingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for title_label component.
  late TitleLabelModel titleLabelModel;
  // Models for seller_property_item dynamic component.
  late FlutterFlowDynamicModels<SellerPropertyItemModel>
      sellerPropertyItemModels1;
  // Models for seller_property_item dynamic component.
  late FlutterFlowDynamicModels<SellerPropertyItemModel>
      sellerPropertyItemModels2;
  // Model for seller_bottom_navbar component.
  late SellerBottomNavbarModel sellerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    titleLabelModel = createModel(context, () => TitleLabelModel());
    sellerPropertyItemModels1 =
        FlutterFlowDynamicModels(() => SellerPropertyItemModel());
    sellerPropertyItemModels2 =
        FlutterFlowDynamicModels(() => SellerPropertyItemModel());
    sellerBottomNavbarModel =
        createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    titleLabelModel.dispose();
    sellerPropertyItemModels1.dispose();
    sellerPropertyItemModels2.dispose();
    sellerBottomNavbarModel.dispose();
  }
}
