import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/offers/components/seller_counter_sheet/seller_counter_sheet_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'agent_offers_model.dart';
export 'agent_offers_model.dart';

class AgentOffersWidget extends StatefulWidget {
  const AgentOffersWidget({
    super.key,
    bool? isOffer,
  }) : this.isOffer = isOffer ?? false;

  final bool isOffer;

  static String routeName = 'agent_offers';
  static String routePath = '/agentOffers';

  @override
  State<AgentOffersWidget> createState() => _AgentOffersWidgetState();
}

class _AgentOffersWidgetState extends State<AgentOffersWidget>
    with TickerProviderStateMixin {
  late AgentOffersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentOffersModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await action_blocks.hasActiveSubscription(context);
      safeSetState(() {});
    });

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
    return GestureDetector(
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
          automaticallyImplyLeading: false,
          title: Text(
            'Offers',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleMediumIsCustom,
                                    ),
                                unselectedLabelStyle: TextStyle(),
                                labelColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                unselectedBackgroundColor: Color(0x2D484848),
                                borderColor: Color(0x2D484848),
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
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: (_model.apiRequestCompleter2 ??=
                                                Completer<ApiCallResponse>()
                                                  ..complete(IwoOffersGroup
                                                      .getOfferByRequesterIdCall
                                                      .call(
                                                    requesterId: currentUserUid,
                                                  )))
                                            .future,
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final listViewGetOfferByRequesterIdResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final pendingOffers =
                                                  (listViewGetOfferByRequesterIdResponse
                                                                  .jsonBody
                                                                  .toList()
                                                                  .map<NewOfferStruct?>(
                                                                      NewOfferStruct
                                                                          .maybeFromMap)
                                                                  .toList()
                                                              as Iterable<
                                                                  NewOfferStruct?>)
                                                          .withoutNulls
                                                          ?.where((e) =>
                                                              e.status ==
                                                              Status
                                                                  .Pending.name)
                                                          .toList()
                                                          ?.sortedList(
                                                              keyOf: (e) =>
                                                                  e.createdTime,
                                                              desc: true)
                                                          ?.toList() ??
                                                      [];
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

                                              return RefreshIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter2 =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted2();
                                                },
                                                child: ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      pendingOffers.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 20.0),
                                                  itemBuilder: (context,
                                                      pendingOffersIndex) {
                                                    final pendingOffersItem =
                                                        pendingOffers[
                                                            pendingOffersIndex];
                                                    return Builder(
                                                      builder: (context) =>
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            wrapWithModel(
                                                          model: _model
                                                              .sellerOfferItemModels1
                                                              .getModel(
                                                            pendingOffersItem
                                                                .id,
                                                            pendingOffersIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              SellerOfferItemWidget(
                                                            key: Key(
                                                              'Keydki_${pendingOffersItem.id}',
                                                            ),
                                                            status:
                                                                Status.Pending,
                                                            offerItem:
                                                                OfferStruct(
                                                              id: pendingOffersItem
                                                                  .id,
                                                              property:
                                                                  PropertyStruct(
                                                                id: pendingOffersItem
                                                                    .property
                                                                    .id,
                                                                propertyType:
                                                                    pendingOffersItem
                                                                        .property
                                                                        .propertyType,
                                                                title: functions.formatAddressFromModel(
                                                                    pendingOffersItem
                                                                        .property
                                                                        .address,
                                                                    ''),
                                                                beds: pendingOffersItem
                                                                    .property
                                                                    .bedrooms
                                                                    .toString(),
                                                                baths: pendingOffersItem
                                                                    .property
                                                                    .bathrooms
                                                                    .toString(),
                                                                sqft: pendingOffersItem
                                                                    .property
                                                                    .squareFootage
                                                                    .toString(),
                                                                price: pendingOffersItem
                                                                    .property
                                                                    .listPrice,
                                                                images:
                                                                    pendingOffersItem
                                                                        .property
                                                                        .media,
                                                              ),
                                                              listPrice:
                                                                  pendingOffersItem
                                                                      .pricing
                                                                      .listPrice
                                                                      .toString(),
                                                              purchasePrice:
                                                                  pendingOffersItem
                                                                      .pricing
                                                                      .purchasePrice,
                                                              buyer:
                                                                  BuyerStruct(
                                                                id: pendingOffersItem
                                                                    .parties
                                                                    .buyer
                                                                    .id,
                                                                name:
                                                                    pendingOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .name,
                                                                phoneNumber:
                                                                    pendingOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .phoneNumber,
                                                                email:
                                                                    pendingOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .email,
                                                              ),
                                                            ),
                                                            isAgent:
                                                                currentUserDocument
                                                                        ?.role ==
                                                                    UserType
                                                                        .Agent,
                                                            onTap: () async {
                                                              FFAppState()
                                                                      .tempOfferCompare =
                                                                  pendingOffersItem;
                                                              safeSetState(
                                                                  () {});

                                                              context.pushNamed(
                                                                OfferDetailsPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'offerStatus':
                                                                      serializeParam(
                                                                    Status
                                                                        .Pending,
                                                                    ParamType
                                                                        .Enum,
                                                                  ),
                                                                  'newOffer':
                                                                      serializeParam(
                                                                    pendingOffersItem,
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                  'member':
                                                                      serializeParam(
                                                                    MemberStruct(
                                                                      clientID: pendingOffersItem
                                                                          .parties
                                                                          .buyer
                                                                          .id,
                                                                    ),
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            onAccept:
                                                                () async {},
                                                            onDecline:
                                                                () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
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
                                                                    child:
                                                                        Padding(
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
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: (_model.apiRequestCompleter1 ??=
                                                Completer<ApiCallResponse>()
                                                  ..complete(IwoOffersGroup
                                                      .getOfferByRequesterIdCall
                                                      .call(
                                                    requesterId: currentUserUid,
                                                  )))
                                            .future,
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final listViewGetOfferByRequesterIdResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final acceptedOffers =
                                                  (listViewGetOfferByRequesterIdResponse
                                                                  .jsonBody
                                                                  .toList()
                                                                  .map<NewOfferStruct?>(
                                                                      NewOfferStruct
                                                                          .maybeFromMap)
                                                                  .toList()
                                                              as Iterable<
                                                                  NewOfferStruct?>)
                                                          .withoutNulls
                                                          ?.where(
                                                              (e) =>
                                                                  e.status ==
                                                                  Status
                                                                      .Accepted
                                                                      .name)
                                                          .toList()
                                                          ?.sortedList(
                                                              keyOf: (e) =>
                                                                  e.createdTime,
                                                              desc: true)
                                                          ?.toList() ??
                                                      [];
                                              if (acceptedOffers.isEmpty) {
                                                return Center(
                                                  child: EmptyListingWidget(
                                                    title: 'Empty List',
                                                    description:
                                                        'No pending offers',
                                                    onTap: () async {},
                                                  ),
                                                );
                                              }

                                              return RefreshIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter1 =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted1();
                                                },
                                                child: ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      acceptedOffers.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 20.0),
                                                  itemBuilder: (context,
                                                      acceptedOffersIndex) {
                                                    final acceptedOffersItem =
                                                        acceptedOffers[
                                                            acceptedOffersIndex];
                                                    return Builder(
                                                      builder: (context) =>
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            wrapWithModel(
                                                          model: _model
                                                              .sellerOfferItemModels2
                                                              .getModel(
                                                            acceptedOffersItem
                                                                .id,
                                                            acceptedOffersIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              SellerOfferItemWidget(
                                                            key: Key(
                                                              'Keyyjg_${acceptedOffersItem.id}',
                                                            ),
                                                            status:
                                                                Status.Accepted,
                                                            offerItem:
                                                                OfferStruct(
                                                              id: acceptedOffersItem
                                                                  .id,
                                                              property:
                                                                  PropertyStruct(
                                                                id: acceptedOffersItem
                                                                    .property
                                                                    .id,
                                                                propertyType:
                                                                    acceptedOffersItem
                                                                        .property
                                                                        .propertyType,
                                                                title: functions.formatAddressFromModel(
                                                                    acceptedOffersItem
                                                                        .property
                                                                        .address,
                                                                    ''),
                                                                beds: acceptedOffersItem
                                                                    .property
                                                                    .bedrooms
                                                                    .toString(),
                                                                baths: acceptedOffersItem
                                                                    .property
                                                                    .bathrooms
                                                                    .toString(),
                                                                sqft: acceptedOffersItem
                                                                    .property
                                                                    .squareFootage
                                                                    .toString(),
                                                                price: acceptedOffersItem
                                                                    .property
                                                                    .listPrice,
                                                                images:
                                                                    acceptedOffersItem
                                                                        .property
                                                                        .media,
                                                              ),
                                                              listPrice:
                                                                  acceptedOffersItem
                                                                      .pricing
                                                                      .listPrice
                                                                      .toString(),
                                                              purchasePrice:
                                                                  acceptedOffersItem
                                                                      .pricing
                                                                      .purchasePrice,
                                                              buyer:
                                                                  BuyerStruct(
                                                                id: acceptedOffersItem
                                                                    .parties
                                                                    .buyer
                                                                    .id,
                                                                name:
                                                                    acceptedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .name,
                                                                phoneNumber:
                                                                    acceptedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .phoneNumber,
                                                                email:
                                                                    acceptedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .email,
                                                              ),
                                                            ),
                                                            isAgent:
                                                                currentUserDocument
                                                                        ?.role ==
                                                                    UserType
                                                                        .Agent,
                                                            onTap: () async {
                                                              FFAppState()
                                                                      .tempOfferCompare =
                                                                  acceptedOffersItem;
                                                              safeSetState(
                                                                  () {});

                                                              context.pushNamed(
                                                                OfferDetailsPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'offerStatus':
                                                                      serializeParam(
                                                                    Status
                                                                        .Accepted,
                                                                    ParamType
                                                                        .Enum,
                                                                  ),
                                                                  'newOffer':
                                                                      serializeParam(
                                                                    acceptedOffersItem,
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                  'member':
                                                                      serializeParam(
                                                                    MemberStruct(
                                                                      clientID: acceptedOffersItem
                                                                          .parties
                                                                          .buyer
                                                                          .id,
                                                                    ),
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            onAccept:
                                                                () async {},
                                                            onDecline:
                                                                () async {},
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: (_model.apiRequestCompleter3 ??=
                                                Completer<ApiCallResponse>()
                                                  ..complete(IwoOffersGroup
                                                      .getOfferByRequesterIdCall
                                                      .call(
                                                    requesterId: currentUserUid,
                                                  )))
                                            .future,
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final listViewGetOfferByRequesterIdResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final declinedOffers =
                                                  (listViewGetOfferByRequesterIdResponse
                                                                  .jsonBody
                                                                  .toList()
                                                                  .map<NewOfferStruct?>(
                                                                      NewOfferStruct
                                                                          .maybeFromMap)
                                                                  .toList()
                                                              as Iterable<
                                                                  NewOfferStruct?>)
                                                          .withoutNulls
                                                          ?.where(
                                                              (e) =>
                                                                  e.status ==
                                                                  Status
                                                                      .Declined
                                                                      .name)
                                                          .toList()
                                                          ?.sortedList(
                                                              keyOf: (e) =>
                                                                  e.createdTime,
                                                              desc: true)
                                                          ?.toList() ??
                                                      [];
                                              if (declinedOffers.isEmpty) {
                                                return Center(
                                                  child: EmptyListingWidget(
                                                    title: 'Empty List',
                                                    description:
                                                        'No pending offers',
                                                    onTap: () async {},
                                                  ),
                                                );
                                              }

                                              return RefreshIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter3 =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted3();
                                                },
                                                child: ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      declinedOffers.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 20.0),
                                                  itemBuilder: (context,
                                                      declinedOffersIndex) {
                                                    final declinedOffersItem =
                                                        declinedOffers[
                                                            declinedOffersIndex];
                                                    return Builder(
                                                      builder: (context) =>
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            wrapWithModel(
                                                          model: _model
                                                              .sellerOfferItemModels3
                                                              .getModel(
                                                            declinedOffersItem
                                                                .id,
                                                            declinedOffersIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              SellerOfferItemWidget(
                                                            key: Key(
                                                              'Key5fg_${declinedOffersItem.id}',
                                                            ),
                                                            status:
                                                                Status.Declined,
                                                            offerItem:
                                                                OfferStruct(
                                                              id: declinedOffersItem
                                                                  .id,
                                                              property:
                                                                  PropertyStruct(
                                                                id: declinedOffersItem
                                                                    .property
                                                                    .id,
                                                                propertyType:
                                                                    declinedOffersItem
                                                                        .property
                                                                        .propertyType,
                                                                title: functions.formatAddressFromModel(
                                                                    declinedOffersItem
                                                                        .property
                                                                        .address,
                                                                    ''),
                                                                beds: declinedOffersItem
                                                                    .property
                                                                    .bedrooms
                                                                    .toString(),
                                                                baths: declinedOffersItem
                                                                    .property
                                                                    .bathrooms
                                                                    .toString(),
                                                                sqft: declinedOffersItem
                                                                    .property
                                                                    .squareFootage
                                                                    .toString(),
                                                                price: declinedOffersItem
                                                                    .property
                                                                    .listPrice,
                                                                images:
                                                                    declinedOffersItem
                                                                        .property
                                                                        .media,
                                                              ),
                                                              listPrice:
                                                                  declinedOffersItem
                                                                      .pricing
                                                                      .listPrice
                                                                      .toString(),
                                                              purchasePrice:
                                                                  declinedOffersItem
                                                                      .pricing
                                                                      .purchasePrice,
                                                              buyer:
                                                                  BuyerStruct(
                                                                id: declinedOffersItem
                                                                    .parties
                                                                    .buyer
                                                                    .id,
                                                                name:
                                                                    declinedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .name,
                                                                phoneNumber:
                                                                    declinedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .phoneNumber,
                                                                email:
                                                                    declinedOffersItem
                                                                        .parties
                                                                        .buyer
                                                                        .email,
                                                              ),
                                                            ),
                                                            isAgent:
                                                                currentUserDocument
                                                                        ?.role ==
                                                                    UserType
                                                                        .Agent,
                                                            onTap: () async {
                                                              FFAppState()
                                                                      .tempOfferCompare =
                                                                  declinedOffersItem;
                                                              safeSetState(
                                                                  () {});

                                                              context.pushNamed(
                                                                OfferDetailsPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'offerStatus':
                                                                      serializeParam(
                                                                    Status
                                                                        .Declined,
                                                                    ParamType
                                                                        .Enum,
                                                                  ),
                                                                  'newOffer':
                                                                      serializeParam(
                                                                    declinedOffersItem,
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                  'member':
                                                                      serializeParam(
                                                                    MemberStruct(
                                                                      clientID: declinedOffersItem
                                                                          .parties
                                                                          .buyer
                                                                          .id,
                                                                    ),
                                                                    ParamType
                                                                        .DataStruct,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            onAccept:
                                                                () async {},
                                                            onDecline:
                                                                () async {},
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                    ].divide(SizedBox(height: 10.0)),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.agentBottomNavbarModel,
                updateCallback: () => safeSetState(() {}),
                child: AgentBottomNavbarWidget(
                  activeNav: AgentNavbar.Offers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
