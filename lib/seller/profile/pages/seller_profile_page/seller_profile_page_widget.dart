import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/profile_list_item_widget.dart';
import '/components/title_label_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'seller_profile_page_model.dart';
export 'seller_profile_page_model.dart';

class SellerProfilePageWidget extends StatefulWidget {
  const SellerProfilePageWidget({super.key});

  static String routeName = 'seller_profile_page';
  static String routePath = '/sellerProfilePage';

  @override
  State<SellerProfilePageWidget> createState() =>
      _SellerProfilePageWidgetState();
}

class _SellerProfilePageWidgetState extends State<SellerProfilePageWidget> {
  late SellerProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerProfilePageModel());
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                wrapWithModel(
                                  model: _model.titleLabelModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TitleLabelWidget(
                                    title: 'Profile',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (currentUserPhoto != '') {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                              child: Image.network(
                                                currentUserPhoto,
                                                width: 64.0,
                                                height: 64.0,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else {
                                            return ClipOval(
                                              child: Container(
                                                width: 64.0,
                                                height: 64.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.person_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 60.0,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 4.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                currentUserDisplayName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                'Member since ${dateTimeFormat(
                                                  "yMMMd",
                                                  currentUserDocument
                                                      ?.createdTime,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                )}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      wrapWithModel(
                                        model: _model.profileListItemModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileListItemWidget(
                                          label: 'Inspections',
                                          onTap: () async {
                                            context.pushNamed(
                                                SellerInspectionPageWidget
                                                    .routeName);
                                          },
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.profileListItemModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileListItemWidget(
                                          label: 'Appointments',
                                          onTap: () async {
                                            context.pushNamed(
                                                SellerAppointmentPageWidget
                                                    .routeName);
                                          },
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.profileListItemModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileListItemWidget(
                                          label: 'Searches',
                                          onTap: () async {
                                            context.pushNamed(
                                              SellerTopSearchesPropertiesWidget
                                                  .routeName,
                                              queryParameters: {
                                                'pageType': serializeParam(
                                                  PropertyPage.Wishlist,
                                                  ParamType.Enum,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.profileListItemModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileListItemWidget(
                                          label: 'Logout',
                                          onTap: () async {
                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            await authManager.signOut();
                                            GoRouter.of(context)
                                                .clearRedirectLocation();

                                            context.goNamedAuth(
                                                AuthOnboardWidget.routeName,
                                                context.mounted);
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 10.0)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.sellerBottomNavbarModel,
                updateCallback: () => safeSetState(() {}),
                child: SellerBottomNavbarWidget(
                  activeNav: SellerNavbar.Profile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
