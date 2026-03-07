import '/flutter_flow/flutter_flow_util.dart';
import '/seller/dashboard/components/notification/seller_notification_item/seller_notification_item_widget.dart';
import 'seller_notification_page_widget.dart' show SellerNotificationPageWidget;
import 'package:flutter/material.dart';

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
