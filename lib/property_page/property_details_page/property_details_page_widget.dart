import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/offer_process/offer_process_widget.dart';
import '/app_components/schedule_tour_sheet/schedule_tour_sheet_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/custom_loading_indicator_widget.dart';
import '/components/member_suggestion_sheet_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/funds_proof_sheet/funds_proof_sheet_widget.dart';
import '/pages/profile_page/lender_popup/lender_popup_widget.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/shared_components/custom_bottom_sheet/custom_bottom_sheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'property_details_page_model.dart';
export 'property_details_page_model.dart';

class PropertyDetailsPageWidget extends StatefulWidget {
  const PropertyDetailsPageWidget({
    super.key,
    required this.propertyId,
    this.member,
    bool? isUserFromSearch,
  }) : isUserFromSearch = isUserFromSearch ?? false;

  final String? propertyId;
  final MemberStruct? member;
  final bool isUserFromSearch;

  static String routeName = 'property_details_page';
  static String routePath = '/propertyDetailsPage';

  @override
  State<PropertyDetailsPageWidget> createState() =>
      _PropertyDetailsPageWidgetState();
}

class _PropertyDetailsPageWidgetState extends State<PropertyDetailsPageWidget> {
  late PropertyDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyDetailsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.property = PropertyDataClassStruct();
      safeSetState(() {});
      _model.propertyZipId =
          await IwoSellerPropertiesApiGroup.getPropertiesByZipIdCall.call(
        zpId: widget.propertyId,
        userId: currentUserUid,
      );

      if ((_model.propertyZipId?.succeeded ?? true)) {
        _model.estimationPrice = await PropertyEstimateCall.call(
          zpid: widget.propertyId,
        );

        _model.property = PropertyDataClassStruct(
          id: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.id,
          bathrooms: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.bathrooms,
          bedrooms: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.bedrooms,
          countyParishPrecinct: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.countyParishPrecinct,
          listPrice: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.listPrice,
          lotSize: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.lotSize,
          media: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.media,
          notes: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.notes,
          propertyType: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.propertyType,
          mlsId: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.mlsId,
          yearBuilt: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.yearBuilt,
          latitude: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.latitude,
          longitude: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.longitude,
          sellerId: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.sellerId,
          listAsIs: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.listAsIs,
          inContract: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.inContract,
          isPending: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.isPending,
          listNegotiable: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.listNegotiable,
          listPriceReduction: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.listPriceReduction,
          isSold: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.isSold,
          address: AddressDataClassStruct(
            streetName: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .streetName,
            streetNumber: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .streetNumber,
            streetDirection: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .streetDirection,
            streetType: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .streetType,
            neighborhood: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .neighborhood,
            city: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .city,
            state: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .state,
            zip: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .zip,
            zipPlus4: PropertyDataByZIPIDStruct.maybeFromMap(
                    (_model.propertyZipId?.jsonBody ?? ''))
                ?.address
                .zipPlus4,
          ),
          squareFootage: functions.parseSquareFootage(
              PropertyDataByZIPIDStruct.maybeFromMap(
                      (_model.propertyZipId?.jsonBody ?? ''))!
                  .squareFootage),
          onMarketDate: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.onMarketDate,
          agentPhoneNumber: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.agentPhoneNumber,
          agentName: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.agentName,
          agentEmail: PropertyDataByZIPIDStruct.maybeFromMap(
                  (_model.propertyZipId?.jsonBody ?? ''))
              ?.agentEmail,
        );
        _model.estimateAmount = PropertyEstimateCall.estimate(
          (_model.estimationPrice?.jsonBody ?? ''),
        );
        safeSetState(() {});
        _model.favoriteProperty = await queryFavoritesRecordOnce(
          parent: currentUserReference,
          queryBuilder: (favoritesRecord) => favoritesRecord.where(
            'property_data.id',
            isEqualTo: widget.propertyId,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.noOfShowamiDocs = await queryShowamiRecordCount(
          parent: currentUserReference,
        );
        _model.isFavorited = _model.favoriteProperty?.isDeletedByUser != null
            ? !_model.favoriteProperty!.isDeletedByUser
            : false;
        _model.showamiCount = _model.noOfShowamiDocs!;
        safeSetState(() {});
        FFAppState().isNavigating = false;
        safeSetState(() {});
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Failed to get Property Details'),
              content: Text((_model.propertyZipId?.exceptionMessage ?? '')),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
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
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
                        Text(
                          valueOrDefault<String>(
                            functions.formatAddressFromModel(
                                _model.property!.address, ''),
                            'N/A',
                          ).maybeHandleOverflow(
                            maxChars: 22,
                            replacement: '…',
                          ),
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                    if (currentUserDocument?.role != UserType.Agent)
                      AuthUserStreamWidget(
                        builder: (context) => Container(
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ToggleIcon(
                                onPressed: () async {
                                  safeSetState(() =>
                                      _model.isFavorited = !_model.isFavorited);
                                  if (!_model.isFavorited) {
                                    _model.fireDeleteProperty =
                                        await queryFavoritesRecordOnce(
                                      parent: currentUserReference,
                                      queryBuilder: (favoritesRecord) =>
                                          favoritesRecord.where(
                                        'property_data.id',
                                        isEqualTo: widget.propertyId,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);

                                    await _model.fireDeleteProperty!.reference
                                        .update(createFavoritesRecordData(
                                      isDeletedByUser: true,
                                    ));
                                  } else {
                                    if (_model.favoriteProperty?.reference !=
                                        null) {
                                      await _model.favoriteProperty!.reference
                                          .update(createFavoritesRecordData(
                                        isDeletedByUser: false,
                                      ));
                                    } else {
                                      var favoritesRecordReference =
                                          FavoritesRecord.createDoc(
                                              currentUserReference!);
                                      await favoritesRecordReference
                                          .set(createFavoritesRecordData(
                                        propertyData:
                                            updatePropertyDataClassStruct(
                                          _model.property,
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        isDeletedByUser: false,
                                        createdAt: getCurrentTimestamp,
                                      ));
                                      _model.fireFavoriteProperty =
                                          FavoritesRecord.getDocumentFromData(
                                              createFavoritesRecordData(
                                                propertyData:
                                                    updatePropertyDataClassStruct(
                                                  _model.property,
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                isDeletedByUser: false,
                                                createdAt: getCurrentTimestamp,
                                              ),
                                              favoritesRecordReference);

                                      await _model
                                          .fireFavoriteProperty!.reference
                                          .update(createFavoritesRecordData(
                                        id: _model
                                            .fireFavoriteProperty?.reference.id,
                                      ));
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                value: _model.isFavorited,
                                onIcon: Icon(
                                  Icons.favorite_sharp,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 24.0,
                                ),
                                offIcon: Icon(
                                  Icons.favorite_border,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ].divide(SizedBox(width: 12.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Builder(
                  builder: (context) {
                    final media = _model.property?.media.toList() ?? [];

                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.333,
                      child: CarouselSlider.builder(
                        itemCount: media.length,
                        itemBuilder: (context, mediaIndex, _) {
                          final mediaItem = media[mediaIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.network(
                                      functions.stringToImagePath(mediaItem)!,
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag:
                                        functions.stringToImagePath(mediaItem)!,
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: functions.stringToImagePath(mediaItem)!,
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  functions.stringToImagePath(mediaItem)!,
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        carouselController: _model.imageCarouselController ??=
                            CarouselSliderController(),
                        options: CarouselOptions(
                          initialPage: max(0, min(1, media.length - 1)),
                          viewportFraction: 0.9,
                          disableCenter: true,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.19,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          autoPlay: false,
                          onPageChanged: (index, _) =>
                              _model.imageCarouselCurrentIndex = index,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              2.0, 4.0, 2.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x23000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'SQFT',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                      Text(
                                        _model.property?.squareFootage
                                                    .toString() ==
                                                '0'
                                            ? 'N/A'
                                            : formatNumber(
                                                _model.property!.squareFootage,
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.periodDecimal,
                                              ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'BEDS',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          _model.property?.bedrooms.toString(),
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'BATHS',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          _model.property?.bathrooms.toString(),
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          formatNumber(
                            _model.property!.listPrice,
                            formatType: FormatType.decimal,
                            decimalType: DecimalType.periodDecimal,
                            currency: '\$',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineSmallIsCustom,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: FlutterFlowTheme.of(context).accent2,
                                  size: 24.0,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions.formatAddressFromModel(
                                            _model.property!.address, ''),
                                        'N/A',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 5.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Details',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleLargeFamily,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleLargeIsCustom,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                _model.property?.notes,
                                'N/A',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelSmallFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelSmallIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(height: 5.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pricing',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'List Pice:',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          formatNumber(
                                            _model.property!.listPrice,
                                            formatType: FormatType.decimal,
                                            decimalType:
                                                DecimalType.periodDecimal,
                                            currency: '\$',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (PropertyEstimateCall.estimate(
                                        (_model.estimationPrice?.jsonBody ??
                                            ''),
                                      ) !=
                                      null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'PartnerPro Estimate',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              formatNumber(
                                                PropertyEstimateCall.estimate(
                                                  (_model.estimationPrice
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                formatType: FormatType.decimal,
                                                decimalType:
                                                    DecimalType.automatic,
                                                currency: '\$',
                                              ),
                                              'N/A',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price/Sq.Ft.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          _model.property?.squareFootage
                                                      .toString() ==
                                                  '0'
                                              ? 'N/A'
                                              : formatNumber(
                                                  functions
                                                          .convertStringToDouble(
                                                              _model.property!
                                                                  .listPrice
                                                                  .toString()) /
                                                      functions
                                                          .convertStringToDouble(
                                                              _model.property!
                                                                  .squareFootage
                                                                  .toString()),
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.periodDecimal,
                                                  currency: '\$',
                                                ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'About this home',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (false)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Views',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                          Text(
                                            'N/A',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'County',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            _model
                                                .property?.countyParishPrecinct,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'MLS#',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            _model.property?.mlsId,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Built',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                                    _model.property?.yearBuilt
                                                        .toString(),
                                                    'N/A',
                                                  ) ==
                                                  '0'
                                              ? 'N/A'
                                              : valueOrDefault<String>(
                                                  _model.property?.yearBuilt
                                                      .toString(),
                                                  'N/A',
                                                ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Lot Size',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            _model.property?.lotSize,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'On Market Date',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            _model.property?.onMarketDate,
                                            'N/A',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if ((currentUserDocument?.role == UserType.Agent) &&
                                ((_model.property?.agentName != null &&
                                        _model.property?.agentName != '') ||
                                    (_model.property?.agentEmail != null &&
                                        _model.property?.agentEmail != '') ||
                                    (_model.property?.agentPhoneNumber !=
                                            null &&
                                        _model.property?.agentPhoneNumber !=
                                            '')))
                              AuthUserStreamWidget(
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Listing Agent Contact',
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
                                    if (_model.property?.agentName != null &&
                                        _model.property?.agentName != '')
                                      Text(
                                        valueOrDefault<String>(
                                          _model.property?.agentName,
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                    if (_model.property?.agentPhoneNumber !=
                                            null &&
                                        _model.property?.agentPhoneNumber != '')
                                      Text(
                                        valueOrDefault<String>(
                                          _model.property?.agentPhoneNumber,
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                    if (_model.property?.agentEmail != null &&
                                        _model.property?.agentEmail != '')
                                      Text(
                                        valueOrDefault<String>(
                                          _model.property?.agentEmail,
                                          'N/A',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelSmallIsCustom,
                                            ),
                                      ),
                                  ].divide(SizedBox(height: 5.0)),
                                ),
                              ),
                            FutureBuilder<ApiCallResponse>(
                              future: PropertyComparablesCall.call(
                                address: functions.formatAddressFromModel(
                                    AddressDataClassStruct(
                                      streetName:
                                          _model.property?.address.streetName,
                                      streetNumber:
                                          _model.property?.address.streetNumber,
                                      streetDirection: _model
                                          .property?.address.streetDirection,
                                      streetType:
                                          _model.property?.address.streetType,
                                      neighborhood:
                                          _model.property?.address.neighborhood,
                                      city: _model.property?.address.city,
                                      state: _model.property?.address.state,
                                      zip: _model.property?.address.zip,
                                      zipPlus4:
                                          _model.property?.address.zipPlus4,
                                    ),
                                    ''),
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
                                final containerPropertyComparablesResponse =
                                    snapshot.data!;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: Visibility(
                                    visible: getJsonField(
                                          containerPropertyComparablesResponse
                                              .jsonBody,
                                          r'''$.comps[0]''',
                                        ) !=
                                        null,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Property comparison:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLargeIsCustom,
                                                        ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (_model.isShowCompare ==
                                                      true)
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.isShowCompare =
                                                            false;
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.keyboard_arrow_up,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  if (_model.isShowCompare ==
                                                      false)
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.isShowCompare =
                                                            !_model
                                                                .isShowCompare;
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (_model.isShowCompare)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: Builder(
                                              builder: (context) {
                                                final items =
                                                    (PropertyComparablesCall
                                                                .comps(
                                                              containerPropertyComparablesResponse
                                                                  .jsonBody,
                                                            )?.toList() ??
                                                            [])
                                                        .take(10)
                                                        .toList();
                                                if (items.isEmpty) {
                                                  return Center(
                                                    child: EmptyListingWidget(
                                                      title: 'Empty Listing',
                                                      description:
                                                          'No property for comparison',
                                                      onTap: () async {},
                                                    ),
                                                  );
                                                }

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: items.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 12.0),
                                                  itemBuilder:
                                                      (context, itemsIndex) {
                                                    final itemsItem =
                                                        items[itemsIndex];
                                                    return wrapWithModel(
                                                      model: _model
                                                          .propertyItemModels
                                                          .getModel(
                                                        itemsIndex.toString(),
                                                        itemsIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child: PropertyItemWidget(
                                                        key: Key(
                                                          'Keyrbg_${itemsIndex.toString()}',
                                                        ),
                                                        property:
                                                            PropertyDataClassStruct(
                                                          id: random_data
                                                              .randomString(
                                                            5,
                                                            10,
                                                            true,
                                                            false,
                                                            true,
                                                          ),
                                                          bathrooms: functions
                                                              .doubleToInt(
                                                                  getJsonField(
                                                            itemsItem,
                                                            r'''$.bathrooms''',
                                                          ).toString()),
                                                          bedrooms: functions
                                                              .doubleToInt(
                                                                  getJsonField(
                                                            itemsItem,
                                                            r'''$.bedrooms''',
                                                          ).toString()),
                                                          propertyType:
                                                              getJsonField(
                                                            itemsItem,
                                                            r'''$.propertyTypeDimension''',
                                                          ).toString(),
                                                          lotSize: getJsonField(
                                                            itemsItem,
                                                            r'''$.lotSize''',
                                                          ).toString(),
                                                          address:
                                                              AddressDataClassStruct(
                                                            city: getJsonField(
                                                              itemsItem,
                                                              r'''$.address.city''',
                                                            ).toString(),
                                                            state: getJsonField(
                                                              itemsItem,
                                                              r'''$.address.state''',
                                                            ).toString(),
                                                            streetName:
                                                                getJsonField(
                                                              itemsItem,
                                                              r'''$.address.streetAddress''',
                                                            ).toString(),
                                                            zip: getJsonField(
                                                              itemsItem,
                                                              r'''$.address.zipCode''',
                                                            ).toString(),
                                                          ),
                                                          latitude:
                                                              getJsonField(
                                                            itemsItem,
                                                            r'''$.latitude''',
                                                          ),
                                                          listPrice:
                                                              getJsonField(
                                                            itemsItem,
                                                            r'''$.price''',
                                                          ),
                                                          media: functions
                                                              .strToList(functions
                                                                  .validateImage(
                                                                      getJsonField(
                                                            itemsItem,
                                                            r'''$.miniCardPhotos[0].url''',
                                                          ).toString())),
                                                          longitude:
                                                              getJsonField(
                                                            itemsItem,
                                                            r'''$.longitude''',
                                                          ),
                                                          squareFootage:
                                                              getJsonField(
                                                            itemsItem,
                                                            r'''$.livingAreaValue''',
                                                          ),
                                                        ),
                                                        zipCode: _model.property
                                                            ?.address.zip,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  if (!((currentUserDocument?.role == UserType.Agent) &&
                      widget.isUserFromSearch)) {
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  if (_model.isDocumentUploaded ||
                                      (FFAppState().currentOfferDraft.id ==
                                          widget.propertyId)) {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: OfferProcessWidget(
                                            property: _model.property,
                                            iwriteEstimate: _model
                                                .estimateAmount
                                                ?.toDouble(),
                                            member: widget.member,
                                            onUpdate: (value) async {},
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  } else {
                                    showDialog(
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
                                          child: CustomLoadingIndicatorWidget(
                                            label: 'Checking Documents...',
                                          ),
                                        );
                                      },
                                    );

                                    _model.validUserFiles =
                                        await actions.getValidProofOfFunds(
                                      currentUserDocument?.proofOfFunds,
                                    );
                                    Navigator.pop(context);
                                    if (_model.validUserFiles != null &&
                                        (_model.validUserFiles)!.isNotEmpty) {
                                      FFAppState()
                                          .updateCurrentOfferDraftStruct(
                                        (e) => e
                                          ..documents =
                                              _model.validUserFiles!.toList(),
                                      );
                                      safeSetState(() {});
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: OfferProcessWidget(
                                              property: _model.property,
                                              iwriteEstimate: _model
                                                  .estimateAmount
                                                  ?.toDouble(),
                                              member: widget.member,
                                              onUpdate: (value) async {},
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    } else {
                                      // Lender Popup
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
                                            child: LenderPopupWidget(
                                              isAgent:
                                                  currentUserDocument?.role ==
                                                      UserType.Agent,
                                              onConfirm: (hasLender) async {
                                                if (hasLender) {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            FundsProofSheetWidget(
                                                          property:
                                                              _model.property!,
                                                          onDone: () async {
                                                            Navigator.pop(
                                                                context);
                                                            _model.isDocumentUploaded =
                                                                true;
                                                            safeSetState(() {});
                                                            FFAppState()
                                                                .updateCurrentOfferDraftStruct(
                                                              (e) => e
                                                                ..id = widget
                                                                    .propertyId,
                                                            );
                                                            safeSetState(() {});
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      OfferProcessWidget(
                                                                    property: _model
                                                                        .property,
                                                                    iwriteEstimate: _model
                                                                        .estimateAmount
                                                                        ?.toDouble(),
                                                                    member: widget
                                                                        .member,
                                                                    onUpdate:
                                                                        (value) async {},
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                } else {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            CustomBottomSheetWidget(
                                                          value:
                                                              'You must have a lender pre-approval or proof of funds to move forward with writing an offer. Without one, we cannot proceed.',
                                                          label: 'Requirement',
                                                          icon: Icon(
                                                            Icons
                                                                .approval_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 48.0,
                                                          ),
                                                          buttonLabel: 'Cancel',
                                                          onDone: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                }
                                              },
                                              onBypass: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: OfferProcessWidget(
                                                        property:
                                                            _model.property,
                                                        iwriteEstimate: _model
                                                            .estimateAmount
                                                            ?.toDouble(),
                                                        member: widget.member,
                                                        onUpdate:
                                                            (value) async {},
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Make Offer',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
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
                                            .secondaryBackground,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                showLoadingIndicator: false,
                              ),
                            ),
                          ),
                          if ((currentUserDocument?.role != UserType.Agent) &&
                              (_model.showamiCount < 8))
                            Expanded(
                              child: Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            child: ScheduleTourSheetWidget(
                                              onApprove: (showingDate) async {
                                                var showamiRecordReference =
                                                    ShowamiRecord.createDoc(
                                                        currentUserReference!);
                                                await showamiRecordReference
                                                    .set(
                                                        createShowamiRecordData(
                                                  showami: updateShowamiStruct(
                                                    ShowamiStruct(
                                                      userId: currentUserUid,
                                                      showingDate:
                                                          dateTimeFormat(
                                                        "yyyy-MM-dd\'T\'HH:mm:ss",
                                                        showingDate,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      address: AddressStruct(
                                                        line1: functions
                                                            .formatAddressFromModel(
                                                                _model.property!
                                                                    .address,
                                                                ''),
                                                        line2: _model.property
                                                            ?.media.firstOrNull,
                                                        city: _model.property
                                                            ?.address.city,
                                                        state: _model.property
                                                            ?.address.state,
                                                        zip: _model.property
                                                            ?.address.zip,
                                                      ),
                                                      propertyId:
                                                          widget.propertyId,
                                                      createdAt:
                                                          getCurrentTimestamp
                                                              .toString(),
                                                      price: 45,
                                                    ),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                ));
                                                _model.newShowami = ShowamiRecord
                                                    .getDocumentFromData(
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
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              address:
                                                                  AddressStruct(
                                                                line1: functions
                                                                    .formatAddressFromModel(
                                                                        _model
                                                                            .property!
                                                                            .address,
                                                                        ''),
                                                                line2: _model
                                                                    .property
                                                                    ?.media
                                                                    .firstOrNull,
                                                                city: _model
                                                                    .property
                                                                    ?.address
                                                                    .city,
                                                                state: _model
                                                                    .property
                                                                    ?.address
                                                                    .state,
                                                                zip: _model
                                                                    .property
                                                                    ?.address
                                                                    .zip,
                                                              ),
                                                              propertyId: widget
                                                                  .propertyId,
                                                              createdAt:
                                                                  getCurrentTimestamp
                                                                      .toString(),
                                                              price: 45,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
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
                                                    isEqualTo: currentUserUid,
                                                  ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                _model.agentDoc =
                                                    await queryUsersRecordOnce(
                                                  queryBuilder: (usersRecord) =>
                                                      usersRecord.where(
                                                    'uid',
                                                    isEqualTo: _model
                                                        .clientRelationDoc
                                                        ?.relationship
                                                        .agentUid,
                                                  ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                _model.agentStripe =
                                                    await queryCustomersRecordOnce(
                                                  queryBuilder:
                                                      (customersRecord) =>
                                                          customersRecord.where(
                                                    'email',
                                                    isEqualTo:
                                                        _model.agentDoc?.email,
                                                  ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);
                                                _model.showamiPP =
                                                    ShowingPartnerProStruct(
                                                  stripeCustomerId: _model
                                                      .agentStripe?.stripeId,
                                                  amount: 4500,
                                                  currency: 'usd',
                                                  description:
                                                      'Showami Payment',
                                                  agentID: _model.agentDoc?.uid,
                                                  metadata: MetadataStruct(
                                                    customerEmail:
                                                        currentUserEmail,
                                                  ),
                                                  bookingID: '1234',
                                                );
                                                safeSetState(() {});
                                                _model.apiResult3ge =
                                                    await PayShowingPartnerProCall
                                                        .call(
                                                  dataJson:
                                                      _model.showamiPP?.toMap(),
                                                );

                                                if ((_model.apiResult3ge
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.insertShowProperty =
                                                      await IwoUsersShowpropertyApiGroup
                                                          .insertShowPropertyCall
                                                          .call(
                                                    userName:
                                                        currentUserDisplayName,
                                                    userId: currentUserUid,
                                                    showingDate: dateTimeFormat(
                                                      "yyyy-MM-dd\'T\'HH:mm:ss",
                                                      showingDate,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ),
                                                    mls: _model.property?.mlsId,
                                                    line1: functions
                                                        .formatAddressFromModel(
                                                            _model.property!
                                                                .address,
                                                            ''),
                                                    line2: _model.property
                                                        ?.media.firstOrNull,
                                                    city: _model
                                                        .property?.address.city,
                                                    state: _model.property
                                                        ?.address.state,
                                                    zip: _model
                                                        .property?.address.zip,
                                                    externalId:
                                                        widget.propertyId,
                                                    phone: currentPhoneNumber,
                                                    preferredAgent1Emai:
                                                        _model.agentDoc?.email,
                                                  );

                                                  if ((_model.insertShowProperty
                                                          ?.succeeded ??
                                                      true)) {
                                                    _model.smsProvider =
                                                        SMSProviderStruct(
                                                      recipient: functions
                                                          .normalizePhoneNumber(
                                                              _model.agentDoc
                                                                  ?.phoneNumber),
                                                      content:
                                                          'Hi ${_model.agentDoc?.displayName}, $currentUserDisplayName has approved for property showing at ${functions.formatAddressFromModel(_model.property!.address, '')}. A charge has been applied to your account. Check PartnerPro for details.',
                                                    );
                                                    safeSetState(() {});
                                                    if ((_model.agentDoc
                                                                    ?.phoneNumber !=
                                                                null &&
                                                            _model.agentDoc
                                                                    ?.phoneNumber !=
                                                                '') &&
                                                        _model.agentDoc!
                                                            .hasAcceptedSMS) {
                                                      _model.apiResulttfn =
                                                          await EmailApiGroup
                                                              .postSMSCall
                                                              .call(
                                                        requesterId:
                                                            currentUserUid,
                                                        dataJson: _model
                                                            .smsProvider
                                                            ?.toMap(),
                                                      );

                                                      if (!(_model.apiResulttfn
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              '[SMS] Failed to notify Agent, but worry out.',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    Navigator.pop(context);
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
                                                              CustomDialogWidget(
                                                            icon: Icon(
                                                              Icons.home,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              size: 32.0,
                                                            ),
                                                            title:
                                                                'Property Tour',
                                                            description:
                                                                'You have successfully managed to schedule a property tour.',
                                                            buttonLabel:
                                                                'Continue',
                                                            iconBackgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                            onDone: () async {
                                                              context.pushNamed(
                                                                  ScheduledShowingsPageWidget
                                                                      .routeName);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    Navigator.pop(context);
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
                                                              CustomDialogWidget(
                                                            icon: Icon(
                                                              Icons
                                                                  .date_range_sharp,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              size: 36.0,
                                                            ),
                                                            title:
                                                                'Schedule Showing',
                                                            description:
                                                                IwoUsersShowpropertyApiGroup
                                                                    .insertShowPropertyCall
                                                                    .message(
                                                              (_model.insertShowProperty
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )!,
                                                            buttonLabel:
                                                                'Cancel',
                                                            onDone: () async {},
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else {
                                                  Navigator.pop(context);
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
                                                        child:
                                                            CustomDialogWidget(
                                                          icon: Icon(
                                                            Icons
                                                                .date_range_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 36.0,
                                                          ),
                                                          title:
                                                              'Schedule Showing',
                                                          description: (_model
                                                                  .apiResult3ge
                                                                  ?.exceptionMessage ??
                                                              ''),
                                                          buttonLabel: 'Cancel',
                                                          onDone: () async {},
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    safeSetState(() {});
                                  },
                                  text: 'Schedule Tour',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 44.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: MemberSuggestionSheetWidget(
                                          propertyID: widget.propertyId!,
                                          onMemberSuggested:
                                              (memberItem) async {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child:
                                                      CustomLoadingIndicatorWidget(
                                                    label: 'Please wait...',
                                                  ),
                                                );
                                              },
                                            );

                                            _model.buyerDoc =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo: memberItem.clientID,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            _model.activeSuggestionDoc =
                                                await querySuggestionsRecordOnce(
                                              parent:
                                                  _model.buyerDoc?.reference,
                                              queryBuilder:
                                                  (suggestionsRecord) =>
                                                      suggestionsRecord.where(
                                                'property_data.id',
                                                isEqualTo: widget.propertyId,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            if (!(_model.activeSuggestionDoc !=
                                                null)) {
                                              var suggestionsRecordReference =
                                                  SuggestionsRecord.createDoc(
                                                      _model
                                                          .buyerDoc!.reference);
                                              await suggestionsRecordReference
                                                  .set(
                                                      createSuggestionsRecordData(
                                                propertyData:
                                                    updatePropertyDataClassStruct(
                                                  _model.property,
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                createdAt: getCurrentTimestamp,
                                              ));
                                              _model.suggestionDoc = SuggestionsRecord
                                                  .getDocumentFromData(
                                                      createSuggestionsRecordData(
                                                        propertyData:
                                                            updatePropertyDataClassStruct(
                                                          _model.property,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        createdAt:
                                                            getCurrentTimestamp,
                                                      ),
                                                      suggestionsRecordReference);

                                              await _model
                                                  .suggestionDoc!.reference
                                                  .update(
                                                      createSuggestionsRecordData(
                                                id: _model.suggestionDoc
                                                    ?.reference.id,
                                              ));
                                              triggerPushNotification(
                                                notificationTitle:
                                                    '💡 New Property from $currentUserDisplayName',
                                                notificationText:
                                                    '${functions.formatAddressFromModel(_model.property!.address, '')} • ${formatNumber(
                                                  _model.property?.listPrice,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                  currency: '\$',
                                                )} -  Your agent thinks you\'ll love this one. View now!',
                                                notificationImageUrl: functions
                                                    .stringToImagePath(_model
                                                        .property
                                                        ?.media
                                                        .firstOrNull),
                                                notificationSound: 'default',
                                                userRefs: [
                                                  _model.buyerDoc!.reference
                                                ],
                                                initialPageName:
                                                    'my_homes_page',
                                                parameterData: {
                                                  'isSuggest': true,
                                                },
                                              );

                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set(
                                                      createNotificationsRecordData(
                                                    userRef: _model
                                                        .buyerDoc?.reference,
                                                    notificationTitle:
                                                        '💡 New Property from $currentUserDisplayName',
                                                    notificationBody:
                                                        '${functions.formatAddressFromModel(_model.property!.address, '')} • ${formatNumber(
                                                      _model
                                                          .property?.listPrice,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.automatic,
                                                      currency: '\$',
                                                    )} -  Your agent thinks you\'ll love this one. View now!',
                                                    createdTime:
                                                        getCurrentTimestamp,
                                                    isRead: false,
                                                  ));
                                              if (_model
                                                  .buyerDoc!.hasAcceptedSMS) {
                                                _model.suggestionAgentToBuyer =
                                                    actions
                                                        .generatePropertySuggestionEmail(
                                                  _model.property!,
                                                  _model.buyerDoc!.displayName,
                                                  currentUserDisplayName,
                                                  currentPhoneNumber,
                                                  currentUserEmail,
                                                  FFAppState().appLogo,
                                                  'partnerpro://app.page/myHomesPage?isSuggest=true',
                                                );
                                                _model.propertySuggestionSMS =
                                                    actions
                                                        .generatePropertySuggestionSMS(
                                                  _model.property!,
                                                  _model.buyerDoc!.displayName,
                                                  currentUserDisplayName,
                                                );
                                                _model.smsProvider =
                                                    SMSProviderStruct(
                                                  recipient: _model
                                                      .buyerDoc?.phoneNumber,
                                                  content: _model
                                                      .propertySuggestionSMS,
                                                );
                                                _model.emailProvider =
                                                    EmailProviderStruct(
                                                  from: FFAppState().fromEmail,
                                                  to: _model.buyerDoc?.email,
                                                  cc: _model.buyerDoc?.email,
                                                  subject:
                                                      'Property Suggestion: ${functions.formatAddressFromModel(_model.property!.address, '')}',
                                                  contentType: 'text/html',
                                                  body: _model
                                                      .suggestionAgentToBuyer,
                                                );
                                                safeSetState(() {});
                                                _model.apiResulte4h =
                                                    await EmailApiGroup
                                                        .postEmailCall
                                                        .call(
                                                  requesterId: currentUserUid,
                                                  dataJson: _model.emailProvider
                                                      ?.toMap(),
                                                );

                                                if ((_model.apiResulte4h
                                                        ?.succeeded ??
                                                    true)) {
                                                  if (_model.buyerDoc
                                                              ?.phoneNumber !=
                                                          null &&
                                                      _model.buyerDoc
                                                              ?.phoneNumber !=
                                                          '') {
                                                    _model.apiResulttfn3 =
                                                        await EmailApiGroup
                                                            .postSMSCall
                                                            .call(
                                                      requesterId:
                                                          currentUserUid,
                                                      dataJson: _model
                                                          .smsProvider
                                                          ?.toMap(),
                                                    );

                                                    if (!(_model.apiResulttfn3
                                                            ?.succeeded ??
                                                        true)) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            '[SMS] Failed to notify Buyer, but worry out.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }
                                                  }
                                                }
                                                Navigator.pop(context);
                                                Navigator.pop(context);
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
                                                      child: CustomDialogWidget(
                                                        icon: Icon(
                                                          Icons.home,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          size: 32.0,
                                                        ),
                                                        title:
                                                            'Suggestion Sent',
                                                        description:
                                                            '${memberItem.fullName} has been linked to this property.',
                                                        buttonLabel: 'Continue',
                                                        iconBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .success,
                                                        onDone: () async {},
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            } else {
                                              var confirmDialogResponse =
                                                  await showDialog<bool>(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Member Already Linked'),
                                                            content: Text(
                                                                '${memberItem.fullName} is already linked to this property. Would you like to remove them instead?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        false),
                                                                child: Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        true),
                                                                child: Text(
                                                                    'Remove'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ) ??
                                                      false;
                                              if (confirmDialogResponse) {
                                                await _model
                                                    .activeSuggestionDoc!
                                                    .reference
                                                    .delete();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
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
                                                      child: CustomDialogWidget(
                                                        icon: Icon(
                                                          Icons.home,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          size: 32.0,
                                                        ),
                                                        title:
                                                            'Unsuggest Property',
                                                        description:
                                                            '${memberItem.fullName} has been unlinked to this property.',
                                                        buttonLabel: 'Continue',
                                                        iconBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        onDone: () async {},
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  safeSetState(() {});
                                },
                                text: 'Suggest',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
