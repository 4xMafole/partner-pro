import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/seller/property/components/seller_property_item/seller_property_item_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seller_top_searches_properties_model.dart';
export 'seller_top_searches_properties_model.dart';

class SellerTopSearchesPropertiesWidget extends StatefulWidget {
  const SellerTopSearchesPropertiesWidget({
    super.key,
    required this.pageType,
  });

  final PropertyPage? pageType;

  static String routeName = 'seller_top_searches_properties';
  static String routePath = '/sellerTopSearchesProperties';

  @override
  State<SellerTopSearchesPropertiesWidget> createState() =>
      _SellerTopSearchesPropertiesWidgetState();
}

class _SellerTopSearchesPropertiesWidgetState
    extends State<SellerTopSearchesPropertiesWidget> {
  late SellerTopSearchesPropertiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerTopSearchesPropertiesModel());
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 16.0),
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
                        Builder(
                          builder: (context) {
                            if (widget.pageType == PropertyPage.Top) {
                              return Text(
                                'Top Properties',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineMediumIsCustom,
                                    ),
                              );
                            } else {
                              return Text(
                                'Searched Properties',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineMediumIsCustom,
                                    ),
                              );
                            }
                          },
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (widget.pageType == PropertyPage.Top) {
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Builder(
                          builder: (context) {
                            final resultTemp =
                                FFAppState().sellerTopProperties.toList();
                            if (resultTemp.isEmpty) {
                              return Center(
                                child: EmptyListingWidget(
                                  title: 'Empty List',
                                  description: 'No properties qualify',
                                  icon: Icon(
                                    Icons.villa_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 58.0,
                                  ),
                                  onTap: () async {},
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: resultTemp.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.0),
                              itemBuilder: (context, resultTempIndex) {
                                final resultTempItem =
                                    resultTemp[resultTempIndex];
                                return wrapWithModel(
                                  model:
                                      _model.sellerPropertyItemModels.getModel(
                                    resultTempIndex.toString(),
                                    resultTempIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: SellerPropertyItemWidget(
                                    key: Key(
                                      'Key49h_${resultTempIndex.toString()}',
                                    ),
                                    property: resultTempItem,
                                    indexItem: resultTempIndex,
                                    onTap: () async {
                                      context.pushNamed(
                                        SellerPropertyDetailsWidget.routeName,
                                        queryParameters: {
                                          'property': serializeParam(
                                            resultTempItem,
                                            ParamType.DataStruct,
                                          ),
                                          'itemIndex': serializeParam(
                                            resultTempIndex,
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
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Builder(
                          builder: (context) {
                            final resultWishlist = FFAppState()
                                .sellerWishlistedProperties
                                .toList();
                            if (resultWishlist.isEmpty) {
                              return Center(
                                child: EmptyListingWidget(
                                  title: 'Empty List',
                                  description: 'No properties qualify',
                                  icon: Icon(
                                    Icons.villa_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 58.0,
                                  ),
                                  onTap: () async {},
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: resultWishlist.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.0),
                              itemBuilder: (context, resultWishlistIndex) {
                                final resultWishlistItem =
                                    resultWishlist[resultWishlistIndex];
                                return wrapWithModel(
                                  model: _model.propertyItemModels.getModel(
                                    resultWishlistIndex.toString(),
                                    resultWishlistIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: PropertyItemWidget(
                                    key: Key(
                                      'Keyhyn_${resultWishlistIndex.toString()}',
                                    ),
                                    property: PropertyDataClassStruct(),
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
    );
  }
}
