import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/dashboard/components/notification/notification_item_option/notification_item_option_widget.dart';
import '/seller/dashboard/components/notification/seller_notification_item/seller_notification_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'seller_notification_page_widget.dart' show SellerNotificationPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerNotificationPageModel
    extends FlutterFlowModel<SellerNotificationPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for seller_notification_item dynamic component.
  late FlutterFlowDynamicModels<SellerNotificationItemModel>
      sellerNotificationItemModels;

  @override
  void initState(BuildContext context) {
    sellerNotificationItemModels =
        FlutterFlowDynamicModels(() => SellerNotificationItemModel());
  }

  @override
  void dispose() {
    sellerNotificationItemModels.dispose();
  }
}
