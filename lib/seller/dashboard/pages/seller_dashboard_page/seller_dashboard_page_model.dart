import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/app_shared/components/walkthrough/info_card/info_card_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/dashboard/components/appointment/seller_prop_appoint_item/seller_prop_appoint_item_widget.dart';
import '/seller/dashboard/components/dash_overview_item/dash_overview_item_widget.dart';
import '/seller/dashboard/components/notification/seller_notification/seller_notification_widget.dart';
import '/seller/dashboard/components/notification_item/notification_item_widget.dart';
import '/seller/dashboard/components/seller_top_prop_item/seller_top_prop_item_widget.dart';
import '/walkthroughs/new_seller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'seller_dashboard_page_widget.dart' show SellerDashboardPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerDashboardPageModel
    extends FlutterFlowModel<SellerDashboardPageWidget> {
  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? newSellerController;
  // Model for notification_item component.
  late NotificationItemModel notificationItemModel;
  // Model for info_card component.
  late InfoCardModel infoCardModel;
  // Model for dash_overview_item component.
  late DashOverviewItemModel dashOverviewItemModel1;
  // Model for dash_overview_item component.
  late DashOverviewItemModel dashOverviewItemModel2;
  // Model for dash_overview_item component.
  late DashOverviewItemModel dashOverviewItemModel3;
  // Model for dash_overview_item component.
  late DashOverviewItemModel dashOverviewItemModel4;
  // Models for seller_top_prop_item dynamic component.
  late FlutterFlowDynamicModels<SellerTopPropItemModel> sellerTopPropItemModels;
  // Models for seller_prop_appoint_item dynamic component.
  late FlutterFlowDynamicModels<SellerPropAppointItemModel>
      sellerPropAppointItemModels;
  // Model for seller_bottom_navbar component.
  late SellerBottomNavbarModel sellerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    notificationItemModel = createModel(context, () => NotificationItemModel());
    infoCardModel = createModel(context, () => InfoCardModel());
    dashOverviewItemModel1 =
        createModel(context, () => DashOverviewItemModel());
    dashOverviewItemModel2 =
        createModel(context, () => DashOverviewItemModel());
    dashOverviewItemModel3 =
        createModel(context, () => DashOverviewItemModel());
    dashOverviewItemModel4 =
        createModel(context, () => DashOverviewItemModel());
    sellerTopPropItemModels =
        FlutterFlowDynamicModels(() => SellerTopPropItemModel());
    sellerPropAppointItemModels =
        FlutterFlowDynamicModels(() => SellerPropAppointItemModel());
    sellerBottomNavbarModel =
        createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    newSellerController?.finish();
    notificationItemModel.dispose();
    infoCardModel.dispose();
    dashOverviewItemModel1.dispose();
    dashOverviewItemModel2.dispose();
    dashOverviewItemModel3.dispose();
    dashOverviewItemModel4.dispose();
    sellerTopPropItemModels.dispose();
    sellerPropAppointItemModels.dispose();
    sellerBottomNavbarModel.dispose();
  }
}
