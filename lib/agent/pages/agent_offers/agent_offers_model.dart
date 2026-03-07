import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import '/index.dart';
import 'agent_offers_widget.dart' show AgentOffersWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class AgentOffersModel extends FlutterFlowModel<AgentOffersWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  Completer<ApiCallResponse>? apiRequestCompleter2;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels1;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels2;
  Completer<ApiCallResponse>? apiRequestCompleter3;
  // Models for seller_offer_item dynamic component.
  late FlutterFlowDynamicModels<SellerOfferItemModel> sellerOfferItemModels3;
  // Model for agent_bottom_navbar component.
  late AgentBottomNavbarModel agentBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    sellerOfferItemModels1 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels2 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    sellerOfferItemModels3 =
        FlutterFlowDynamicModels(() => SellerOfferItemModel());
    agentBottomNavbarModel =
        createModel(context, () => AgentBottomNavbarModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    sellerOfferItemModels1.dispose();
    sellerOfferItemModels2.dispose();
    sellerOfferItemModels3.dispose();
    agentBottomNavbarModel.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter3?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
