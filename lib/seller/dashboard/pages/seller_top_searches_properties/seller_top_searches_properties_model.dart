import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'seller_top_searches_properties_widget.dart'
    show SellerTopSearchesPropertiesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerTopSearchesPropertiesModel
    extends FlutterFlowModel<SellerTopSearchesPropertiesWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for seller_property_item dynamic component.
  late FlutterFlowDynamicModels<SellerPropertyItemModel>
      sellerPropertyItemModels;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels;

  @override
  void initState(BuildContext context) {
    sellerPropertyItemModels =
        FlutterFlowDynamicModels(() => SellerPropertyItemModel());
    propertyItemModels = FlutterFlowDynamicModels(() => PropertyItemModel());
  }

  @override
  void dispose() {
    sellerPropertyItemModels.dispose();
    propertyItemModels.dispose();
  }
}
