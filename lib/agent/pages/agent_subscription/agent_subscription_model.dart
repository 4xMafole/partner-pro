import '/agent/components/billing_item/billing_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'agent_subscription_widget.dart' show AgentSubscriptionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentSubscriptionModel extends FlutterFlowModel<AgentSubscriptionWidget> {
  ///  Local state fields for this page.

  bool isActive = false;

  bool isCancelled = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in agent_subscription widget.
  CustomersRecord? customerDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in agent_subscription widget.
  SubscriptionsRecord? subscriptionDoc;
  // Stores action output result for [Custom Action - initiateStripeCheckout] action in Button widget.
  String? checkoutUrl;
  List<SubscriptionsRecord>? listViewPreviousSnapshot;
  // Models for billing_item dynamic component.
  late FlutterFlowDynamicModels<BillingItemModel> billingItemModels;
  // Stores action output result for [Custom Action - callStripePortalLink] action in Button widget.
  String? stripePortailLink;

  @override
  void initState(BuildContext context) {
    billingItemModels = FlutterFlowDynamicModels(() => BillingItemModel());
  }

  @override
  void dispose() {
    billingItemModels.dispose();
  }
}
