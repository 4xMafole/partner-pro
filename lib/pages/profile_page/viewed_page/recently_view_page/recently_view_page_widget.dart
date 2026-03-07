import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'recently_view_page_model.dart';
export 'recently_view_page_model.dart';

class RecentlyViewPageWidget extends StatefulWidget {
  const RecentlyViewPageWidget({super.key});

  static String routeName = 'recently_view_page';
  static String routePath = '/recentlyViewPage';

  @override
  State<RecentlyViewPageWidget> createState() => _RecentlyViewPageWidgetState();
}

class _RecentlyViewPageWidgetState extends State<RecentlyViewPageWidget> {
  late RecentlyViewPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecentlyViewPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.getSavedSearches =
          await IwoUsersSavedSearchApiGroup.getSavedSearchesCall.call(
        userId: currentUserUid,
      );

      if ((_model.getSavedSearches?.succeeded ?? true)) {
        _model.filteredSavedProperties = await actions.filteredSavedProperties(
          IwoUsersSavedSearchApiGroup.getSavedSearchesCall
              .savedProperties(
                (_model.getSavedSearches?.jsonBody ?? ''),
              )!
              .toList(),
        );
        _model.properties = _model.filteredSavedProperties!
            .toList()
            .cast<PropertyDataClassStruct>();
        safeSetState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to getSavedSearches',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
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
                          'Recently Viewed',
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
                    Container(
                      decoration: BoxDecoration(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Builder(
                    builder: (context) {
                      final items = functions
                          .reverseList(_model.properties.toList())
                          .toList();
                      if (items.isEmpty) {
                        return EmptyListingWidget(
                          title: 'Empty Listing',
                          description: 'You haven\'t viewed any property',
                          onTap: () async {},
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        separatorBuilder: (_, __) => SizedBox(height: 20.0),
                        itemBuilder: (context, itemsIndex) {
                          final itemsItem = items[itemsIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  PropertyDetailsPageWidget.routeName,
                                  queryParameters: {
                                    'propertyId': serializeParam(
                                      itemsItem.id,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: wrapWithModel(
                                model: _model.propertyItemModels.getModel(
                                  itemsItem.id,
                                  itemsIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: PropertyItemWidget(
                                  key: Key(
                                    'Keyto6_${itemsItem.id}',
                                  ),
                                  property: itemsItem,
                                ),
                              ),
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
      ),
    );
  }
}
