import '/agent/components/billing_item/billing_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'agent_subscription_model.dart';
export 'agent_subscription_model.dart';

class AgentSubscriptionWidget extends StatefulWidget {
  const AgentSubscriptionWidget({
    super.key,
    bool? isPopup,
  }) : isPopup = isPopup ?? false;

  final bool isPopup;

  static String routeName = 'agent_subscription';
  static String routePath = '/agentSubscription';

  @override
  State<AgentSubscriptionWidget> createState() =>
      _AgentSubscriptionWidgetState();
}

class _AgentSubscriptionWidgetState extends State<AgentSubscriptionWidget> {
  late AgentSubscriptionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentSubscriptionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
                label: 'Please Wait...',
              ),
            ),
          );
        },
      );

      _model.customerDoc = await queryCustomersRecordOnce(
        queryBuilder: (customersRecord) => customersRecord.where(
          'email',
          isEqualTo: currentUserEmail,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.subscriptionDoc = await querySubscriptionsRecordOnce(
        parent: _model.customerDoc?.reference,
        queryBuilder: (subscriptionsRecord) => subscriptionsRecord.where(
          'status',
          isEqualTo: 'active',
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.isActive = _model.subscriptionDoc != null;
      _model.isCancelled = _model.subscriptionDoc!.cancelAtPeriodEnd;
      safeSetState(() {});
      Navigator.pop(context);
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
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            iconTheme:
                IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
            automaticallyImplyLeading: true,
            title: Text(
              'Subscription',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineMediumFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Subscription',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0x34111417),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Monthly',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                            Text(
                                              '${valueOrDefault<String>(
                                                (int? var1) {
                                                  return var1 != null
                                                      ? '\$${(var1 / 100.0)
                                                              .toStringAsFixed(
                                                                  2)}'
                                                      : null;
                                                }(_model
                                                    .subscriptionDoc
                                                    ?.items
                                                    .firstOrNull
                                                    ?.plan
                                                    .amount),
                                                '\$49.99',
                                              )}/monthly',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 24.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: _model.isActive
                                              ? null
                                              : () async {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              CustomLoadingIndicatorWidget(
                                                            label:
                                                                'Redirecting...',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  // Stripe checkout removed - Sprint 1.2 (use RevenueCat)
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Subscriptions are now managed through RevenueCat.',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme.of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      ),
                                                      duration: Duration(milliseconds: 4000),
                                                      backgroundColor: FlutterFlowTheme.of(context).primary,
                                                    ),
                                                  );

                                                  Navigator.pop(context);

                                                  safeSetState(() {});
                                                },
                                          text: () {
                                            if (_model.isCancelled) {
                                              return 'Ends Soon';
                                            } else if (_model.isActive) {
                                              return 'Subscribed';
                                            } else {
                                              return 'Subscribe';
                                            }
                                          }(),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            disabledTextColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  if (!_model.isCancelled) {
                                    return Visibility(
                                      visible: (_model.subscriptionDoc
                                                  ?.currentPeriodEnd !=
                                              null) &&
                                          _model.isActive,
                                      child: Text(
                                        valueOrDefault<String>(
                                          'Renews on ${dateTimeFormat(
                                            "MMMMEEEEd",
                                            _model.subscriptionDoc
                                                ?.currentPeriodEnd,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          )}',
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelMediumIsCustom,
                                            ),
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      valueOrDefault<String>(
                                        'Subscription ends on ${dateTimeFormat(
                                          "MMMMEEEEd",
                                          _model.subscriptionDoc
                                              ?.currentPeriodEnd,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )}',
                                        'N/A',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                    );
                                  }
                                },
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 10.0)),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BILLING HISTORY',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<SubscriptionsRecord>>(
                            stream: querySubscriptionsRecord(
                              parent: _model.customerDoc?.reference,
                            )..listen((snapshot) {
                                List<SubscriptionsRecord>
                                    listViewSubscriptionsRecordList = snapshot;
                                if (_model.listViewPreviousSnapshot != null &&
                                    !const ListEquality(
                                            SubscriptionsRecordDocumentEquality())
                                        .equals(listViewSubscriptionsRecordList,
                                            _model.listViewPreviousSnapshot)) {
                                  () async {
                                    _model.isActive =
                                        listViewSubscriptionsRecordList
                                            .where((e) => e.status == 'active')
                                            .toList()
                                            .isNotEmpty;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  }();
                                }
                                _model.listViewPreviousSnapshot = snapshot;
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
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<SubscriptionsRecord>
                                  listViewSubscriptionsRecordList =
                                  snapshot.data!;
                              if (listViewSubscriptionsRecordList.isEmpty) {
                                return Center(
                                  child: EmptyListingWidget(
                                    title: 'Empty Listing',
                                    description: 'No billing history',
                                    onTap: () async {},
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    listViewSubscriptionsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewSubscriptionsRecord =
                                      listViewSubscriptionsRecordList[
                                          listViewIndex];
                                  return wrapWithModel(
                                    model: _model.billingItemModels.getModel(
                                      listViewSubscriptionsRecord.reference.id,
                                      listViewIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    updateOnChange: true,
                                    child: BillingItemWidget(
                                      key: Key(
                                        'Keydhd_${listViewSubscriptionsRecord.reference.id}',
                                      ),
                                      status:
                                          listViewSubscriptionsRecord.status,
                                      amount: valueOrDefault<String>(
                                        (int? var1) {
                                          return var1 != null
                                              ? '\$${(var1 / 100.00)
                                                      .toStringAsFixed(2)}'
                                              : null;
                                        }(listViewSubscriptionsRecord
                                            .items.firstOrNull?.plan.amount),
                                        '\$0.00',
                                      ),
                                      date: listViewSubscriptionsRecord
                                                  .currentPeriodStart !=
                                              null
                                          ? listViewSubscriptionsRecord
                                              .currentPeriodStart!
                                          : getCurrentTimestamp,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.isActive)
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              // Stripe portal removed - Sprint 1.2 (use RevenueCat)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Subscription management is now through RevenueCat.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                ),
                              );

                              safeSetState(() {});
                            },
                            text: 'Manage',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      if (!widget.isPopup && _model.isActive)
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.goNamed(FlowChooserPageWidget.routeName);
                            },
                            text: 'Continue',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
