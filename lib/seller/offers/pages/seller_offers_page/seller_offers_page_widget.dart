import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/offers/components/seller_counter_sheet/seller_counter_sheet_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seller_offers_page_model.dart';
export 'seller_offers_page_model.dart';

class SellerOffersPageWidget extends StatefulWidget {
  const SellerOffersPageWidget({
    super.key,
    this.propertyTitle,
  });

  final String? propertyTitle;

  static String routeName = 'seller_offers_page';
  static String routePath = '/sellerOffersPage';

  @override
  State<SellerOffersPageWidget> createState() => _SellerOffersPageWidgetState();
}

class _SellerOffersPageWidgetState extends State<SellerOffersPageWidget>
    with TickerProviderStateMixin {
  late SellerOffersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerOffersPageModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.propertyTitle != null && widget.propertyTitle != '')
                Padding(
                  padding: EdgeInsets.all(16.0),
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
                          wrapWithModel(
                            model: _model.titleLabelModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: TitleLabelWidget(
                              title: valueOrDefault<String>(
                                widget.propertyTitle,
                                'Property Title',
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ],
                  ),
                ),
              if (widget.propertyTitle == null || widget.propertyTitle == '')
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.titleLabelModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: TitleLabelWidget(
                      title: 'Offers',
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                                unselectedLabelStyle: TextStyle(),
                                labelColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                unselectedBackgroundColor:
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                borderWidth: 2.0,
                                borderRadius: 8.0,
                                elevation: 0.0,
                                buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                padding: EdgeInsets.all(4.0),
                                tabs: [
                                  Tab(
                                    text: 'Pending',
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
                                          final pendingOffers = FFAppState()
                                              .Offers
                                              .where((e) =>
                                                  e.status == Status.Pending)
                                              .toList();
                                          if (pendingOffers.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty List',
                                                description:
                                                    'No pending offers',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemCount: pendingOffers.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 10.0),
                                            itemBuilder:
                                                (context, pendingOffersIndex) {
                                              final pendingOffersItem =
                                                  pendingOffers[
                                                      pendingOffersIndex];
                                              return Builder(
                                                builder: (context) =>
                                                    wrapWithModel(
                                                  model: _model
                                                      .sellerOfferItemModels1
                                                      .getModel(
                                                    pendingOffersIndex
                                                        .toString(),
                                                    pendingOffersIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: SellerOfferItemWidget(
                                                    key: Key(
                                                      'Keyw9d_${pendingOffersIndex.toString()}',
                                                    ),
                                                    status: Status.Pending,
                                                    offerItem:
                                                        pendingOffersItem,
                                                    onTap: () async {
                                                      _model.offerIndexPending =
                                                          await actions
                                                              .indexOfOffer(
                                                        FFAppState()
                                                            .Offers
                                                            .toList(),
                                                        pendingOffersItem,
                                                      );

                                                      context.pushNamed(
                                                        OfferDetailsPageWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'offerStatus':
                                                              serializeParam(
                                                            Status.Pending,
                                                            ParamType.Enum,
                                                          ),
                                                          'newOffer':
                                                              serializeParam(
                                                            NewOfferStruct(),
                                                            ParamType
                                                                .DataStruct,
                                                          ),
                                                          'member':
                                                              serializeParam(
                                                            MemberStruct(),
                                                            ParamType
                                                                .DataStruct,
                                                          ),
                                                        }.withoutNulls,
                                                      );

                                                      safeSetState(() {});
                                                    },
                                                    onAccept: () async {
                                                      context.pushNamed(
                                                        SellerAddAddendumsPageWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'offer':
                                                              serializeParam(
                                                            pendingOffersItem,
                                                            ParamType
                                                                .DataStruct,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    onDecline: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  SellerCounterSheetWidget(
                                                                onCounter:
                                                                    (price) async {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                onDecline:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
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
                                          final acceptedOffers = FFAppState()
                                              .Offers
                                              .where((e) =>
                                                  e.status == Status.Accepted)
                                              .toList();
                                          if (acceptedOffers.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty List',
                                                description:
                                                    'No accepted offers',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemCount: acceptedOffers.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 10.0),
                                            itemBuilder:
                                                (context, acceptedOffersIndex) {
                                              final acceptedOffersItem =
                                                  acceptedOffers[
                                                      acceptedOffersIndex];
                                              return wrapWithModel(
                                                model: _model
                                                    .sellerOfferItemModels2
                                                    .getModel(
                                                  acceptedOffersIndex
                                                      .toString(),
                                                  acceptedOffersIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: SellerOfferItemWidget(
                                                  key: Key(
                                                    'Keyrtr_${acceptedOffersIndex.toString()}',
                                                  ),
                                                  status: Status.Accepted,
                                                  offerItem: acceptedOffersItem,
                                                  onTap: () async {
                                                    _model.offerIndexAccepted =
                                                        await actions
                                                            .indexOfOffer(
                                                      FFAppState()
                                                          .Offers
                                                          .toList(),
                                                      acceptedOffersItem,
                                                    );

                                                    context.pushNamed(
                                                      OfferDetailsPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'offerStatus':
                                                            serializeParam(
                                                          Status.Accepted,
                                                          ParamType.Enum,
                                                        ),
                                                        'newOffer':
                                                            serializeParam(
                                                          NewOfferStruct(),
                                                          ParamType.DataStruct,
                                                        ),
                                                        'member':
                                                            serializeParam(
                                                          MemberStruct(),
                                                          ParamType.DataStruct,
                                                        ),
                                                      }.withoutNulls,
                                                    );

                                                    safeSetState(() {});
                                                  },
                                                  onAccept: () async {
                                                    context.pushNamed(
                                                      SellerAddAddendumsPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'offer': serializeParam(
                                                          acceptedOffersItem,
                                                          ParamType.DataStruct,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
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
                                          final declinedOffers = FFAppState()
                                              .Offers
                                              .where((e) =>
                                                  e.status == Status.Declined)
                                              .toList();
                                          if (declinedOffers.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty List',
                                                description:
                                                    'No declined offers',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemCount: declinedOffers.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 10.0),
                                            itemBuilder:
                                                (context, declinedOffersIndex) {
                                              final declinedOffersItem =
                                                  declinedOffers[
                                                      declinedOffersIndex];
                                              return wrapWithModel(
                                                model: _model
                                                    .sellerOfferItemModels3
                                                    .getModel(
                                                  declinedOffersIndex
                                                      .toString(),
                                                  declinedOffersIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: SellerOfferItemWidget(
                                                  key: Key(
                                                    'Key8jc_${declinedOffersIndex.toString()}',
                                                  ),
                                                  status: Status.Declined,
                                                  offerItem: declinedOffersItem,
                                                  onTap: () async {
                                                    _model.offerIndexDeclined =
                                                        await actions
                                                            .indexOfOffer(
                                                      FFAppState()
                                                          .Offers
                                                          .toList(),
                                                      declinedOffersItem,
                                                    );

                                                    context.pushNamed(
                                                      OfferDetailsPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'offerStatus':
                                                            serializeParam(
                                                          Status.Declined,
                                                          ParamType.Enum,
                                                        ),
                                                        'newOffer':
                                                            serializeParam(
                                                          NewOfferStruct(),
                                                          ParamType.DataStruct,
                                                        ),
                                                        'member':
                                                            serializeParam(
                                                          MemberStruct(),
                                                          ParamType.DataStruct,
                                                        ),
                                                      }.withoutNulls,
                                                    );

                                                    safeSetState(() {});
                                                  },
                                                  onAccept: () async {
                                                    context.pushNamed(
                                                      SellerAddAddendumsPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'offer': serializeParam(
                                                          declinedOffersItem,
                                                          ParamType.DataStruct,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
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
              if (widget.propertyTitle == null || widget.propertyTitle == '')
                wrapWithModel(
                  model: _model.sellerBottomNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: SellerBottomNavbarWidget(
                    activeNav: SellerNavbar.Offers,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
