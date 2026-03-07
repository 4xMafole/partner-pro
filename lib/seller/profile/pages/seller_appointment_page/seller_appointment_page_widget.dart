import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/profile/components/seller_appoint_item/seller_appoint_item_widget.dart';
import '/seller/shared_components/warning_popup_card/warning_popup_card_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seller_appointment_page_model.dart';
export 'seller_appointment_page_model.dart';

class SellerAppointmentPageWidget extends StatefulWidget {
  const SellerAppointmentPageWidget({
    super.key,
    String? property,
  }) : this.property = property ?? '';

  final String property;

  static String routeName = 'seller_appointment_page';
  static String routePath = '/sellerAppointmentPage';

  @override
  State<SellerAppointmentPageWidget> createState() =>
      _SellerAppointmentPageWidgetState();
}

class _SellerAppointmentPageWidgetState
    extends State<SellerAppointmentPageWidget> with TickerProviderStateMixin {
  late SellerAppointmentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerAppointmentPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          if (widget!.property == null ||
                              widget!.property == '')
                            wrapWithModel(
                              model: _model.titleLabelModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: 'Appointments',
                              ),
                            ),
                          if (widget!.property != null &&
                              widget!.property != '')
                            wrapWithModel(
                              model: _model.titleLabelModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: widget!.property,
                              ),
                            ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: FlutterFlowButtonTabBar(
                          useToggleButtonStyle: true,
                          labelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          unselectedLabelStyle: TextStyle(),
                          labelColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).primaryText,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          unselectedBackgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          elevation: 0.0,
                          buttonMargin: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          padding: EdgeInsets.all(4.0),
                          tabs: [
                            Tab(
                              text: 'Upcoming',
                            ),
                            Tab(
                              text: 'Accepted',
                            ),
                            Tab(
                              text: 'Declined',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final upcomingAppointments = FFAppState()
                                        .sellerAppointments
                                        .where(
                                            (e) => e.status == Status.Pending)
                                        .toList();
                                    if (upcomingAppointments.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Your list is empty',
                                          description:
                                              'You have not received any appointment',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: upcomingAppointments.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, upcomingAppointmentsIndex) {
                                        final upcomingAppointmentsItem =
                                            upcomingAppointments[
                                                upcomingAppointmentsIndex];
                                        return Builder(
                                          builder: (context) => wrapWithModel(
                                            model: _model
                                                .sellerAppointItemModels1
                                                .getModel(
                                              upcomingAppointmentsIndex
                                                  .toString(),
                                              upcomingAppointmentsIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: SellerAppointItemWidget(
                                              key: Key(
                                                'Keyiul_${upcomingAppointmentsIndex.toString()}',
                                              ),
                                              status: Status.Pending,
                                              appointment:
                                                  upcomingAppointmentsItem,
                                              onAccept: () async {
                                                FFAppState()
                                                    .addToSellerInspections(
                                                        AppointmentStruct(
                                                  id: '42342',
                                                  property:
                                                      upcomingAppointmentsItem
                                                          .property,
                                                  date: DateTime
                                                      .fromMicrosecondsSinceEpoch(
                                                          1731358800000000),
                                                  status: Status.Pending,
                                                  type: AppointmentType
                                                      .Inspection,
                                                  price:
                                                      upcomingAppointmentsItem
                                                          .price,
                                                ));
                                                FFAppState()
                                                    .updateSellerAppointmentsAtIndex(
                                                  0,
                                                  (e) => e
                                                    ..status = Status.Accepted,
                                                );
                                                safeSetState(() {});
                                                await Future.delayed(
                                                  Duration(
                                                    milliseconds: 1000,
                                                  ),
                                                );
                                                FFAppState()
                                                    .addToSellerNotifications(
                                                        NotificationStruct(
                                                  id: 'dfasdfwe',
                                                  title:
                                                      'New Viewing Appointment Request!',
                                                  description:
                                                      'Good news! An interested buyer has requested an appointment to view your property.',
                                                  type:
                                                      SellerNotification.Offer,
                                                  createdAt:
                                                      getCurrentTimestamp,
                                                ));
                                                safeSetState(() {});
                                              },
                                              onDecline: () async {
                                                await showDialog(
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
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child:
                                                            WarningPopupCardWidget(
                                                          title:
                                                              'Declining Appointment?',
                                                          description:
                                                              'We will notify the buyer upon declining.',
                                                          buttonText: 'Confirm',
                                                          onConfirm: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final acceptedAppointments = FFAppState()
                                        .sellerAppointments
                                        .where(
                                            (e) => e.status == Status.Accepted)
                                        .toList();
                                    if (acceptedAppointments.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Your list is empty',
                                          description:
                                              'You have not accepted any appointment',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: acceptedAppointments.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, acceptedAppointmentsIndex) {
                                        final acceptedAppointmentsItem =
                                            acceptedAppointments[
                                                acceptedAppointmentsIndex];
                                        return wrapWithModel(
                                          model: _model.sellerAppointItemModels2
                                              .getModel(
                                            acceptedAppointmentsIndex
                                                .toString(),
                                            acceptedAppointmentsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SellerAppointItemWidget(
                                            key: Key(
                                              'Keybmq_${acceptedAppointmentsIndex.toString()}',
                                            ),
                                            status: Status.Accepted,
                                            appointment:
                                                acceptedAppointmentsItem,
                                            onAccept: () async {},
                                            onDecline: () async {},
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final declinedAppointments = FFAppState()
                                        .sellerAppointments
                                        .where(
                                            (e) => e.status == Status.Declined)
                                        .toList();
                                    if (declinedAppointments.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Your list is empty',
                                          description:
                                              'You have not declined any appointment',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: declinedAppointments.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, declinedAppointmentsIndex) {
                                        final declinedAppointmentsItem =
                                            declinedAppointments[
                                                declinedAppointmentsIndex];
                                        return wrapWithModel(
                                          model: _model.sellerAppointItemModels3
                                              .getModel(
                                            declinedAppointmentsIndex
                                                .toString(),
                                            declinedAppointmentsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SellerAppointItemWidget(
                                            key: Key(
                                              'Keyuw7_${declinedAppointmentsIndex.toString()}',
                                            ),
                                            status: Status.Declined,
                                            appointment:
                                                declinedAppointmentsItem,
                                            onAccept: () async {},
                                            onDecline: () async {},
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
