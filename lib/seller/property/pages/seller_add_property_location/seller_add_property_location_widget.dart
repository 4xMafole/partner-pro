import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import 'dart:io';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seller_add_property_location_model.dart';
export 'seller_add_property_location_model.dart';

class SellerAddPropertyLocationWidget extends StatefulWidget {
  const SellerAddPropertyLocationWidget({super.key});

  static String routeName = 'seller_add_property_location';
  static String routePath = '/sellerAddPropertyLocation';

  @override
  State<SellerAddPropertyLocationWidget> createState() =>
      _SellerAddPropertyLocationWidgetState();
}

class _SellerAddPropertyLocationWidgetState
    extends State<SellerAddPropertyLocationWidget> {
  late SellerAddPropertyLocationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerAddPropertyLocationModel());
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
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).tertiary,
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: FlutterFlowPlacePicker(
                            iOSGoogleMapsApiKey:
                                'GOOGLE_MAPS_KEY_REMOVED',
                            androidGoogleMapsApiKey:
                                'GOOGLE_MAPS_KEY_REMOVED',
                            webGoogleMapsApiKey:
                                'GOOGLE_MAPS_KEY_REMOVED',
                            onSelect: (place) async {
                              safeSetState(
                                  () => _model.placePickerValue = place);
                              (await _model.googleMapsController.future)
                                  .animateCamera(CameraUpdate.newLatLng(
                                      place.latLng.toGoogleMaps()));
                            },
                            defaultText:
                                'Enter your address                                     ',
                            icon: Icon(
                              Icons.search,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            buttonOptions: FFButtonOptions(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 0.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Builder(builder: (context) {
                      final _googleMapMarker = _model.placePickerValue.latLng;
                      return FlutterFlowGoogleMap(
                        controller: _model.googleMapsController,
                        onCameraIdle: (latLng) =>
                            _model.googleMapsCenter = latLng,
                        initialLocation: _model.googleMapsCenter ??=
                            LatLng(38.9695, -77.3865),
                        markers: [
                          if (_googleMapMarker != null)
                            FlutterFlowMarker(
                              _googleMapMarker.serialize(),
                              _googleMapMarker,
                            ),
                        ],
                        markerColor: GoogleMarkerColor.yellow,
                        markerImage: MarkerImage(
                          imagePath: _model.priceTag != null &&
                                  _model.priceTag != ''
                              ? _model.priceTag!
                              : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/iwriteoffers-4r87nm/assets/4omfmzrv4n7b/Mask_group.png',
                          isAssetImage: false,
                          size: 55.0 ?? 20,
                        ),
                        mapType: MapType.terrain,
                        style: GoogleMapStyle.standard,
                        initialZoom: 14.0,
                        allowInteraction: true,
                        allowZoom: true,
                        showZoomControls: false,
                        showLocation: false,
                        showCompass: false,
                        showMapToolbar: false,
                        showTraffic: false,
                        centerMapOnMarkerTap: true,
                      );
                    }),
                  ],
                ),
              ),
              if (_model.placePickerValue.zipCode != null &&
                  _model.placePickerValue.zipCode != '')
                SafeArea(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            -2.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Confirm your property loaction',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ],
                              ),
                              FutureBuilder<ApiCallResponse>(
                                future: IwoSellerPropertiesApiGroup
                                    .getPropertiesByZipIdCall
                                    .call(
                                  zpId: '182383011',
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
                                  final containerGetPropertiesByZipIdResponse =
                                      snapshot.data!;

                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.priceTagImage =
                                          await actions.googleMapPriceTag(
                                        '120k',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/iwriteoffers-4r87nm/assets/uf3rw08eej62/loc.png',
                                      );
                                      _model.priceTag = _model.priceTagImage;
                                      safeSetState(() {});

                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: wrapWithModel(
                                        model: _model.sellerPropertyItemModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SellerPropertyItemWidget(
                                          indexItem: 1,
                                          property: PropertyStruct(
                                            propertyType: getJsonField(
                                              containerGetPropertiesByZipIdResponse
                                                  .jsonBody,
                                              r'''$.property_type''',
                                            ).toString(),
                                            description: getJsonField(
                                              containerGetPropertiesByZipIdResponse
                                                  .jsonBody,
                                              r'''$.notes''',
                                            ).toString(),
                                            beds: getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.bedrooms''',
                                                    ) !=
                                                    null
                                                ? getJsonField(
                                                    containerGetPropertiesByZipIdResponse
                                                        .jsonBody,
                                                    r'''$.bedrooms''',
                                                  ).toString()
                                                : '0',
                                            baths: getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.bathrooms''',
                                                    ) !=
                                                    null
                                                ? getJsonField(
                                                    containerGetPropertiesByZipIdResponse
                                                        .jsonBody,
                                                    r'''$.bathrooms''',
                                                  ).toString()
                                                : '0',
                                            sqft: getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.square_footage''',
                                                    ) !=
                                                    null
                                                ? getJsonField(
                                                    containerGetPropertiesByZipIdResponse
                                                        .jsonBody,
                                                    r'''$.square_footage''',
                                                  ).toString()
                                                : '0 sqft',
                                            price: getJsonField(
                                              containerGetPropertiesByZipIdResponse
                                                  .jsonBody,
                                              r'''$.list_price''',
                                            ),
                                            location: LocationStruct(
                                              name: getJsonField(
                                                        containerGetPropertiesByZipIdResponse
                                                            .jsonBody,
                                                        r'''$.address.street_name''',
                                                      ) !=
                                                      null
                                                  ? getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.address.street_name''',
                                                    ).toString()
                                                  : ' ',
                                              latlong:
                                                  functions.doubleToLatLong(
                                                      getJsonField(
                                                        containerGetPropertiesByZipIdResponse
                                                            .jsonBody,
                                                        r'''$.latitude''',
                                                      ),
                                                      getJsonField(
                                                        containerGetPropertiesByZipIdResponse
                                                            .jsonBody,
                                                        r'''$.longitude''',
                                                      )),
                                              zipCode: getJsonField(
                                                containerGetPropertiesByZipIdResponse
                                                    .jsonBody,
                                                r'''$.address.zip''',
                                              ).toString(),
                                              city: getJsonField(
                                                containerGetPropertiesByZipIdResponse
                                                    .jsonBody,
                                                r'''$.address.city''',
                                              ).toString(),
                                            ),
                                            images: getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.media''',
                                                    ) !=
                                                    null
                                                ? (getJsonField(
                                                    containerGetPropertiesByZipIdResponse
                                                        .jsonBody,
                                                    r'''$.media''',
                                                    true,
                                                  ) as List?)
                                                    ?.map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>()
                                                : functions.strToList(
                                                    'https://placehold.co/400x400@2x.png?text=Home'),
                                            listDate: getJsonField(
                                                      containerGetPropertiesByZipIdResponse
                                                          .jsonBody,
                                                      r'''$.list_date''',
                                                    ) !=
                                                    null
                                                ? getJsonField(
                                                    containerGetPropertiesByZipIdResponse
                                                        .jsonBody,
                                                    r'''$.list_date''',
                                                  ).toString()
                                                : 'N/A',
                                          ),
                                          isNew: true,
                                          onTap: () async {},
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ].divide(SizedBox(height: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.apiResultpk5 =
                                  await IwoSellerPropertiesApiGroup
                                      .getPropertiesByZipIdCall
                                      .call(
                                zpId: '182383011',
                              );

                              if ((_model.apiResultpk5?.succeeded ?? true)) {
                                context.pushNamed(
                                  SellerAddPropertyPageWidget.routeName,
                                  queryParameters: {
                                    'pageType': serializeParam(
                                      PropertyAddPage.Edit,
                                      ParamType.Enum,
                                    ),
                                    'place': serializeParam(
                                      LocationStruct(
                                        name: _model.placePickerValue.name,
                                        latlong: _model.placePickerValue.latLng,
                                        city: _model.placePickerValue.city,
                                        state: _model.placePickerValue.state,
                                        country:
                                            _model.placePickerValue.country,
                                        zipCode:
                                            _model.placePickerValue.zipCode,
                                        address:
                                            _model.placePickerValue.address,
                                      ),
                                      ParamType.DataStruct,
                                    ),
                                    'editProperty': serializeParam(
                                      PropertyStruct(
                                        id: PropertyModelStruct.maybeFromMap(
                                                (_model.apiResultpk5
                                                        ?.jsonBody ??
                                                    ''))
                                            ?.id,
                                        propertyType:
                                            PropertyModelStruct.maybeFromMap(
                                                    (_model.apiResultpk5
                                                            ?.jsonBody ??
                                                        ''))
                                                ?.propertyType,
                                        description:
                                            PropertyModelStruct.maybeFromMap(
                                                    (_model.apiResultpk5
                                                            ?.jsonBody ??
                                                        ''))
                                                ?.notes,
                                        beds: functions.strToInt(
                                            PropertyModelStruct.maybeFromMap(
                                                    (_model.apiResultpk5
                                                            ?.jsonBody ??
                                                        ''))
                                                ?.bedrooms),
                                        baths: functions.strToInt(
                                            PropertyModelStruct.maybeFromMap(
                                                    (_model.apiResultpk5
                                                            ?.jsonBody ??
                                                        ''))
                                                ?.bathrooms),
                                        sqft: PropertyModelStruct.maybeFromMap(
                                                (_model.apiResultpk5
                                                        ?.jsonBody ??
                                                    ''))
                                            ?.squareFootage,
                                        price: PropertyModelStruct.maybeFromMap(
                                                (_model.apiResultpk5
                                                        ?.jsonBody ??
                                                    ''))
                                            ?.listPrice,
                                        images:
                                            PropertyModelStruct.maybeFromMap(
                                                    (_model.apiResultpk5
                                                            ?.jsonBody ??
                                                        ''))
                                                ?.media,
                                        location: LocationStruct(
                                          name:
                                              PropertyModelStruct.maybeFromMap(
                                                      (_model.apiResultpk5
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.address
                                                  ?.streetName,
                                          latlong: functions.doubleToLatLong(
                                              PropertyModelStruct.maybeFromMap(
                                                      (_model.apiResultpk5
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.latitude,
                                              PropertyModelStruct.maybeFromMap(
                                                      (_model.apiResultpk5
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.longitude),
                                          zipCode:
                                              PropertyModelStruct.maybeFromMap(
                                                      (_model.apiResultpk5
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.address
                                                  ?.zip,
                                          city:
                                              PropertyModelStruct.maybeFromMap(
                                                      (_model.apiResultpk5
                                                              ?.jsonBody ??
                                                          ''))
                                                  ?.address
                                                  ?.city,
                                        ),
                                        listDate: dateTimeFormat(
                                          "yMMMd",
                                          getCurrentTimestamp,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                      ),
                                      ParamType.DataStruct,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('FAILURE'),
                                      content: Text(
                                          (_model.apiResultpk5?.jsonBody ?? '')
                                              .toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              safeSetState(() {});
                            },
                            text: 'Confirm Location',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
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
