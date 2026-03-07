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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'agent_dashboard_model.dart';
export 'agent_dashboard_model.dart';

class AgentDashboardWidget extends StatefulWidget {
  const AgentDashboardWidget({super.key});

  static String routeName = 'agent_dashboard';
  static String routePath = '/agentDashboard';

  @override
  State<AgentDashboardWidget> createState() => _AgentDashboardWidgetState();
}

class _AgentDashboardWidgetState extends State<AgentDashboardWidget> {
  late AgentDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.customerDoc = await queryCustomersRecordOnce(
        queryBuilder: (customersRecord) => customersRecord.where(
          'email',
          isEqualTo: currentUserEmail,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.activeSubscription = await querySubscriptionsRecordOnce(
        parent: _model.customerDoc?.reference,
        queryBuilder: (subscriptionsRecord) => subscriptionsRecord.where(
          'status',
          isEqualTo: 'active',
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.activeSubscription != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: CustomLoadingIndicatorWidget(
                  label: 'Please wait...',
                ),
              ),
            );
          },
        );

        _model.getAllClients =
            await IwoAgentClientGroup.getAllClientsByAgentIdCall.call(
          agentId: currentUserUid,
        );

        if ((_model.getAllClients?.succeeded ?? true)) {
          _model.getAllClientsActivity =
              await IwoAgentClientGroup.getAllClientActivityByAgentIdCall.call(
            agentId: currentUserUid,
          );

          if ((_model.getAllClientsActivity?.succeeded ?? true)) {
            _model.processedActivityList =
                await actions.processAndEnrichActivityFeed(
              (_model.getAllClients?.jsonBody ?? ''),
              (_model.getAllClientsActivity?.jsonBody ?? ''),
            );
            _model.recentActivityList = _model.processedActivityList!
                .toList()
                .cast<ActivityItemTypeStruct>();
            safeSetState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to get clients\' activities',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to get clients',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }

        Navigator.pop(context);
      } else {
        _model.paywallActive = true;
        safeSetState(() {});
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
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: AgentPaywallPopupWidget(
                    priceInUS: '\$49.99',
                    onSubscribe: () async {
                      _model.checkoutUrl1 =
                          await actions.initiateStripeCheckout(
                        'price_1SEsKaF0ZKEuePkEaBARjrOB',
                        'partnerpro://app.page/agentDashboard',
                        'partnerpro://app.page/agentDashboard',
                      );
                      if (_model.checkoutUrl1 != null &&
                          _model.checkoutUrl1 != '') {
                        await launchURL(_model.checkoutUrl1!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Something went wrong. Please try agein.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }
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
              ),
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: Align(
            alignment: AlignmentDirectional(1.0, 0.85),
            child: FloatingActionButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: InvitationSelectorSheetWidget(
                          onBuyer: () async {
                            context.pushNamed(BuyerInvitePageWidget.routeName);

                            Navigator.pop(context);
                          },
                          onAgent: () async {
                            context.pushNamed(AgentInvitePageWidget.routeName);

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              elevation: 8.0,
              child: Icon(
                Icons.add_sharp,
                color: FlutterFlowTheme.of(context).info,
                size: 32.0,
              ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Builder(
              builder: (context) => StreamBuilder<List<SubscriptionsRecord>>(
                stream: querySubscriptionsRecord(
                  parent: _model.customerDoc?.reference,
                  queryBuilder: (subscriptionsRecord) =>
                      subscriptionsRecord.where(
                    'status',
                    isEqualTo: 'active',
                  ),
                  singleRecord: true,
                )..listen((snapshot) {
                    List<SubscriptionsRecord> stackSubscriptionsRecordList =
                        snapshot;
                    final stackSubscriptionsRecord =
                        stackSubscriptionsRecordList.isNotEmpty
                            ? stackSubscriptionsRecordList.first
                            : null;
                    if (_model.stackPreviousSnapshot != null &&
                        !const ListEquality(
                                SubscriptionsRecordDocumentEquality())
                            .equals(stackSubscriptionsRecordList,
                                _model.stackPreviousSnapshot)) {
                      () async {
                        if (stackSubscriptionsRecord != null) {
                          if (_model.paywallActive) {
                            _model.paywallActive = false;
                            safeSetState(() {});
                            Navigator.pop(context);
                          }
                        } else {
                          _model.paywallActive = true;
                          safeSetState(() {});
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
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: AgentPaywallPopupWidget(
                                      priceInUS: '\$49.99',
                                      onSubscribe: () async {
                                        _model.checkoutUrl = await actions
                                            .initiateStripeCheckout(
                                          'price_1SEsKaF0ZKEuePkEaBARjrOB',
                                          'partnerpro://app.page/agentDashboard',
                                          'partnerpro://app.page/agentDashboard',
                                        );
                                        if (_model.checkoutUrl != null &&
                                            _model.checkoutUrl != '') {
                                          await launchURL(_model.checkoutUrl!);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Something went wrong. Please try agein.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                        }
                                      },
                                      onTry: () async {
                                        GoRouter.of(context).prepareAuthEvent();
                                        await authManager.signOut();
                                        GoRouter.of(context)
                                            .clearRedirectLocation();

                                        context.goNamedAuth(
                                            AuthOnboardWidget.routeName,
                                            context.mounted);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        safeSetState(() {});
                      }();
                    }
                    _model.stackPreviousSnapshot = snapshot;
                  }),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    );
                  }
                  List<SubscriptionsRecord> stackSubscriptionsRecordList =
                      snapshot.data!;
                  final stackSubscriptionsRecord =
                      stackSubscriptionsRecordList.isNotEmpty
                          ? stackSubscriptionsRecordList.first
                          : null;

                  return Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) => AuthUserStreamWidget(
                              builder: (context) => wrapWithModel(
                                model: _model.headerModel,
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: HeaderWidget(
                                  username: currentUserDisplayName,
                                  onSearch: () async {
                                    context
                                        .pushNamed(SearchListWidget.routeName);
                                  },
                                  onNotification: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: NotificationPopupWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  onProfile: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: ProfileSheetWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: wrapWithModel(
                              model: _model.agentRecentActivityModel,
                              updateCallback: () => safeSetState(() {}),
                              child: AgentRecentActivityWidget(
                                activities: _model.recentActivityList,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: wrapWithModel(
                          model: _model.agentBottomNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: AgentBottomNavbarWidget(
                            activeNav: AgentNavbar.Dashboard,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
