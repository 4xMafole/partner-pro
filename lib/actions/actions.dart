import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/agent_paywall_popup_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

Future isNewUser(BuildContext context) async {
  FFAppState().isNewUser = false;
}

Future hasActiveSubscription(BuildContext context) async {
  CustomersRecord? customerDoc;
  SubscriptionsRecord? activeSubscription;
  String? checkoutUrl12;

  customerDoc = await queryCustomersRecordOnce(
    queryBuilder: (customersRecord) => customersRecord.where(
      'email',
      isEqualTo: currentUserEmail,
    ),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  activeSubscription = await querySubscriptionsRecordOnce(
    parent: customerDoc?.reference,
    queryBuilder: (subscriptionsRecord) => subscriptionsRecord.where(
      'status',
      isEqualTo: 'active',
    ),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  if (!(activeSubscription != null)) {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: AgentPaywallPopupWidget(
              priceInUS: '\$49.99',
              onSubscribe: () async {
                // Stripe checkout removed - Sprint 1.2 (use RevenueCat)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Subscriptions are now managed through RevenueCat.',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                  ),
                );
              },
              onTry: () async {
                GoRouter.of(context).prepareAuthEvent();
                await authManager.signOut();
                GoRouter.of(context).clearRedirectLocation();

                context.goNamedAuth(
                    AuthOnboardWidget.routeName, context.mounted);
              },
            ),
          ),
        );
      },
    );
  }
}
