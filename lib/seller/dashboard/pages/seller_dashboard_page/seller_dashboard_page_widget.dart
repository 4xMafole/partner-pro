import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/app_shared/components/walkthrough/info_card/info_card_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/dashboard/components/appointment/seller_prop_appoint_item/seller_prop_appoint_item_widget.dart';
import '/seller/dashboard/components/dash_overview_item/dash_overview_item_widget.dart';
import '/seller/dashboard/components/notification/seller_notification/seller_notification_widget.dart';
import '/seller/dashboard/components/notification_item/notification_item_widget.dart';
import '/seller/dashboard/components/seller_top_prop_item/seller_top_prop_item_widget.dart';
import '/walkthroughs/new_seller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'seller_dashboard_page_model.dart';
export 'seller_dashboard_page_model.dart';

class SellerDashboardPageWidget extends StatefulWidget {
  const SellerDashboardPageWidget({super.key});

  static String routeName = 'seller_dashboard_page';
  static String routePath = '/sellerDashboardPage';

  @override
  State<SellerDashboardPageWidget> createState() =>
      _SellerDashboardPageWidgetState();
}

class _SellerDashboardPageWidgetState extends State<SellerDashboardPageWidget> {
  late SellerDashboardPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerDashboardPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserDocument?.role == UserType.Seller) {
        if (FFAppState().sellerActiveWalkthrough) {
          safeSetState(() =>
              _model.newSellerController = createPageWalkthrough(context));
          _model.newSellerController?.show(context: context);
        }
      } else {
        context.pushNamed(
          SearchPageWidget.routeName,
          queryParameters: {
            'userType': serializeParam(
              UserType.Buyer,
              ParamType.Enum,
            ),
          }.withoutNulls,
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    currentUserDisplayName != ''
                                        ? 'Welcome $currentUserDisplayName'
                                        : 'Welcome',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Builder(
                              builder: (context) => wrapWithModel(
                                model: _model.notificationItemModel,
                                updateCallback: () => safeSetState(() {}),
                                child: NotificationItemWidget(
                                  isActive: functions.hasUnreadNotifications(
                                      FFAppState()
                                          .sellerNotifications
                                          .toList())!,
                                  onTap: () async {
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
                                            child: SellerNotificationWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            18.0, 0.0, 18.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              SellerAddPropertyPageWidget.routeName,
                              queryParameters: {
                                'pageType': serializeParam(
                                  PropertyAddPage.Add,
                                  ParamType.Enum,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.leftToRight,
                                ),
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.house_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 100.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'List your property now!',
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .titleMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).addWalkthrough(
                          containerSygszl1t,
                          _model.newSellerController,
                        ),
                      ),
                      wrapWithModel(
                        model: _model.infoCardModel,
                        updateCallback: () => safeSetState(() {}),
                        child: InfoCardWidget(
                          text: 'Learn how to navigate the app',
                          icon: null,
                          onTap: () async {
                            safeSetState(() => _model.newSellerController =
                                createPageWalkthrough(context));
                            _model.newSellerController?.show(context: context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: wrapWithModel(
                                    model: _model.dashOverviewItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DashOverviewItemWidget(
                                      icon: Icon(
                                        Icons.villa,
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        size: 24.0,
                                      ),
                                      color: Color(0x38003087),
                                      label: 'Properties',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: wrapWithModel(
                                    model: _model.dashOverviewItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DashOverviewItemWidget(
                                      icon: Icon(
                                        Icons.people_alt_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .accent3,
                                        size: 24.0,
                                      ),
                                      color: Color(0x32388C00),
                                      label: 'Views',
                                      value: FFAppState()
                                          .sellerPropertyViewCount
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 20.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: wrapWithModel(
                                    model: _model.dashOverviewItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DashOverviewItemWidget(
                                      icon: Icon(
                                        Icons.local_offer,
                                        color: FlutterFlowTheme.of(context)
                                            .accent4,
                                        size: 24.0,
                                      ),
                                      color: Color(0x3B7252CC),
                                      label: 'Offers',
                                      value:
                                          FFAppState().Offers.length.toString(),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: wrapWithModel(
                                    model: _model.dashOverviewItemModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DashOverviewItemWidget(
                                      icon: Icon(
                                        Icons.people_alt_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      color: Color(0x39484848),
                                      label: 'Appointments',
                                      value: FFAppState()
                                          .sellerAppointments
                                          .length
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 20.0)),
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      ),
                      if (false)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Top Properties',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleLargeFamily,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleLargeIsCustom,
                                        ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        SellerTopSearchesPropertiesWidget
                                            .routeName,
                                        queryParameters: {
                                          'pageType': serializeParam(
                                            PropertyPage.Top,
                                            ParamType.Enum,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Text(
                                      'View All',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final topProperties = FFAppState()
                                    .sellerTopProperties
                                    .toList()
                                    .take(4)
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children:
                                        List.generate(topProperties.length,
                                            (topPropertiesIndex) {
                                      final topPropertiesItem =
                                          topProperties[topPropertiesIndex];
                                      return wrapWithModel(
                                        model: _model.sellerTopPropItemModels
                                            .getModel(
                                          topPropertiesIndex.toString(),
                                          topPropertiesIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SellerTopPropItemWidget(
                                          key: Key(
                                            'Keyvg1_${topPropertiesIndex.toString()}',
                                          ),
                                          property: topPropertiesItem,
                                        ),
                                      );
                                    }).divide(SizedBox(width: 10.0)),
                                  ),
                                );
                              },
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      if (false)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Upcoming Appointments',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleLargeFamily,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleLargeIsCustom,
                                        ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          SellerAppointmentPageWidget
                                              .routeName);
                                    },
                                    child: Text(
                                      'View All',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .accent1,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                final appointments = FFAppState()
                                    .sellerAppointments
                                    .toList()
                                    .take(4)
                                    .toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(appointments.length,
                                        (appointmentsIndex) {
                                      final appointmentsItem =
                                          appointments[appointmentsIndex];
                                      return wrapWithModel(
                                        model: _model
                                            .sellerPropAppointItemModels
                                            .getModel(
                                          appointmentsIndex.toString(),
                                          appointmentsIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SellerPropAppointItemWidget(
                                          key: Key(
                                            'Keyzgs_${appointmentsIndex.toString()}',
                                          ),
                                          appointment: appointmentsItem,
                                        ),
                                      );
                                    }).divide(SizedBox(width: 10.0)),
                                  ),
                                );
                              },
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                    ].divide(SizedBox(height: 25.0)),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.sellerBottomNavbarModel,
                updateCallback: () => safeSetState(() {}),
                child: SellerBottomNavbarWidget(
                  activeNav: SellerNavbar.Dashboard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TutorialCoachMark createPageWalkthrough(BuildContext context) =>
      TutorialCoachMark(
        targets: createWalkthroughTargets(context),
        onFinish: () async {
          safeSetState(() => _model.newSellerController = null);
          FFAppState().sellerActiveWalkthrough = false;
        },
        onSkip: () {
          () async {
            FFAppState().sellerActiveWalkthrough = false;
          }();
          return true;
        },
      );
}
