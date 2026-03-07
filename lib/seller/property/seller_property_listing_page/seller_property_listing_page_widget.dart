import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'seller_property_listing_page_model.dart';
export 'seller_property_listing_page_model.dart';

class SellerPropertyListingPageWidget extends StatefulWidget {
  const SellerPropertyListingPageWidget({super.key});

  static String routeName = 'seller_property_listing_page';
  static String routePath = '/sellerPropertyListingPage';

  @override
  State<SellerPropertyListingPageWidget> createState() =>
      _SellerPropertyListingPageWidgetState();
}

class _SellerPropertyListingPageWidgetState
    extends State<SellerPropertyListingPageWidget> {
  late SellerPropertyListingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerPropertyListingPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: wrapWithModel(
                  model: _model.titleLabelModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TitleLabelWidget(
                    title: 'My Homes',
                  ),
                ),
              ),
              if (false)
                Expanded(
                  child: FutureBuilder<ApiCallResponse>(
                    future: GetPropertiesListCall.call(
                      userId: currentUserUid,
                      zillowProperties: false,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 25.0,
                            height: 25.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        );
                      }
                      final stackGetPropertiesListResponse = snapshot.data!;

                      return Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Builder(
                              builder: (context) {
                                final myProperties =
                                    stackGetPropertiesListResponse.jsonBody
                                        .toList();
                                if (myProperties.isEmpty) {
                                  return Center(
                                    child: EmptyListingWidget(
                                      title: 'Add New Property',
                                      description: 'Sell your property now!',
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 58.0,
                                      ),
                                      onTap: () async {
                                        context.pushNamed(
                                            SellerAddPropertyLocationWidget
                                                .routeName);
                                      },
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: myProperties.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 10.0),
                                  itemBuilder: (context, myPropertiesIndex) {
                                    final myPropertiesItem =
                                        myProperties[myPropertiesIndex];
                                    return wrapWithModel(
                                      model: _model.sellerPropertyItemModels1
                                          .getModel(
                                        myPropertiesIndex.toString(),
                                        myPropertiesIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      updateOnChange: true,
                                      child: SellerPropertyItemWidget(
                                        key: Key(
                                          'Key3az_${myPropertiesIndex.toString()}',
                                        ),
                                        property: PropertyStruct(
                                          id: getJsonField(
                                            myPropertiesItem,
                                            r'''$.id''',
                                          ).toString(),
                                          propertyType: getJsonField(
                                            myPropertiesItem,
                                            r'''$.property_type''',
                                          ).toString(),
                                          description: getJsonField(
                                            myPropertiesItem,
                                            r'''$.notes''',
                                          ).toString(),
                                          beds: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.bedrooms''',
                                                  ) !=
                                                  null
                                              ? getJsonField(
                                                  myPropertiesItem,
                                                  r'''$.bedrooms''',
                                                ).toString()
                                              : '0',
                                          baths: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.bathrooms''',
                                                  ) !=
                                                  null
                                              ? getJsonField(
                                                  myPropertiesItem,
                                                  r'''$.bathrooms''',
                                                ).toString()
                                              : '0',
                                          sqft: getJsonField(
                                            myPropertiesItem,
                                            r'''$.square_footage''',
                                          ).toString(),
                                          price: getJsonField(
                                            myPropertiesItem,
                                            r'''$.list_price''',
                                          ),
                                          location: LocationStruct(
                                            name: getJsonField(
                                              myPropertiesItem,
                                              r'''$.address.street_name''',
                                            ).toString(),
                                            latlong: functions.doubleToLatLong(
                                                getJsonField(
                                                  myPropertiesItem,
                                                  r'''$.latitude''',
                                                ),
                                                getJsonField(
                                                  myPropertiesItem,
                                                  r'''$.longitude''',
                                                )),
                                            zipCode: getJsonField(
                                              myPropertiesItem,
                                              r'''$.address.zip''',
                                            ).toString(),
                                            city: getJsonField(
                                              myPropertiesItem,
                                              r'''$.address.city''',
                                            ).toString(),
                                          ),
                                          images: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.media''',
                                                  ) !=
                                                  null
                                              ? (getJsonField(
                                                  myPropertiesItem,
                                                  r'''$.media''',
                                                  true,
                                                ) as List?)
                                                  ?.map<String>(
                                                      (e) => e.toString())
                                                  .toList()
                                                  .cast<String>()
                                              : functions.strToList(
                                                  'https://placehold.co/400x400?text=Home'),
                                          isActive: !getJsonField(
                                            myPropertiesItem,
                                            r'''$.is_sold''',
                                          ),
                                        ),
                                        indexItem: myPropertiesIndex,
                                        onTap: () async {
                                          context.pushNamed(
                                            SellerPropertyDetailsWidget
                                                .routeName,
                                            queryParameters: {
                                              'property': serializeParam(
                                                PropertyStruct(
                                                  id: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.id''',
                                                  ).toString(),
                                                  propertyType: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.property_type''',
                                                  ).toString(),
                                                  description: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.notes''',
                                                  ).toString(),
                                                  beds: getJsonField(
                                                            myPropertiesItem,
                                                            r'''$.bedrooms''',
                                                          ) !=
                                                          null
                                                      ? getJsonField(
                                                          myPropertiesItem,
                                                          r'''$.bedrooms''',
                                                        ).toString()
                                                      : '0',
                                                  baths: getJsonField(
                                                            myPropertiesItem,
                                                            r'''$.bathrooms''',
                                                          ) !=
                                                          null
                                                      ? getJsonField(
                                                          myPropertiesItem,
                                                          r'''$.bathrooms''',
                                                        ).toString()
                                                      : '0',
                                                  sqft: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.square_footage''',
                                                  ).toString(),
                                                  price: getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.list_price''',
                                                  ),
                                                  location: LocationStruct(
                                                    name: getJsonField(
                                                      myPropertiesItem,
                                                      r'''$.address.street_name''',
                                                    ).toString(),
                                                    latlong: functions
                                                        .doubleToLatLong(
                                                            getJsonField(
                                                              myPropertiesItem,
                                                              r'''$.latitude''',
                                                            ),
                                                            getJsonField(
                                                              myPropertiesItem,
                                                              r'''$.longitude''',
                                                            )),
                                                    zipCode: getJsonField(
                                                      myPropertiesItem,
                                                      r'''$.address.zip''',
                                                    ).toString(),
                                                    city: getJsonField(
                                                      myPropertiesItem,
                                                      r'''$.address.city''',
                                                    ).toString(),
                                                  ),
                                                  images: (getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.media''',
                                                    true,
                                                  ) as List?)
                                                      ?.map<String>(
                                                          (e) => e.toString())
                                                      .toList()
                                                      .cast<String>(),
                                                  isActive: !getJsonField(
                                                    myPropertiesItem,
                                                    r'''$.is_sold''',
                                                  ),
                                                ),
                                                ParamType.DataStruct,
                                              ),
                                              'itemIndex': serializeParam(
                                                myPropertiesIndex,
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          if (stackGetPropertiesListResponse.jsonBody != null)
                            Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 16.0, 16.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 15.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  icon: Icon(
                                    Icons.add,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      SellerAddPropertyLocationWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Builder(
                        builder: (context) {
                          final tempo =
                              FFAppState().sellerListOfProperties.toList();
                          if (tempo.isEmpty) {
                            return Center(
                              child: EmptyListingWidget(
                                title: 'Add New Property',
                                description: 'Sell your property now!',
                                icon: Icon(
                                  Icons.add_circle,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 58.0,
                                ),
                                onTap: () async {
                                  context.pushNamed(
                                      SellerAddPropertyLocationWidget
                                          .routeName);
                                },
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: tempo.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, tempoIndex) {
                              final tempoItem = tempo[tempoIndex];
                              return wrapWithModel(
                                model:
                                    _model.sellerPropertyItemModels2.getModel(
                                  tempoIndex.toString(),
                                  tempoIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: SellerPropertyItemWidget(
                                  key: Key(
                                    'Keylb2_${tempoIndex.toString()}',
                                  ),
                                  property: tempoItem,
                                  indexItem: tempoIndex,
                                  isNew: false,
                                  onTap: () async {
                                    context.pushNamed(
                                      SellerPropertyDetailsWidget.routeName,
                                      queryParameters: {
                                        'property': serializeParam(
                                          tempoItem,
                                          ParamType.DataStruct,
                                        ),
                                        'itemIndex': serializeParam(
                                          tempoIndex,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (FFAppState().sellerListOfProperties.isNotEmpty)
                      Align(
                        alignment: AlignmentDirectional(1.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 16.0, 16.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 15.0,
                            borderWidth: 1.0,
                            buttonSize: 50.0,
                            fillColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(
                                SellerAddPropertyLocationWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.sellerBottomNavbarModel,
                updateCallback: () => safeSetState(() {}),
                child: SellerBottomNavbarWidget(
                  activeNav: SellerNavbar.Properties,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
