import '/components/notification_list_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'notification_popup_widget.dart' show NotificationPopupWidget;
import 'package:flutter/material.dart';

class NotificationPopupModel extends FlutterFlowModel<NotificationPopupWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for notification_list_item dynamic component.
  late FlutterFlowDynamicModels<NotificationListItemModel>
      notificationListItemModels1;
  // Models for notification_list_item dynamic component.
  late FlutterFlowDynamicModels<NotificationListItemModel>
      notificationListItemModels2;

  @override
  void initState(BuildContext context) {
    notificationListItemModels1 =
        FlutterFlowDynamicModels(() => NotificationListItemModel());
    notificationListItemModels2 =
        FlutterFlowDynamicModels(() => NotificationListItemModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    notificationListItemModels1.dispose();
    notificationListItemModels2.dispose();
  }
}
