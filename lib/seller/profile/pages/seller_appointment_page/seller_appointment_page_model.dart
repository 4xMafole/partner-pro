import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/profile/components/seller_appoint_item/seller_appoint_item_widget.dart';
import 'seller_appointment_page_widget.dart' show SellerAppointmentPageWidget;
import 'package:flutter/material.dart';

class SellerAppointmentPageModel
    extends FlutterFlowModel<SellerAppointmentPageWidget> {
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

  // Models for seller_appoint_item dynamic component.
  late FlutterFlowDynamicModels<SellerAppointItemModel>
      sellerAppointItemModels1;
  // Models for seller_appoint_item dynamic component.
  late FlutterFlowDynamicModels<SellerAppointItemModel>
      sellerAppointItemModels2;
  // Models for seller_appoint_item dynamic component.
  late FlutterFlowDynamicModels<SellerAppointItemModel>
      sellerAppointItemModels3;

  @override
  void initState(BuildContext context) {
    titleLabelModel1 = createModel(context, () => TitleLabelModel());
    titleLabelModel2 = createModel(context, () => TitleLabelModel());
    sellerAppointItemModels1 =
        FlutterFlowDynamicModels(() => SellerAppointItemModel());
    sellerAppointItemModels2 =
        FlutterFlowDynamicModels(() => SellerAppointItemModel());
    sellerAppointItemModels3 =
        FlutterFlowDynamicModels(() => SellerAppointItemModel());
  }

  @override
  void dispose() {
    titleLabelModel1.dispose();
    titleLabelModel2.dispose();
    tabBarController?.dispose();
    sellerAppointItemModels1.dispose();
    sellerAppointItemModels2.dispose();
    sellerAppointItemModels3.dispose();
  }
}
