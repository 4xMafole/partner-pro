import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/agent/components/agent_recent_activity/agent_recent_activity_widget.dart';
import '/agent/components/header/header_widget.dart';
import '/agent/components/invitation_selector_sheet/invitation_selector_sheet_widget.dart';
import '/agent/components/notification_popup/notification_popup_widget.dart';
import '/agent/components/profile_sheet/profile_sheet_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/agent_paywall_popup_widget.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'agent_dashboard_widget.dart' show AgentDashboardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentDashboardModel extends FlutterFlowModel<AgentDashboardWidget> {
  ///  Local state fields for this page.

  List<ActivityItemTypeStruct> recentActivityList = [];
  void addToRecentActivityList(ActivityItemTypeStruct item) =>
      recentActivityList.add(item);
  void removeFromRecentActivityList(ActivityItemTypeStruct item) =>
      recentActivityList.remove(item);
  void removeAtIndexFromRecentActivityList(int index) =>
      recentActivityList.removeAt(index);
  void insertAtIndexInRecentActivityList(
          int index, ActivityItemTypeStruct item) =>
      recentActivityList.insert(index, item);
  void updateRecentActivityListAtIndex(
          int index, Function(ActivityItemTypeStruct) updateFn) =>
      recentActivityList[index] = updateFn(recentActivityList[index]);

  bool paywallActive = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in agent_dashboard widget.
  CustomersRecord? customerDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in agent_dashboard widget.
  SubscriptionsRecord? activeSubscription;
  // Stores action output result for [Backend Call - API (getAllClientsByAgentId)] action in agent_dashboard widget.
  ApiCallResponse? getAllClients;
  // Stores action output result for [Backend Call - API (getAllClientActivityByAgentId)] action in agent_dashboard widget.
  ApiCallResponse? getAllClientsActivity;
  // Stores action output result for [Custom Action - processAndEnrichActivityFeed] action in agent_dashboard widget.
  List<ActivityItemTypeStruct>? processedActivityList;
  // Stores action output result for [Custom Action - initiateStripeCheckout] action in agent_dashboard widget.
  String? checkoutUrl1;
  List<SubscriptionsRecord>? stackPreviousSnapshot;
  // Stores action output result for [Custom Action - initiateStripeCheckout] action in Stack widget.
  String? checkoutUrl;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for agent_recent_activity component.
  late AgentRecentActivityModel agentRecentActivityModel;
  // Model for agent_bottom_navbar component.
  late AgentBottomNavbarModel agentBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    agentRecentActivityModel =
        createModel(context, () => AgentRecentActivityModel());
    agentBottomNavbarModel =
        createModel(context, () => AgentBottomNavbarModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    agentRecentActivityModel.dispose();
    agentBottomNavbarModel.dispose();
  }
}
