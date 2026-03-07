import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/profile/components/seller_appoint_item/seller_appoint_item_widget.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import '/seller/shared_components/warning_popup_card/warning_popup_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seller_inspection_page_model.dart';
export 'seller_inspection_page_model.dart';

class SellerInspectionPageWidget extends StatefulWidget {
  const SellerInspectionPageWidget({
    super.key,
    String? property,
  }) : property = property ?? '';

  final String property;

  static String routeName = 'seller_inspection_page';
  static String routePath = '/sellerInspectionPage';

  @override
  State<SellerInspectionPageWidget> createState() =>
      _SellerInspectionPageWidgetState();
}

class _SellerInspectionPageWidgetState extends State<SellerInspectionPageWidget>
    with TickerProviderStateMixin {
  late SellerInspectionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerInspectionPageModel());

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
                          if (widget.property == '')
                            wrapWithModel(
                              model: _model.titleLabelModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: 'Inspections',
                              ),
                            ),
                          if (widget.property != '')
                            wrapWithModel(
                              model: _model.titleLabelModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: TitleLabelWidget(
                                title: widget.property,
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
                                    final upcomingInspections = FFAppState()
                                        .sellerInspections
                                        .where(
                                            (e) => e.status == Status.Pending)
                                        .toList();
                                    if (upcomingInspections.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty List',
                                          description:
                                              'No inspection property received',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: upcomingInspections.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, upcomingInspectionsIndex) {
                                        final upcomingInspectionsItem =
                                            upcomingInspections[
                                                upcomingInspectionsIndex];
                                        return Builder(
                                          builder: (context) => wrapWithModel(
                                            model: _model
                                                .sellerAppointItemModels1
                                                .getModel(
                                              upcomingInspectionsIndex
                                                  .toString(),
                                              upcomingInspectionsIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: SellerAppointItemWidget(
                                              key: Key(
                                                'Key45j_${upcomingInspectionsIndex.toString()}',
                                              ),
                                              status: Status.Pending,
                                              appointment:
                                                  upcomingInspectionsItem,
                                              onAccept: () async {
                                                FFAppState()
                                                    .updateSellerInspectionsAtIndex(
                                                  0,
                                                  (e) => e
                                                    ..status = Status.Accepted,
                                                );
                                                FFAppState()
                                                    .updateOffersAtIndex(
                                                  0,
                                                  (e) => e
                                                    ..status = Status.Accepted,
                                                );
                                                safeSetState(() {});
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CongratsSheetWidget(
                                                          value:
                                                              'Offer completed successful. Transaction under process',
                                                          onDone: () async {
                                                            Navigator.pop(
                                                                context);
                                                            await Future
                                                                .delayed(
                                                              Duration(
                                                                milliseconds:
                                                                    1000,
                                                              ),
                                                            );
                                                            FFAppState()
                                                                .addToSellerNotifications(
                                                                    NotificationStruct(
                                                              id: '543534dfsda',
                                                              title:
                                                                  'New Inspection Request!',
                                                              description:
                                                                  'Good news! Your property is ready for inspection.',
                                                              type:
                                                                  SellerNotification
                                                                      .Offer,
                                                              createdAt:
                                                                  getCurrentTimestamp,
                                                            ));
                                                            safeSetState(() {});
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
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
                                    final acceptedInspections = FFAppState()
                                        .sellerInspections
                                        .where(
                                            (e) => e.status == Status.Accepted)
                                        .toList();
                                    if (acceptedInspections.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty List',
                                          description:
                                              'You have not accepted inspections yet',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: acceptedInspections.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, acceptedInspectionsIndex) {
                                        final acceptedInspectionsItem =
                                            acceptedInspections[
                                                acceptedInspectionsIndex];
                                        return wrapWithModel(
                                          model: _model.sellerAppointItemModels2
                                              .getModel(
                                            acceptedInspectionsIndex.toString(),
                                            acceptedInspectionsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SellerAppointItemWidget(
                                            key: Key(
                                              'Keyfpj_${acceptedInspectionsIndex.toString()}',
                                            ),
                                            status: Status.Accepted,
                                            appointment:
                                                acceptedInspectionsItem,
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
                                    final declinedInspections = FFAppState()
                                        .sellerInspections
                                        .where(
                                            (e) => e.status == Status.Declined)
                                        .toList();
                                    if (declinedInspections.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty List',
                                          description:
                                              'You have not declined any inspection',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: declinedInspections.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, declinedInspectionsIndex) {
                                        final declinedInspectionsItem =
                                            declinedInspections[
                                                declinedInspectionsIndex];
                                        return wrapWithModel(
                                          model: _model.sellerAppointItemModels3
                                              .getModel(
                                            declinedInspectionsIndex.toString(),
                                            declinedInspectionsIndex,
                                          ),
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SellerAppointItemWidget(
                                            key: Key(
                                              'Keya2f_${declinedInspectionsIndex.toString()}',
                                            ),
                                            status: Status.Declined,
                                            appointment:
                                                declinedInspectionsItem,
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
