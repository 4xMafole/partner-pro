import '/agent/components/member_activity_item/member_activity_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/offers/components/seller_offer_item/seller_offer_item_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'member_activity_model.dart';
export 'member_activity_model.dart';

class MemberActivityWidget extends StatefulWidget {
  const MemberActivityWidget({
    super.key,
    required this.member,
  });

  final MemberStruct? member;

  static String routeName = 'member_activity';
  static String routePath = '/memberActivity';

  @override
  State<MemberActivityWidget> createState() => _MemberActivityWidgetState();
}

class _MemberActivityWidgetState extends State<MemberActivityWidget> {
  late MemberActivityModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemberActivityModel());

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
                label: 'Getting user activities...',
              ),
            ),
          );
        },
      );

      _model.apiResultActivity =
          await IwoAgentClientGroup.getClientActivityByAgentCall.call(
        agentId: currentUserUid,
        clientId: widget.member?.clientID,
      );

      if ((_model.apiResultActivity?.succeeded ?? true)) {
        _model.memberDocument = await queryUsersRecordOnce(
          queryBuilder: (usersRecord) => usersRecord.where(
            'uid',
            isEqualTo: widget.member?.clientID,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.favoritesDocs = await queryFavoritesRecordOnce(
          parent: _model.memberDocument?.reference,
        );
        _model.parsedList = await actions.parseActivityList(
          (_model.apiResultActivity?.jsonBody ?? ''),
          _model.favoritesDocs?.toList(),
        );
        _model.fullActivityList =
            _model.parsedList!.toList().cast<ActivityItemTypeStruct>();
        _model.filteredActivityList =
            _model.parsedList!.toList().cast<ActivityItemTypeStruct>();
        safeSetState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to get client activity',
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
              '${widget.member?.fullName}\'s Activity',
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 970.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Below is a summary of ${widget.member?.fullName}.',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelMediumIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: FlutterFlowChoiceChips(
                                options: MemberActivityChoice.values
                                    .map((e) => e.name)
                                    .toList()
                                    .map((label) => ChipData(label))
                                    .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model.choiceChipsValue =
                                      val?.firstOrNull);
                                  _model.selectedFilter =
                                      _model.choiceChipsValue;
                                  safeSetState(() {});
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context).info,
                                  iconSize: 18.0,
                                  elevation: 2.0,
                                  borderWidth: 1.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 18.0,
                                  elevation: 0.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 1.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                chipSpacing: 8.0,
                                rowSpacing: 12.0,
                                multiselect: false,
                                initialized: _model.choiceChipsValue != null,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  [MemberActivityChoice.All.name],
                                ),
                                wrapped: false,
                              ),
                            ),
                            Flexible(
                              child: Builder(
                                builder: (context) {
                                  if (MemberActivityChoice.Offers ==
                                      functions.memberActivityChoiceToEnum(
                                          _model.choiceChipsValue!)) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final offerItem = _model
                                              .fullActivityList
                                              .where((e) =>
                                                  e.activityType == 'offer')
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.timestamp!,
                                                  desc: true)
                                              .toList();
                                          if (offerItem.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty Listing',
                                                description: 'Offers Not Found',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              16.0,
                                            ),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: offerItem.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 15.0),
                                            itemBuilder:
                                                (context, offerItemIndex) {
                                              final offerItemItem =
                                                  offerItem[offerItemIndex];
                                              return Container(
                                                child: wrapWithModel(
                                                  model: _model
                                                      .sellerOfferItemModels
                                                      .getModel(
                                                    offerItemItem.offerData.id,
                                                    offerItemIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  updateOnChange: true,
                                                  child: SellerOfferItemWidget(
                                                    key: Key(
                                                      'Keydf7_${offerItemItem.offerData.id}',
                                                    ),
                                                    status: offerItemItem
                                                                .offerData
                                                                .status !=
                                                            ''
                                                        ? functions
                                                            .statusStringToEnum(
                                                                offerItemItem
                                                                    .offerData
                                                                    .status)!
                                                        : Status.Pending,
                                                    offerItem: OfferStruct(
                                                      id: offerItemItem
                                                          .offerData.id,
                                                      property: PropertyStruct(
                                                        id: offerItemItem
                                                            .offerData.id,
                                                        propertyType:
                                                            offerItemItem
                                                                .offerData
                                                                .property
                                                                .propertyType,
                                                        title: functions
                                                            .formatAddressFromModel(
                                                                AddressDataClassStruct(
                                                                  streetName: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .streetName,
                                                                  streetNumber: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .streetNumber,
                                                                  streetDirection: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .streetDirection,
                                                                  streetType: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .streetType,
                                                                  neighborhood: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .neighborhood,
                                                                  city: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .city,
                                                                  state: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .state,
                                                                  zip: offerItemItem
                                                                      .offerData
                                                                      .property
                                                                      .address
                                                                      .zip,
                                                                ),
                                                                ''),
                                                        beds: offerItemItem
                                                            .offerData
                                                            .property
                                                            .bedrooms
                                                            .toString(),
                                                        baths: offerItemItem
                                                            .offerData
                                                            .property
                                                            .bathrooms
                                                            .toString(),
                                                        sqft: offerItemItem
                                                            .offerData
                                                            .property
                                                            .squareFootage
                                                            .toString(),
                                                        price: offerItemItem
                                                            .offerData
                                                            .property
                                                            .listPrice,
                                                        images: offerItemItem
                                                            .offerData
                                                            .property
                                                            .media,
                                                      ),
                                                      listPrice: offerItemItem
                                                          .offerData
                                                          .pricing
                                                          .listPrice
                                                          .toString(),
                                                      purchasePrice:
                                                          offerItemItem
                                                              .offerData
                                                              .pricing
                                                              .purchasePrice,
                                                    ),
                                                    isAgent: false,
                                                    onTap: () async {
                                                      FFAppState()
                                                              .tempOfferCompare =
                                                          offerItemItem
                                                              .offerData;
                                                      safeSetState(() {});

                                                      context.pushNamed(
                                                        OfferDetailsPageWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'offerStatus':
                                                              serializeParam(
                                                            functions
                                                                .statusStringToEnum(
                                                                    offerItemItem
                                                                        .offerData
                                                                        .status),
                                                            ParamType.Enum,
                                                          ),
                                                          'newOffer':
                                                              serializeParam(
                                                            offerItemItem
                                                                .offerData,
                                                            ParamType
                                                                .DataStruct,
                                                          ),
                                                          'member':
                                                              serializeParam(
                                                            widget.member,
                                                            ParamType
                                                                .DataStruct,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    onAccept: () async {},
                                                    onDecline: () async {},
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else if (MemberActivityChoice.Searches ==
                                      functions.memberActivityChoiceToEnum(
                                          _model.choiceChipsValue!)) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final searchItem = _model
                                              .fullActivityList
                                              .where((e) =>
                                                  e.activityType == 'search')
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.timestamp!,
                                                  desc: true)
                                              .toList();
                                          if (searchItem.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty Listing',
                                                description:
                                                    'Searched or Saved Properties Not Found',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              16.0,
                                            ),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: searchItem.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 15.0),
                                            itemBuilder:
                                                (context, searchItemIndex) {
                                              final searchItemItem =
                                                  searchItem[searchItemIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    PropertyDetailsPageWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'propertyId':
                                                          serializeParam(
                                                        searchItemItem
                                                            .searchData.id,
                                                        ParamType.String,
                                                      ),
                                                      'member': serializeParam(
                                                        widget.member,
                                                        ParamType.DataStruct,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model
                                                      .propertyItemModels1
                                                      .getModel(
                                                    searchItemItem
                                                        .searchData.id,
                                                    searchItemIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  updateOnChange: true,
                                                  child: PropertyItemWidget(
                                                    key: Key(
                                                      'Keyvlm_${searchItemItem.searchData.id}',
                                                    ),
                                                    property: searchItemItem
                                                        .searchData,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else if (MemberActivityChoice.All ==
                                      functions.memberActivityChoiceToEnum(
                                          _model.choiceChipsValue!)) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final activityItem = _model
                                              .filteredActivityList
                                              .sortedList(
                                                  keyOf: (e) => e.timestamp!,
                                                  desc: true)
                                              .toList();
                                          if (activityItem.isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty Listing',
                                                description:
                                                    'No activity found',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              16.0,
                                              0,
                                              16.0,
                                            ),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: activityItem.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 0.0),
                                            itemBuilder:
                                                (context, activityItemIndex) {
                                              final activityItemItem =
                                                  activityItem[
                                                      activityItemIndex];
                                              return Builder(
                                                builder: (context) {
                                                  if (activityItemItem
                                                          .activityType ==
                                                      'search') {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .memberActivityItemModels1
                                                          .getModel(
                                                        activityItemItem
                                                            .searchData.id,
                                                        activityItemIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          MemberActivityItemWidget(
                                                        key: Key(
                                                          'Keykfa_${activityItemItem.searchData.id}',
                                                        ),
                                                        photoUrl:
                                                            valueOrDefault<
                                                                String>(
                                                          activityItemItem
                                                              .searchData
                                                              .media
                                                              .firstOrNull,
                                                          'https://placehold.co/800@2x.png?text=H',
                                                        ),
                                                        title:
                                                            'Viewed ${functions.formatAddressFromModel(activityItemItem.searchData.address, '')}',
                                                        time: dateTimeFormat(
                                                          "relative",
                                                          activityItemItem
                                                              .timestamp!,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        subtitle:
                                                            '${functions.formatAddressFromModel(activityItemItem.searchData.address, '')} property details were viewed',
                                                      ),
                                                    );
                                                  } else if (activityItemItem
                                                          .activityType ==
                                                      'offer') {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .memberActivityItemModels2
                                                          .getModel(
                                                        activityItemItem
                                                            .offerData.id,
                                                        activityItemIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          MemberActivityItemWidget(
                                                        key: Key(
                                                          'Key91n_${activityItemItem.offerData.id}',
                                                        ),
                                                        photoUrl:
                                                            valueOrDefault<
                                                                String>(
                                                          activityItemItem
                                                              .offerData
                                                              .property
                                                              .media
                                                              .firstOrNull,
                                                          'https://placehold.co/800@2x.png?text=H',
                                                        ),
                                                        title:
                                                            'Placed Offer for ${functions.formatAddressFromModel(activityItemItem.offerData.property.address, '')}',
                                                        time: dateTimeFormat(
                                                          "relative",
                                                          activityItemItem
                                                              .timestamp!,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        subtitle:
                                                            'Offer submitted for ${formatNumber(
                                                          activityItemItem
                                                              .offerData
                                                              .pricing
                                                              .purchasePrice,
                                                          formatType: FormatType
                                                              .decimal,
                                                          decimalType:
                                                              DecimalType
                                                                  .automatic,
                                                          currency: '\$',
                                                        )}',
                                                      ),
                                                    );
                                                  } else if (activityItemItem
                                                          .activityType ==
                                                      'favorite_added') {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .memberActivityItemModels3
                                                          .getModel(
                                                        activityItemItem
                                                            .searchData.id,
                                                        activityItemIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          MemberActivityItemWidget(
                                                        key: Key(
                                                          'Keyzgs_${activityItemItem.searchData.id}',
                                                        ),
                                                        photoUrl:
                                                            valueOrDefault<
                                                                String>(
                                                          activityItemItem
                                                              .searchData
                                                              .media
                                                              .firstOrNull,
                                                          'https://placehold.co/800@2x.png?text=H',
                                                        ),
                                                        title:
                                                            'Added to Favorites – ${functions.formatAddressFromModel(activityItemItem.searchData.address, '')}',
                                                        time: dateTimeFormat(
                                                          "relative",
                                                          activityItemItem
                                                              .timestamp!,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        subtitle:
                                                            '${functions.formatAddressFromModel(activityItemItem.searchData.address, '')} was added to favorites list',
                                                      ),
                                                    );
                                                  } else {
                                                    return wrapWithModel(
                                                      model: _model
                                                          .memberActivityItemModels4
                                                          .getModel(
                                                        activityItemItem
                                                            .searchData.id,
                                                        activityItemIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          MemberActivityItemWidget(
                                                        key: Key(
                                                          'Keyitu_${activityItemItem.searchData.id}',
                                                        ),
                                                        photoUrl:
                                                            valueOrDefault<
                                                                String>(
                                                          activityItemItem
                                                              .searchData
                                                              .media
                                                              .firstOrNull,
                                                          'https://placehold.co/800@2x.png?text=H',
                                                        ),
                                                        title:
                                                            'Removed from Favorites - ${functions.formatAddressFromModel(activityItemItem.searchData.address, '')}',
                                                        time: dateTimeFormat(
                                                          "relative",
                                                          activityItemItem
                                                              .timestamp!,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        subtitle:
                                                            '${functions.formatAddressFromModel(activityItemItem.searchData.address, '')} was removed to favorites list',
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else if (MemberActivityChoice.Suggestions ==
                                      functions.memberActivityChoiceToEnum(
                                          _model.choiceChipsValue!)) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: StreamBuilder<
                                          List<SuggestionsRecord>>(
                                        stream: querySuggestionsRecord(
                                          parent:
                                              _model.memberDocument?.reference,
                                        ),
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
                                          List<SuggestionsRecord>
                                              propertyListSuggestionsRecordList =
                                              snapshot.data!;
                                          if (propertyListSuggestionsRecordList
                                              .isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty List',
                                                description:
                                                    'No suggested homes',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                propertyListSuggestionsRecordList
                                                    .length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 20.0),
                                            itemBuilder:
                                                (context, propertyListIndex) {
                                              final propertyListSuggestionsRecord =
                                                  propertyListSuggestionsRecordList[
                                                      propertyListIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    PropertyDetailsPageWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'propertyId':
                                                          serializeParam(
                                                        propertyListSuggestionsRecord
                                                            .propertyData.id,
                                                        ParamType.String,
                                                      ),
                                                      'member': serializeParam(
                                                        widget.member,
                                                        ParamType.DataStruct,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model
                                                      .propertyItemModels2
                                                      .getModel(
                                                    propertyListSuggestionsRecord
                                                        .propertyData.id,
                                                    propertyListIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  updateOnChange: true,
                                                  child: PropertyItemWidget(
                                                    key: Key(
                                                      'Key2go_${propertyListSuggestionsRecord.propertyData.id}',
                                                    ),
                                                    property:
                                                        propertyListSuggestionsRecord
                                                            .propertyData,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child:
                                          StreamBuilder<List<FavoritesRecord>>(
                                        stream: queryFavoritesRecord(
                                          parent:
                                              _model.memberDocument?.reference,
                                          queryBuilder: (favoritesRecord) =>
                                              favoritesRecord
                                                  .where(
                                                    'is_deleted_by_user',
                                                    isEqualTo: false,
                                                  )
                                                  .orderBy('created_at',
                                                      descending: true),
                                        ),
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
                                          List<FavoritesRecord>
                                              propertyListFavoritesRecordList =
                                              snapshot.data!;
                                          if (propertyListFavoritesRecordList
                                              .isEmpty) {
                                            return Center(
                                              child: EmptyListingWidget(
                                                title: 'Empty List',
                                                description:
                                                    'No favorited homes',
                                                onTap: () async {},
                                              ),
                                            );
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                propertyListFavoritesRecordList
                                                    .length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 20.0),
                                            itemBuilder:
                                                (context, propertyListIndex) {
                                              final propertyListFavoritesRecord =
                                                  propertyListFavoritesRecordList[
                                                      propertyListIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    PropertyDetailsPageWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'propertyId':
                                                          serializeParam(
                                                        propertyListFavoritesRecord
                                                            .propertyData.id,
                                                        ParamType.String,
                                                      ),
                                                      'member': serializeParam(
                                                        widget.member,
                                                        ParamType.DataStruct,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model
                                                      .propertyItemModels3
                                                      .getModel(
                                                    propertyListFavoritesRecord
                                                        .propertyData.id,
                                                    propertyListIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  updateOnChange: true,
                                                  child: PropertyItemWidget(
                                                    key: Key(
                                                      'Keyrbb_${propertyListFavoritesRecord.propertyData.id}',
                                                    ),
                                                    property:
                                                        propertyListFavoritesRecord
                                                            .propertyData,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
