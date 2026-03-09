import '/agent/components/billing_item/billing_item_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'agent_subscription_widget.dart' show AgentSubscriptionWidget;
import 'package:flutter/material.dart';

class AgentSubscriptionModel extends FlutterFlowModel<AgentSubscriptionWidget> {
  ///  Local state fields for this page.

  bool isActive = false;

  bool isCancelled = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in agent_subscription widget.
  CustomersRecord? customerDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in agent_subscription widget.
  SubscriptionsRecord? subscriptionDoc;
  // [DEPRECATED] Stripe checkout removed - Sprint 1.2.
  String? checkoutUrl;
  List<SubscriptionsRecord>? listViewPreviousSnapshot;
  // Models for billing_item dynamic component.
  late FlutterFlowDynamicModels<BillingItemModel> billingItemModels;
  // [DEPRECATED] Stripe portal removed - Sprint 1.2.
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
