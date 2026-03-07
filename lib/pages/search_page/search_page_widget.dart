import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/agent/components/app_logo/app_logo_widget.dart';
import '/agent/components/notification_popup/notification_popup_widget.dart';
import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/search_result_popup_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/search/search_components/filter_location_popup/filter_location_popup_widget.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/pages/search/search_filter/search_filter_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    super.key,
    required this.userType,
  });

  final UserType? userType;

  static String routeName = 'search_page';
  static String routePath = '/search';

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget>
    with TickerProviderStateMixin {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.isLoading = true;
      safeSetState(() {});
      await requestPermission(locationPermission);
      if (await getPermissionStatus(locationPermission)) {
        _model.apiPlaceNameResults = await GetPlaceNameCall.call(
          latitude: functions.extractLatLong(true, currentUserLocationValue!),
          longitude: functions.extractLatLong(false, currentUserLocationValue!),
        );

        if ((_model.apiPlaceNameResults?.succeeded ?? true)) {
          _model.initialProperties2 =
              await IwoSellerPropertiesApiGroup.getAllPropertiesCall.call(
            user: currentUserUid,
            city: functions
                .extractZipCode(GetPlaceNameCall.placeName(
                  (_model.apiPlaceNameResults?.jsonBody ?? ''),
                )!
                    .firstOrNull!)
                ?.city,
            state: functions
                .extractZipCode(GetPlaceNameCall.placeName(
                  (_model.apiPlaceNameResults?.jsonBody ?? ''),
                )!
                    .firstOrNull!)
                ?.state,
          );

          if ((_model.initialProperties2?.succeeded ?? true)) {
            _model.initialResults = ((_model.initialProperties2?.jsonBody ?? '')
                    .toList()
                    .map<PropertyDataClassStruct?>(
                        PropertyDataClassStruct.maybeFromMap)
                    .toList() as Iterable<PropertyDataClassStruct?>)
                .withoutNulls
                .toList()
                .cast<PropertyDataClassStruct>();
            safeSetState(() {});
            _model.isLoading = false;
            safeSetState(() {});
          } else {
            _model.hasNetworkFailed = true;
            safeSetState(() {});
            await actions.printWeb(
              (_model.initialProperties2?.exceptionMessage ?? ''),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to show initial properties',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                      ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        } else {
          _model.initialProperties3 =
              await IwoSellerPropertiesApiGroup.getAllPropertiesCall.call(
            city: 'Crandall',
            user: currentUserUid,
            state: 'TX',
          );

          if ((_model.initialProperties3?.succeeded ?? true)) {
            _model.initialResults = ((_model.initialProperties3?.jsonBody ?? '')
                    .toList()
                    .map<PropertyDataClassStruct?>(
                        PropertyDataClassStruct.maybeFromMap)
                    .toList() as Iterable<PropertyDataClassStruct?>)
                .withoutNulls
                .toList()
                .cast<PropertyDataClassStruct>();
            safeSetState(() {});
            _model.isLoading = false;
            safeSetState(() {});
          } else {
            _model.hasNetworkFailed = true;
            safeSetState(() {});
            await actions.printWeb(
              (_model.initialProperties3?.exceptionMessage ?? ''),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to show initial properties',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                      ),
                ),
                duration: Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        }
      } else {
        _model.initialProperties1 =
            await IwoSellerPropertiesApiGroup.getAllPropertiesCall.call(
          city: 'Crandall',
          user: currentUserUid,
          state: 'TX',
        );

        if ((_model.initialProperties1?.succeeded ?? true)) {
          _model.initialResults = ((_model.initialProperties1?.jsonBody ?? '')
                  .toList()
                  .map<PropertyDataClassStruct?>(
                      PropertyDataClassStruct.maybeFromMap)
                  .toList() as Iterable<PropertyDataClassStruct?>)
              .withoutNulls
              .toList()
              .cast<PropertyDataClassStruct>();
          safeSetState(() {});
          _model.isLoading = false;
          safeSetState(() {});
        } else {
          _model.hasNetworkFailed = true;
          safeSetState(() {});
          await actions.printWeb(
            (_model.initialProperties1?.exceptionMessage ?? ''),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to show initial properties',
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      }
    });

    _model.searchPropertyTextController ??= TextEditingController();
    _model.searchPropertyFocusNode ??= FocusNode();

    animationsMap.addAll({
      'progressBarOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.userType == UserType.Buyer)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  wrapWithModel(
                                    model: _model.appLogoModel,
                                    updateCallback: () => safeSetState(() {}),
                                    updateOnChange: true,
                                    child: AppLogoWidget(
                                      isAuth: true,
                                      onProfileTap: () async {},
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) => StreamBuilder<
                                        List<NotificationsRecord>>(
                                      stream: queryNotificationsRecord(
                                        queryBuilder: (notificationsRecord) =>
                                            notificationsRecord
                                                .where(
                                                  'user_ref',
                                                  isEqualTo:
                                                      currentUserReference,
                                                )
                                                .where(
                                                  'is_read',
                                                  isEqualTo: false,
                                                ),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<NotificationsRecord>
                                            badgeNotificationsRecordList =
                                            snapshot.data!;

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showDialog(
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child:
                                                        NotificationPopupWidget(),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: badges.Badge(
                                            badgeContent: Text(
                                              valueOrDefault<String>(
                                                badgeNotificationsRecordList
                                                    .length
                                                    .toString(),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    fontSize: 8.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                            showBadge:
                                                badgeNotificationsRecordList
                                                    .isNotEmpty,
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.circle,
                                              badgeColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              elevation: 4.0,
                                              padding: EdgeInsets.all(6.0),
                                            ),
                                            badgeAnimation:
                                                badges.BadgeAnimation.scale(
                                              toAnimate: true,
                                            ),
                                            position:
                                                badges.BadgePosition.topEnd(),
                                            child: FaIcon(
                                              FontAwesomeIcons.bell,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      TextFormField(
                                        controller:
                                            _model.searchPropertyTextController,
                                        focusNode:
                                            _model.searchPropertyFocusNode,
                                        autofocus: false,
                                        textInputAction: TextInputAction.search,
                                        readOnly: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Enter an address, city, or ZIP code',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          prefixIcon: Icon(
                                            Icons.search_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        validator: _model
                                            .searchPropertyTextControllerValidator
                                            .asValidator(context),
                                      ),
                                      Builder(
                                        builder: (context) => InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (!_model.isLoading) {
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
                                                                0.0, -1.0)
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
                                                          SearchResultPopupWidget(
                                                        onSelect:
                                                            (query) async {
                                                          var shouldSetState =
                                                              false;
                                                          _model.isLoading =
                                                              true;
                                                          _model.isMapView =
                                                              true;
                                                          _model.filteredResults =
                                                              [];
                                                          _model.filterFields =
                                                              null;
                                                          safeSetState(() {});
                                                          safeSetState(() {
                                                            _model
                                                                .searchPropertyTextController
                                                                ?.text = query;
                                                          });
                                                          _model.locationZpid =
                                                              await GetPropertyzpidCall
                                                                  .call(
                                                            location: query,
                                                          );

                                                          shouldSetState = true;
                                                          if ((_model
                                                                  .locationZpid
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if ((int? var1) {
                                                              return var1 !=
                                                                  null;
                                                            }(GetPropertyzpidCall
                                                                .zpid(
                                                              (_model.locationZpid
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            ))) {
                                                              _model.selectedPropertyZpid =
                                                                  GetPropertyzpidCall
                                                                      .zpid(
                                                                (_model.locationZpid
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              );
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              if (!functions
                                                                  .isEmptyListOrMap((_model
                                                                          .locationZpid
                                                                          ?.jsonBody ??
                                                                      ''))) {
                                                                if (!((String
                                                                    var1) {
                                                                  return var1
                                                                      .contains(
                                                                          "props");
                                                                }((_model.locationZpid
                                                                            ?.jsonBody ??
                                                                        '')
                                                                    .toString()))) {
                                                                  await showDialog(
                                                                    barrierDismissible:
                                                                        false,
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
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.8,
                                                                            child:
                                                                                FilterLocationPopupWidget(
                                                                              locations: ((_model.locationZpid?.jsonBody ?? '').toList().map<LocationZpidStruct?>(LocationZpidStruct.maybeFromMap).toList() as Iterable<LocationZpidStruct?>).withoutNulls,
                                                                              query: query,
                                                                              onTap: (value, querySearch) async {
                                                                                var shouldSetState = false;
                                                                                Navigator.pop(context);
                                                                                if (!((String var1) {
                                                                                  return var1.contains('community_address');
                                                                                }(value.addressType))) {
                                                                                  _model.selectedPropertyZpid = value.zpid;
                                                                                  safeSetState(() {});
                                                                                  safeSetState(() {
                                                                                    _model.searchPropertyTextController?.text = value.address;
                                                                                  });
                                                                                } else {
                                                                                  _model.citySearchProperties1 = await IwoSellerPropertiesApiGroup.getAllPropertiesCall.call(
                                                                                    city: functions.extractLocation(querySearch, true),
                                                                                    state: functions.extractLocation(querySearch, false),
                                                                                    user: currentUserUid,
                                                                                  );

                                                                                  shouldSetState = true;
                                                                                  if ((_model.citySearchProperties1?.succeeded ?? true) && (((_model.citySearchProperties1?.jsonBody ?? '').toList().map<PropertyDataClassStruct?>(PropertyDataClassStruct.maybeFromMap).toList() as Iterable<PropertyDataClassStruct?>).withoutNulls.isNotEmpty)) {
                                                                                    _model.initialResults = ((_model.citySearchProperties1?.jsonBody ?? '').toList().map<PropertyDataClassStruct?>(PropertyDataClassStruct.maybeFromMap).toList() as Iterable<PropertyDataClassStruct?>).withoutNulls.toList().cast<PropertyDataClassStruct>();
                                                                                    safeSetState(() {});
                                                                                    _model.isLoading = false;
                                                                                    safeSetState(() {});
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          'No property found with that address.',
                                                                                          style: TextStyle(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          ),
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 4000),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).error,
                                                                                      ),
                                                                                    );
                                                                                    _model.isLoading = false;
                                                                                    safeSetState(() {});
                                                                                    safeSetState(() {
                                                                                      _model.searchPropertyTextController?.text = functions.formatAddressFromModel(_model.selectedProperty!.address, '');
                                                                                    });
                                                                                  }

                                                                                  return;
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  _model.citySearchProperties =
                                                                      await IwoSellerPropertiesApiGroup
                                                                          .getAllPropertiesCall
                                                                          .call(
                                                                    city: functions
                                                                        .extractLocation(
                                                                            query,
                                                                            true),
                                                                    state: functions
                                                                        .extractLocation(
                                                                            query,
                                                                            false),
                                                                    user:
                                                                        currentUserUid,
                                                                  );

                                                                  shouldSetState =
                                                                      true;
                                                                  if ((_model.citySearchProperties
                                                                              ?.succeeded ??
                                                                          true) &&
                                                                      (((_model.citySearchProperties?.jsonBody ?? '')
                                                                              .toList()
                                                                              .map<PropertyDataClassStruct?>(PropertyDataClassStruct.maybeFromMap)
                                                                              .toList() as Iterable<PropertyDataClassStruct?>)
                                                                          .withoutNulls
                                                                          .isNotEmpty)) {
                                                                    _model
                                                                        .initialResults = ((_model.citySearchProperties?.jsonBody ??
                                                                                '')
                                                                            .toList()
                                                                            .map<PropertyDataClassStruct?>(PropertyDataClassStruct.maybeFromMap)
                                                                            .toList() as Iterable<PropertyDataClassStruct?>)
                                                                        .withoutNulls
                                                                        .toList()
                                                                        .cast<PropertyDataClassStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.isLoading =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'No property found with that address.',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                      ),
                                                                    );
                                                                    _model.isLoading =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(
                                                                        () {
                                                                      _model.searchPropertyTextController?.text = functions.formatAddressFromModel(
                                                                          _model
                                                                              .selectedProperty!
                                                                              .address,
                                                                          '');
                                                                    });
                                                                    return;
                                                                  }

                                                                  return;
                                                                }

                                                                return;
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'No property found with that address.',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                  ),
                                                                );
                                                                _model.isLoading =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                safeSetState(
                                                                    () {
                                                                  _model.searchPropertyTextController
                                                                          ?.text =
                                                                      functions.formatAddressFromModel(
                                                                          _model
                                                                              .selectedProperty!
                                                                              .address,
                                                                          '');
                                                                });
                                                                return;
                                                              }
                                                            }

                                                            _model.searchPropertyByZipIdCopy =
                                                                await IwoSellerPropertiesApiGroup
                                                                    .getPropertiesByZipIdCall
                                                                    .call(
                                                              zpId: _model
                                                                  .selectedPropertyZpid
                                                                  ?.toString(),
                                                              userId:
                                                                  currentUserUid,
                                                            );

                                                            shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .searchPropertyByZipIdCopy
                                                                    ?.succeeded ??
                                                                true)) {
                                                              _model.selectedProperty =
                                                                  PropertyDataClassStruct(
                                                                id: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.id,
                                                                bathrooms: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.bathrooms,
                                                                bedrooms: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.bedrooms,
                                                                listPrice: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.listPrice,
                                                                lotSize: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.lotSize,
                                                                media: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.media,
                                                                notes: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.notes,
                                                                propertyType: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.propertyType,
                                                                mlsId: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.mlsId,
                                                                yearBuilt: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.yearBuilt,
                                                                latitude: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.latitude,
                                                                longitude: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.longitude,
                                                                sellerId: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.sellerId,
                                                                address:
                                                                    AddressDataClassStruct(
                                                                  streetName: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .streetName,
                                                                  streetNumber: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .streetNumber,
                                                                  streetDirection: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .streetDirection,
                                                                  streetType: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .streetType,
                                                                  neighborhood: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .neighborhood,
                                                                  city: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .city,
                                                                  state: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .state,
                                                                  zip: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .zip,
                                                                  zipPlus4: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                          (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                              ''))
                                                                      ?.address
                                                                      .zipPlus4,
                                                                ),
                                                                squareFootage: functions.parseSquareFootage(PropertyDataByZIPIDStruct.maybeFromMap((_model
                                                                            .searchPropertyByZipIdCopy
                                                                            ?.jsonBody ??
                                                                        ''))!
                                                                    .squareFootage),
                                                              );
                                                              safeSetState(
                                                                  () {});
                                                              _model.selectionPropertiesCopy =
                                                                  await IwoSellerPropertiesApiGroup
                                                                      .getAllPropertiesCall
                                                                      .call(
                                                                user:
                                                                    currentUserUid,
                                                                city: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.address
                                                                    .city,
                                                                state: PropertyDataByZIPIDStruct.maybeFromMap(
                                                                        (_model.searchPropertyByZipIdCopy?.jsonBody ??
                                                                            ''))
                                                                    ?.address
                                                                    .state,
                                                              );

                                                              shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .searchPropertyByZipIdCopy
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                _model
                                                                    .initialResults = ((_model.selectionPropertiesCopy?.jsonBody ??
                                                                            '')
                                                                        .toList()
                                                                        .map<PropertyDataClassStruct?>(
                                                                            PropertyDataClassStruct.maybeFromMap)
                                                                        .toList() as Iterable<PropertyDataClassStruct?>)
                                                                    .withoutNulls
                                                                    .toList()
                                                                    .cast<PropertyDataClassStruct>();
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Failed to show neighbor properties',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleSmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                          ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                  ),
                                                                );
                                                              }
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Failed to get location zpid!',
                                                                  style:
                                                                      TextStyle(
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
                                                                        .error,
                                                              ),
                                                            );
                                                          }

                                                          _model.isLoading =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50.0,
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  children: [
                                    Builder(
                                      builder: (context) => InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: SearchFilterWidget(
                                                    propertyItems: _model
                                                            .filteredResults
                                                            .isNotEmpty
                                                        ? _model.filteredResults
                                                        : _model.initialResults,
                                                    filterData:
                                                        _model.filterFields,
                                                    onApply: (filteredItems,
                                                        filterFields) async {
                                                      if (!(filteredItems !=
                                                              null &&
                                                          (filteredItems)
                                                              .isNotEmpty)) {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      1.0, 0.0)
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
                                                                    Icons
                                                                        .info_sharp,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 36.0,
                                                                  ),
                                                                  title:
                                                                      'No Results Found',
                                                                  description:
                                                                      'The filtered fields don\'t match any property.',
                                                                  buttonLabel:
                                                                      'Cancel',
                                                                  onDone:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        _model.filteredResults =
                                                            filteredItems
                                                                .toList()
                                                                .cast<
                                                                    PropertyDataClassStruct>();
                                                        _model.filterFields =
                                                            filterFields;
                                                        safeSetState(() {});
                                                        if (_model.isMapView) {
                                                          _model.isMapView =
                                                              false;
                                                          safeSetState(() {});
                                                          await Future.delayed(
                                                            Duration(
                                                              milliseconds: 5,
                                                            ),
                                                          );
                                                          _model.isMapView =
                                                              true;
                                                          safeSetState(() {});
                                                        }
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    onReset: () async {
                                                      _model.filteredResults =
                                                          [];
                                                      _model.filterFields =
                                                          null;
                                                      safeSetState(() {});
                                                      if (_model.isMapView) {
                                                        _model.isMapView =
                                                            false;
                                                        safeSetState(() {});
                                                        await Future.delayed(
                                                          Duration(
                                                            milliseconds: 10,
                                                          ),
                                                        );
                                                        _model.isMapView = true;
                                                        safeSetState(() {});
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: Icon(
                                          Icons.filter_alt,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    if (_model.filterFields != null)
                                      Icon(
                                        Icons.circle_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .accent2,
                                        size: 10.0,
                                      ),
                                  ],
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (!_model.isLoading) {
                                              return Text(
                                                '${valueOrDefault<String>(
                                                  _model
                                                      .initialResults
                                                      .firstOrNull
                                                      ?.address
                                                      .city,
                                                  'City',
                                                )}, ${valueOrDefault<String>(
                                                  _model
                                                      .initialResults
                                                      .firstOrNull
                                                      ?.address
                                                      .state,
                                                  'State',
                                                )}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                              );
                                            } else {
                                              return Container(
                                                width: 10.0,
                                                height: 10.0,
                                                decoration: BoxDecoration(),
                                              );
                                            }
                                          },
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.isMapView =
                                                !_model.isMapView;
                                            safeSetState(() {});
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (_model.isMapView)
                                                FaIcon(
                                                  FontAwesomeIcons.listUl,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent2,
                                                  size: 24.0,
                                                ),
                                              if (!_model.isMapView)
                                                FaIcon(
                                                  FontAwesomeIcons
                                                      .globeAmericas,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent2,
                                                  size: 24.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (!_model.isMapView) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 8.0),
                                          child: FlutterFlowChoiceChips(
                                            options: [
                                              ChipData('Price (High to Low)',
                                                  Icons.attach_money_sharp),
                                              ChipData('Price (Low to High)',
                                                  Icons.attach_money_sharp),
                                              ChipData('Bedrooms',
                                                  FontAwesomeIcons.bed),
                                              ChipData('Bathrooms',
                                                  FontAwesomeIcons.bath),
                                              ChipData('Square Feet',
                                                  Icons.square_foot_outlined)
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(() =>
                                                  _model.sortChoiceChipsValue =
                                                      val?.firstOrNull);
                                              _model.isLoading = true;
                                              safeSetState(() {});
                                              _model.sortedProperties =
                                                  await actions.sortProperties(
                                                (_model.filteredResults
                                                            .isNotEmpty
                                                        ? _model.filteredResults
                                                        : _model.initialResults)
                                                    .toList(),
                                                _model.sortChoiceChipsValue!,
                                              );
                                              if (!(_model.filteredResults
                                                  .isNotEmpty)) {
                                                _model.initialResults = _model
                                                    .sortedProperties!
                                                    .toList()
                                                    .cast<
                                                        PropertyDataClassStruct>();
                                                safeSetState(() {});
                                              } else {
                                                _model.filteredResults = _model
                                                    .sortedProperties!
                                                    .toList()
                                                    .cast<
                                                        PropertyDataClassStruct>();
                                                safeSetState(() {});
                                              }

                                              _model.isLoading = false;
                                              safeSetState(() {});

                                              safeSetState(() {});
                                            },
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              iconSize: 16.0,
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle: FlutterFlowTheme.of(
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
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 16.0,
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            chipSpacing: 8.0,
                                            rowSpacing: 8.0,
                                            multiselect: false,
                                            alignment: WrapAlignment.start,
                                            controller: _model
                                                    .sortChoiceChipsValueController ??=
                                                FormFieldController<
                                                    List<String>>(
                                              [],
                                            ),
                                            wrapped: false,
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 8.0),
                                          child: FlutterFlowChoiceChips(
                                            options: [
                                              ChipData('For Sale',
                                                  Icons.other_houses_outlined),
                                              ChipData('Sold',
                                                  Icons.attach_money_sharp)
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(() =>
                                                  _model.saleChoiceChipsValue =
                                                      val?.firstOrNull);
                                              _model.isLoading = true;
                                              safeSetState(() {});
                                              _model.saleProperties =
                                                  await IwoSellerPropertiesApiGroup
                                                      .getAllPropertiesCall
                                                      .call(
                                                user: currentUserUid,
                                                city: functions
                                                    .extractZipCode(
                                                        GetPlaceNameCall
                                                                .placeName(
                                                      (_model.apiPlaceNameResults
                                                              ?.jsonBody ??
                                                          ''),
                                                    )!
                                                            .firstOrNull!)
                                                    ?.city,
                                                state: functions
                                                    .extractZipCode(
                                                        GetPlaceNameCall
                                                                .placeName(
                                                      (_model.apiPlaceNameResults
                                                              ?.jsonBody ??
                                                          ''),
                                                    )!
                                                            .firstOrNull!)
                                                    ?.state,
                                                statusType:
                                                    _model.saleChoiceChipsValue ==
                                                            'Sold'
                                                        ? 'RecentlySold'
                                                        : 'ForSale',
                                                isPendingUnderContract: 0,
                                              );

                                              if ((_model.saleProperties
                                                      ?.succeeded ??
                                                  true)) {
                                                _model.initialResults = ((_model
                                                                    .saleProperties
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toList()
                                                            .map<PropertyDataClassStruct?>(
                                                                PropertyDataClassStruct
                                                                    .maybeFromMap)
                                                            .toList()
                                                        as Iterable<
                                                            PropertyDataClassStruct?>)
                                                    .withoutNulls
                                                    .toList()
                                                    .cast<
                                                        PropertyDataClassStruct>();
                                                safeSetState(() {});
                                                _model.isLoading = false;
                                                safeSetState(() {});
                                              } else {
                                                _model.hasNetworkFailed = true;
                                                safeSetState(() {});
                                                await actions.printWeb(
                                                  (_model.saleProperties
                                                          ?.exceptionMessage ??
                                                      ''),
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              iconSize: 16.0,
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle: FlutterFlowTheme.of(
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
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 16.0,
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            chipSpacing: 8.0,
                                            rowSpacing: 8.0,
                                            multiselect: false,
                                            initialized:
                                                _model.saleChoiceChipsValue !=
                                                    null,
                                            alignment: WrapAlignment.start,
                                            controller: _model
                                                    .saleChoiceChipsValueController ??=
                                                FormFieldController<
                                                    List<String>>(
                                              ['For Sale'],
                                            ),
                                            wrapped: true,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                if (!_model.hasNetworkFailed) {
                                  return Builder(
                                    builder: (context) {
                                      if (!_model.isLoading) {
                                        return Builder(
                                          builder: (context) {
                                            if (_model.isMapView) {
                                              return Stack(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: custom_widgets
                                                        .CustomMarkersMap(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      centerLatitude: _model
                                                                  .selectedProperty !=
                                                              null
                                                          ? _model
                                                              .selectedProperty!
                                                              .latitude
                                                          : _model
                                                              .initialResults
                                                              .firstOrNull!
                                                              .latitude,
                                                      centerLongitude: _model
                                                                  .selectedProperty !=
                                                              null
                                                          ? _model
                                                              .selectedProperty!
                                                              .longitude
                                                          : _model
                                                              .initialResults
                                                              .firstOrNull!
                                                              .longitude,
                                                      zoomLevel: 12.0,
                                                      markerColor: _model
                                                                  .saleChoiceChipsValue ==
                                                              'Sold'
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .accent1,
                                                      priceFontSize: 38.0,
                                                      allowZoom: true,
                                                      showZoomControls: false,
                                                      showLocation: true,
                                                      showCompass: false,
                                                      showMapToolbar: false,
                                                      showTraffic: false,
                                                      properties: _model
                                                                  .filterFields !=
                                                              null
                                                          ? _model
                                                              .filteredResults
                                                          : _model
                                                              .initialResults,
                                                      initialProperty: _model
                                                          .selectedProperty,
                                                      onCardTap:
                                                          (property) async {
                                                        if (!FFAppState()
                                                            .isNavigating) {
                                                          FFAppState()
                                                                  .isNavigating =
                                                              true;
                                                          safeSetState(() {});
                                                          _model.getSavedSearches =
                                                              await IwoUsersSavedSearchApiGroup
                                                                  .getSavedSearchesCall
                                                                  .call(
                                                            userId:
                                                                currentUserUid,
                                                          );

                                                          if ((_model
                                                                  .getSavedSearches
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if (!functions
                                                                .isEmptyListOrMap((_model
                                                                        .getSavedSearches
                                                                        ?.jsonBody ??
                                                                    ''))) {
                                                              _model.filteredSavedProperties1 =
                                                                  await actions
                                                                      .filteredSavedProperties(
                                                                IwoUsersSavedSearchApiGroup
                                                                    .getSavedSearchesCall
                                                                    .savedProperties(
                                                                      (_model.getSavedSearches
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )!
                                                                    .toList(),
                                                              );
                                                              if (!valueOrDefault<
                                                                  bool>(
                                                                functions.hasPropertyId(
                                                                    _model
                                                                        .filteredSavedProperties1!
                                                                        .toList(),
                                                                    property!
                                                                        .id),
                                                                true,
                                                              )) {
                                                                _model.insertSavedSearch =
                                                                    await IwoUsersSavedSearchApiGroup
                                                                        .insertSavedSearchCall
                                                                        .call(
                                                                  userId:
                                                                      currentUserUid,
                                                                  inputField: functions
                                                                      .formatAddressFromModel(
                                                                          property
                                                                              .address,
                                                                          ''),
                                                                  status: true,
                                                                  propertyJson:
                                                                      property
                                                                          .toMap(),
                                                                );

                                                                if ((_model
                                                                        .insertSavedSearch
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  context
                                                                      .pushNamed(
                                                                    PropertyDetailsPageWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'propertyId':
                                                                          serializeParam(
                                                                        property
                                                                            .id,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'isUserFromSearch':
                                                                          serializeParam(
                                                                        true,
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Failed to save recent viewed property',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .error,
                                                                    ),
                                                                  );
                                                                }
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  PropertyDetailsPageWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'propertyId':
                                                                        serializeParam(
                                                                      property
                                                                          .id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'isUserFromSearch':
                                                                        serializeParam(
                                                                      true,
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            } else {
                                                              _model.insertSavedSearch1 =
                                                                  await IwoUsersSavedSearchApiGroup
                                                                      .insertSavedSearchCall
                                                                      .call(
                                                                userId:
                                                                    currentUserUid,
                                                                inputField: functions
                                                                    .formatAddressFromModel(
                                                                        property!
                                                                            .address,
                                                                        ''),
                                                                status: true,
                                                                propertyJson:
                                                                    property
                                                                        .toMap(),
                                                              );

                                                              if ((_model
                                                                      .insertSavedSearch1
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                context
                                                                    .pushNamed(
                                                                  PropertyDetailsPageWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'propertyId':
                                                                        serializeParam(
                                                                      property
                                                                          .id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'isUserFromSearch':
                                                                        serializeParam(
                                                                      true,
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Failed to save recent viewed property',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                  ),
                                                                );
                                                              }
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Failed getSavedSearches',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                              ),
                                                            );
                                                          }
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final listInitialProperties = (_model
                                                                  .filteredResults
                                                                  .isNotEmpty
                                                              ? _model
                                                                  .filteredResults
                                                              : _model
                                                                  .initialResults)
                                                          .toList();
                                                      if (listInitialProperties
                                                          .isEmpty) {
                                                        return Center(
                                                          child:
                                                              EmptyListingWidget(
                                                            title:
                                                                'Empty Listing',
                                                            description:
                                                                'No properties found',
                                                            onTap: () async {},
                                                          ),
                                                        );
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            listInitialProperties
                                                                .length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 20.0),
                                                        itemBuilder: (context,
                                                            listInitialPropertiesIndex) {
                                                          final listInitialPropertiesItem =
                                                              listInitialProperties[
                                                                  listInitialPropertiesIndex];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              var shouldSetState =
                                                                  false;
                                                              if (!FFAppState()
                                                                  .isNavigating) {
                                                                FFAppState()
                                                                        .isNavigating =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                                _model.getSavedSearches1 =
                                                                    await IwoUsersSavedSearchApiGroup
                                                                        .getSavedSearchesCall
                                                                        .call(
                                                                  userId:
                                                                      currentUserUid,
                                                                );

                                                                shouldSetState =
                                                                    true;
                                                                if ((_model
                                                                        .getSavedSearches1
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  if (!functions
                                                                      .isEmptyListOrMap((_model
                                                                              .getSavedSearches1
                                                                              ?.jsonBody ??
                                                                          ''))) {
                                                                    _model.filteredSavedProperties =
                                                                        await actions
                                                                            .filteredSavedProperties(
                                                                      IwoUsersSavedSearchApiGroup
                                                                          .getSavedSearchesCall
                                                                          .savedProperties(
                                                                            (_model.getSavedSearches1?.jsonBody ??
                                                                                ''),
                                                                          )!
                                                                          .toList(),
                                                                    );
                                                                    shouldSetState =
                                                                        true;
                                                                    if (!functions.hasPropertyId(
                                                                        _model
                                                                            .filteredSavedProperties!
                                                                            .toList(),
                                                                        listInitialPropertiesItem
                                                                            .id)) {
                                                                      _model.insertSavedSearch2 = await IwoUsersSavedSearchApiGroup
                                                                          .insertSavedSearchCall
                                                                          .call(
                                                                        userId:
                                                                            currentUserUid,
                                                                        inputField: functions.formatAddressFromModel(
                                                                            listInitialPropertiesItem.address,
                                                                            ''),
                                                                        status:
                                                                            true,
                                                                        propertyJson:
                                                                            listInitialPropertiesItem.toMap(),
                                                                      );

                                                                      shouldSetState =
                                                                          true;
                                                                      if ((_model
                                                                              .insertSavedSearch2
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        if (listInitialPropertiesItem.id !=
                                                                            '') {
                                                                          context
                                                                              .pushNamed(
                                                                            PropertyDetailsPageWidget.routeName,
                                                                            queryParameters:
                                                                                {
                                                                              'propertyId': serializeParam(
                                                                                listInitialPropertiesItem.id,
                                                                                ParamType.String,
                                                                              ),
                                                                              'isUserFromSearch': serializeParam(
                                                                                true,
                                                                                ParamType.bool,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        } else {
                                                                          if (shouldSetState) {
                                                                            safeSetState(() {});
                                                                          }
                                                                          return;
                                                                        }
                                                                      } else {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Failed insertSavedSearch',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).error,
                                                                          ),
                                                                        );
                                                                      }
                                                                    } else {
                                                                      if (listInitialPropertiesItem
                                                                              .id !=
                                                                          '') {
                                                                        context
                                                                            .pushNamed(
                                                                          PropertyDetailsPageWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'propertyId':
                                                                                serializeParam(
                                                                              listInitialPropertiesItem.id,
                                                                              ParamType.String,
                                                                            ),
                                                                            'isUserFromSearch':
                                                                                serializeParam(
                                                                              true,
                                                                              ParamType.bool,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      } else {
                                                                        if (shouldSetState) {
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                        return;
                                                                      }
                                                                    }
                                                                  } else {
                                                                    _model.insertSavedSearch3 =
                                                                        await IwoUsersSavedSearchApiGroup
                                                                            .insertSavedSearchCall
                                                                            .call(
                                                                      userId:
                                                                          currentUserUid,
                                                                      inputField: functions.formatAddressFromModel(
                                                                          listInitialPropertiesItem
                                                                              .address,
                                                                          ''),
                                                                      status:
                                                                          true,
                                                                      propertyJson:
                                                                          listInitialPropertiesItem
                                                                              .toMap(),
                                                                    );

                                                                    shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .insertSavedSearch3
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      if (listInitialPropertiesItem
                                                                              .id !=
                                                                          '') {
                                                                        context
                                                                            .pushNamed(
                                                                          PropertyDetailsPageWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'propertyId':
                                                                                serializeParam(
                                                                              listInitialPropertiesItem.id,
                                                                              ParamType.String,
                                                                            ),
                                                                            'isUserFromSearch':
                                                                                serializeParam(
                                                                              true,
                                                                              ParamType.bool,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      } else {
                                                                        if (shouldSetState) {
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                        return;
                                                                      }
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Failed insertSavedSearch',
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).error,
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Failed getSavedSearches',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .error,
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                              if (shouldSetState) {
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .propertyItemModels
                                                                  .getModel(
                                                                listInitialPropertiesItem
                                                                    .id,
                                                                listInitialPropertiesIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  PropertyItemWidget(
                                                                key: Key(
                                                                  'Keysa9_${listInitialPropertiesItem.id}',
                                                                ),
                                                                property:
                                                                    listInitialPropertiesItem,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircularPercentIndicator(
                                                percent: 0.8,
                                                radius: 25.0,
                                                lineWidth: 5.0,
                                                animation: true,
                                                animateFromLastPercent: true,
                                                progressColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ).animateOnPageLoad(animationsMap[
                                                  'progressBarOnPageLoadAnimation']!),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.emptyListingModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmptyListingWidget(
                                            title:
                                                'Service Temporarily Unavailable',
                                            description:
                                                'Our listing provider is experiencing connectivity issues. Please try again in a moment',
                                            icon: Icon(
                                              Icons.replay,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent2,
                                              size: 54.0,
                                            ),
                                            onTap: () async {
                                              context.goNamed(
                                                SearchPageWidget.routeName,
                                                queryParameters: {
                                                  'userType': serializeParam(
                                                    widget.userType,
                                                    ParamType.Enum,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (widget.userType == UserType.Buyer) {
                      return wrapWithModel(
                        model: _model.buyerBottomNavbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BuyerBottomNavbarWidget(
                          activeNav: BuyerNavbar.Search,
                        ),
                      );
                    } else if (widget.userType == UserType.Agent) {
                      return wrapWithModel(
                        model: _model.agentBottomNavbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AgentBottomNavbarWidget(
                          activeNav: AgentNavbar.Search,
                        ),
                      );
                    } else {
                      return wrapWithModel(
                        model: _model.sellerBottomNavbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: SellerBottomNavbarWidget(
                          activeNav: SellerNavbar.Search,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
