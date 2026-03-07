import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/schedule_tour_sheet/schedule_tour_sheet_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/schedule_card_component_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'scheduled_showings_page_model.dart';
export 'scheduled_showings_page_model.dart';

class ScheduledShowingsPageWidget extends StatefulWidget {
  const ScheduledShowingsPageWidget({super.key});

  static String routeName = 'scheduled_showings_page';
  static String routePath = '/scheduledShowingsPage';

  @override
  State<ScheduledShowingsPageWidget> createState() =>
      _ScheduledShowingsPageWidgetState();
}

class _ScheduledShowingsPageWidgetState
    extends State<ScheduledShowingsPageWidget> with TickerProviderStateMixin {
  late ScheduledShowingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduledShowingsPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
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
                        Text(
                          'Scheduled Showings',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
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
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          unselectedLabelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          unselectedBackgroundColor: Color(0x2D484848),
                          borderColor: Color(0x2D484848),
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          elevation: 0.0,
                          buttonMargin: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          tabs: [
                            Tab(
                              text: 'Pending',
                            ),
                            Tab(
                              text: 'Booked',
                            ),
                            Tab(
                              text: 'Expired',
                            ),
                            Tab(
                              text: 'Cancelled',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [
                              () async {},
                              () async {},
                              () async {},
                              () async {}
                            ][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            FutureBuilder<ApiCallResponse>(
                              future: IwoUsersShowpropertyApiGroup
                                  .getShowPropertiesCall
                                  .call(
                                userId: currentUserUid,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetShowPropertiesResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final showingPending = functions
                                        .parseShowingsResponse(
                                            listViewGetShowPropertiesResponse
                                                .jsonBody)
                                        .map((e) =>
                                            ShowamiStruct.maybeFromMap(e))
                                        .withoutNulls
                                        .toList()
                                        .where((e) =>
                                            e.status &&
                                            !e.isCancelled &&
                                            !e.isRescheduled &&
                                            functions.isPayButtonEnabled(
                                                functions.convertToDateTime(
                                                    e.showingDate)!))
                                        .toList();
                                    if (showingPending.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty Listing',
                                          description: 'No scheduled showings ',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: showingPending.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, showingPendingIndex) {
                                        final showingPendingItem =
                                            showingPending[showingPendingIndex];
                                        return Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: wrapWithModel(
                                              model: _model
                                                  .scheduleCardComponentModels1
                                                  .getModel(
                                                showingPendingItem.showingId
                                                    .toString(),
                                                showingPendingIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child:
                                                  ScheduleCardComponentWidget(
                                                key: Key(
                                                  'Keyxei_${showingPendingItem.showingId.toString()}',
                                                ),
                                                showActions: true,
                                                appointmentData:
                                                    AppointmentStruct(
                                                  id: showingPendingItem
                                                      .showingId
                                                      .toString(),
                                                  date: functions
                                                      .convertToDateTime(
                                                          showingPendingItem
                                                              .showingDate),
                                                  status: Status.Pending,
                                                  address: showingPendingItem
                                                      .address.line1,
                                                  price:
                                                      showingPendingItem.price,
                                                  photo: showingPendingItem
                                                      .address.line2,
                                                ),
                                                onCancel: () async {
                                                  _model.deleteShowProperty =
                                                      await IwoUsersShowpropertyApiGroup
                                                          .deleteShowPropertyCall
                                                          .call(
                                                    userId: currentUserUid,
                                                    showingId:
                                                        showingPendingItem
                                                            .showingId
                                                            .toString(),
                                                  );

                                                  if ((_model.deleteShowProperty
                                                          ?.succeeded ??
                                                      true)) {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
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
                                                                CustomDialogWidget(
                                                              icon: Icon(
                                                                Icons.home,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                size: 32.0,
                                                              ),
                                                              title:
                                                                  'Property Tour',
                                                              description:
                                                                  'You have successfully managed to cancel a property tour.',
                                                              buttonLabel:
                                                                  'Continue',
                                                              iconBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .success,
                                                              onDone:
                                                                  () async {},
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
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
                                                                CustomDialogWidget(
                                                              icon: Icon(
                                                                Icons.home,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                size: 32.0,
                                                              ),
                                                              title:
                                                                  'Reschedule Property Tour',
                                                              description:
                                                                  'Failed to delete scheduled showing!',
                                                              buttonLabel:
                                                                  'Continue',
                                                              iconBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                              onDone:
                                                                  () async {},
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }

                                                  safeSetState(() {});
                                                },
                                                onReschedule: () async {},
                                                onPay: () async {},
                                                onTap: () async {},
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: IwoUsersShowpropertyApiGroup
                                  .getShowPropertiesCall
                                  .call(
                                userId: currentUserUid,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetShowPropertiesResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final showingBooked = functions
                                        .parseShowingsResponse(
                                            listViewGetShowPropertiesResponse
                                                .jsonBody)
                                        .map((e) =>
                                            ShowamiStruct.maybeFromMap(e))
                                        .withoutNulls
                                        .toList()
                                        .where((e) =>
                                            !e.status &&
                                            !e.isCancelled &&
                                            functions.isPayButtonEnabled(
                                                functions.convertToDateTime(
                                                    e.showingDate)!))
                                        .toList();
                                    if (showingBooked.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty Listing',
                                          description: 'No scheduled showings ',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: showingBooked.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, showingBookedIndex) {
                                        final showingBookedItem =
                                            showingBooked[showingBookedIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: wrapWithModel(
                                            model: _model
                                                .scheduleCardComponentModels2
                                                .getModel(
                                              showingBookedItem.showingId
                                                  .toString(),
                                              showingBookedIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ScheduleCardComponentWidget(
                                              key: Key(
                                                'Key6qv_${showingBookedItem.showingId.toString()}',
                                              ),
                                              showActions: false,
                                              appointmentData:
                                                  AppointmentStruct(
                                                id: showingBookedItem.showingId
                                                    .toString(),
                                                date:
                                                    functions.convertToDateTime(
                                                        showingBookedItem
                                                            .showingDate),
                                                status: Status.Pending,
                                                address: showingBookedItem
                                                    .address.line1,
                                                price: showingBookedItem.price,
                                                photo: showingBookedItem
                                                    .address.line2,
                                              ),
                                              onCancel: () async {},
                                              onReschedule: () async {},
                                              onPay: () async {},
                                              onTap: () async {},
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: IwoUsersShowpropertyApiGroup
                                  .getShowPropertiesCall
                                  .call(
                                userId: currentUserUid,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetShowPropertiesResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final showingExpired = functions
                                        .parseShowingsResponse(
                                            listViewGetShowPropertiesResponse
                                                .jsonBody)
                                        .map((e) =>
                                            ShowamiStruct.maybeFromMap(e))
                                        .withoutNulls
                                        .toList()
                                        .where((e) =>
                                            e.status &&
                                            !e.isCancelled &&
                                            !e.isRescheduled &&
                                            !functions.isPayButtonEnabled(
                                                functions.convertToDateTime(
                                                    e.showingDate)!))
                                        .toList();
                                    if (showingExpired.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty Listing',
                                          description: 'No scheduled showings ',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: showingExpired.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, showingExpiredIndex) {
                                        final showingExpiredItem =
                                            showingExpired[showingExpiredIndex];
                                        return Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: wrapWithModel(
                                              model: _model
                                                  .scheduleCardComponentModels3
                                                  .getModel(
                                                showingExpiredItem.showingId
                                                    .toString(),
                                                showingExpiredIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child:
                                                  ScheduleCardComponentWidget(
                                                key: Key(
                                                  'Keygry_${showingExpiredItem.showingId.toString()}',
                                                ),
                                                showActions: true,
                                                appointmentData:
                                                    AppointmentStruct(
                                                  id: showingExpiredItem
                                                      .showingId
                                                      .toString(),
                                                  date: functions
                                                      .convertToDateTime(
                                                          showingExpiredItem
                                                              .showingDate),
                                                  status: Status.Pending,
                                                  address: showingExpiredItem
                                                      .address.line1,
                                                  price:
                                                      showingExpiredItem.price,
                                                  photo: showingExpiredItem
                                                      .address.line2,
                                                ),
                                                onCancel: () async {},
                                                onReschedule: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    useSafeArea: true,
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
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                1.0,
                                                            child:
                                                                ScheduleTourSheetWidget(
                                                              onApprove:
                                                                  (showingDate) async {
                                                                var showamiRecordReference =
                                                                    ShowamiRecord
                                                                        .createDoc(
                                                                            currentUserReference!);
                                                                await showamiRecordReference
                                                                    .set(
                                                                        createShowamiRecordData(
                                                                  showami:
                                                                      updateShowamiStruct(
                                                                    ShowamiStruct(
                                                                      userId:
                                                                          currentUserUid,
                                                                      showingDate:
                                                                          dateTimeFormat(
                                                                        "yyyy-MM-dd\'T\'HH:mm:ss",
                                                                        showingDate,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ),
                                                                      address:
                                                                          AddressStruct(
                                                                        line1: showingExpiredItem
                                                                            .address
                                                                            .line1,
                                                                        line2: showingExpiredItem
                                                                            .address
                                                                            .line2,
                                                                        city: showingExpiredItem
                                                                            .address
                                                                            .city,
                                                                        state: showingExpiredItem
                                                                            .address
                                                                            .state,
                                                                        zip: showingExpiredItem
                                                                            .address
                                                                            .zip,
                                                                      ),
                                                                      propertyId:
                                                                          showingExpiredItem
                                                                              .propertyId,
                                                                      createdAt:
                                                                          getCurrentTimestamp
                                                                              .toString(),
                                                                    ),
                                                                    clearUnsetFields:
                                                                        false,
                                                                    create:
                                                                        true,
                                                                  ),
                                                                ));
                                                                _model.newShowami =
                                                                    ShowamiRecord.getDocumentFromData(
                                                                        createShowamiRecordData(
                                                                          showami:
                                                                              updateShowamiStruct(
                                                                            ShowamiStruct(
                                                                              userId: currentUserUid,
                                                                              showingDate: dateTimeFormat(
                                                                                "yyyy-MM-dd\'T\'HH:mm:ss",
                                                                                showingDate,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              address: AddressStruct(
                                                                                line1: showingExpiredItem.address.line1,
                                                                                line2: showingExpiredItem.address.line2,
                                                                                city: showingExpiredItem.address.city,
                                                                                state: showingExpiredItem.address.state,
                                                                                zip: showingExpiredItem.address.zip,
                                                                              ),
                                                                              propertyId: showingExpiredItem.propertyId,
                                                                              createdAt: getCurrentTimestamp.toString(),
                                                                            ),
                                                                            clearUnsetFields:
                                                                                false,
                                                                            create:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                        showamiRecordReference);
                                                                _model.clientRelationDoc =
                                                                    await queryRelationshipsRecordOnce(
                                                                  queryBuilder:
                                                                      (relationshipsRecord) =>
                                                                          relationshipsRecord
                                                                              .where(
                                                                    'relationship.subjectUid',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                                  singleRecord:
                                                                      true,
                                                                ).then((s) => s
                                                                        .firstOrNull);
                                                                _model.agentDoc =
                                                                    await queryUsersRecordOnce(
                                                                  queryBuilder:
                                                                      (usersRecord) =>
                                                                          usersRecord
                                                                              .where(
                                                                    'uid',
                                                                    isEqualTo: _model
                                                                        .clientRelationDoc
                                                                        ?.relationship
                                                                        ?.agentUid,
                                                                  ),
                                                                  singleRecord:
                                                                      true,
                                                                ).then((s) => s
                                                                        .firstOrNull);
                                                                _model.agentStripe =
                                                                    await queryCustomersRecordOnce(
                                                                  queryBuilder:
                                                                      (customersRecord) =>
                                                                          customersRecord
                                                                              .where(
                                                                    'email',
                                                                    isEqualTo: _model
                                                                        .agentDoc
                                                                        ?.email,
                                                                  ),
                                                                  singleRecord:
                                                                      true,
                                                                ).then((s) => s
                                                                        .firstOrNull);
                                                                _model.showamiPP =
                                                                    ShowingPartnerProStruct(
                                                                  stripeCustomerId: _model
                                                                      .agentStripe
                                                                      ?.stripeId,
                                                                  amount: 5000,
                                                                  currency:
                                                                      'usd',
                                                                  description:
                                                                      'Reschedule Booking Showami',
                                                                  agentID: _model
                                                                      .agentDoc
                                                                      ?.uid,
                                                                  bookingID: showingExpiredItem
                                                                      .showingId
                                                                      .toString(),
                                                                );
                                                                safeSetState(
                                                                    () {});
                                                                _model.apiResult3ge =
                                                                    await PayShowingPartnerProCall
                                                                        .call(
                                                                  dataJson: _model
                                                                      .showamiPP
                                                                      ?.toMap(),
                                                                );

                                                                if ((_model
                                                                        .apiResult3ge
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  _model.insertShowProperty =
                                                                      await IwoUsersShowpropertyApiGroup
                                                                          .insertShowPropertyCall
                                                                          .call(
                                                                    userName:
                                                                        currentUserDisplayName,
                                                                    userId:
                                                                        currentUserUid,
                                                                    showingDate:
                                                                        dateTimeFormat(
                                                                      "yyyy-MM-dd\'T\'HH:mm:ss",
                                                                      showingDate,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ),
                                                                    mls: showingExpiredItem
                                                                        .propertyId,
                                                                    line1: showingExpiredItem
                                                                        .address
                                                                        .line1,
                                                                    line2: showingExpiredItem
                                                                        .address
                                                                        .line2,
                                                                    city: showingExpiredItem
                                                                        .address
                                                                        .city,
                                                                    state: showingExpiredItem
                                                                        .address
                                                                        .state,
                                                                    zip: showingExpiredItem
                                                                        .address
                                                                        .zip,
                                                                    externalId:
                                                                        showingExpiredItem
                                                                            .propertyId,
                                                                    phone:
                                                                        currentPhoneNumber,
                                                                    preferredAgent1Emai:
                                                                        currentUserEmail,
                                                                  );

                                                                  if ((_model
                                                                          .insertShowProperty
                                                                          ?.succeeded ??
                                                                      true)) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(dialogContext).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                CustomDialogWidget(
                                                                              icon: Icon(
                                                                                Icons.home,
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                size: 32.0,
                                                                              ),
                                                                              title: 'Reschedule Property Tour',
                                                                              description: 'You have successfully managed to reschedule a property tour.',
                                                                              buttonLabel: 'Continue',
                                                                              iconBackgroundColor: FlutterFlowTheme.of(context).success,
                                                                              onDone: () async {},
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  } else {
                                                                    Navigator.pop(
                                                                        context);
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(dialogContext).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                CustomDialogWidget(
                                                                              icon: Icon(
                                                                                Icons.date_range_sharp,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 36.0,
                                                                              ),
                                                                              title: 'Schedule Showing',
                                                                              description: IwoUsersShowpropertyApiGroup.insertShowPropertyCall.message(
                                                                                (_model.insertShowProperty?.jsonBody ?? ''),
                                                                              )!,
                                                                              buttonLabel: 'Cancel',
                                                                              onDone: () async {},
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Dialog(
                                                                        elevation:
                                                                            0,
                                                                        insetPadding:
                                                                            EdgeInsets.zero,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        alignment:
                                                                            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              CustomDialogWidget(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.date_range_sharp,
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              size: 36.0,
                                                                            ),
                                                                            title:
                                                                                'Schedule Showing',
                                                                            description:
                                                                                (_model.apiResult3ge?.exceptionMessage ?? ''),
                                                                            buttonLabel:
                                                                                'Cancel',
                                                                            onDone:
                                                                                () async {},
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));

                                                  safeSetState(() {});
                                                },
                                                onPay: () async {},
                                                onTap: () async {},
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: IwoUsersShowpropertyApiGroup
                                  .getShowPropertiesCall
                                  .call(
                                userId: currentUserUid,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final listViewGetShowPropertiesResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final showingCancelled = functions
                                        .parseShowingsResponse(
                                            listViewGetShowPropertiesResponse
                                                .jsonBody)
                                        .map((e) =>
                                            ShowamiStruct.maybeFromMap(e))
                                        .withoutNulls
                                        .toList()
                                        .where((e) => e.isCancelled)
                                        .toList();
                                    if (showingCancelled.isEmpty) {
                                      return Center(
                                        child: EmptyListingWidget(
                                          title: 'Empty Listing',
                                          description: 'No scheduled showings ',
                                          onTap: () async {},
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: showingCancelled.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, showingCancelledIndex) {
                                        final showingCancelledItem =
                                            showingCancelled[
                                                showingCancelledIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: wrapWithModel(
                                            model: _model
                                                .scheduleCardComponentModels4
                                                .getModel(
                                              showingCancelledItem.showingId
                                                  .toString(),
                                              showingCancelledIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ScheduleCardComponentWidget(
                                              key: Key(
                                                'Keyty8_${showingCancelledItem.showingId.toString()}',
                                              ),
                                              showActions: false,
                                              appointmentData:
                                                  AppointmentStruct(
                                                id: showingCancelledItem
                                                    .showingId
                                                    .toString(),
                                                date:
                                                    functions.convertToDateTime(
                                                        showingCancelledItem
                                                            .showingDate),
                                                status: Status.Pending,
                                                address: showingCancelledItem
                                                    .address.line1,
                                                price:
                                                    showingCancelledItem.price,
                                                photo: showingCancelledItem
                                                    .address.line2,
                                              ),
                                              onCancel: () async {},
                                              onReschedule: () async {},
                                              onPay: () async {},
                                              onTap: () async {},
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
