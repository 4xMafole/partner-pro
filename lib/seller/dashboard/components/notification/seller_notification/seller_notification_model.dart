import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/dashboard/components/notification/seller_notification_item/seller_notification_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'seller_notification_widget.dart' show SellerNotificationWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerNotificationModel
    extends FlutterFlowModel<SellerNotificationWidget> {
  ///  State fields for stateful widgets in this component.

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
