import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'seller_bottom_navbar_model.dart';
export 'seller_bottom_navbar_model.dart';

class SellerBottomNavbarWidget extends StatefulWidget {
  const SellerBottomNavbarWidget({
    super.key,
    required this.activeNav,
  });

  final SellerNavbar? activeNav;

  @override
  State<SellerBottomNavbarWidget> createState() =>
      _SellerBottomNavbarWidgetState();
}

class _SellerBottomNavbarWidgetState extends State<SellerBottomNavbarWidget> {
  late SellerBottomNavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.activeNav != SellerNavbar.Dashboard)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.dashNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Dashboard',
                            iconNav: Icon(
                              Icons.dashboard_sharp,
                              color: Color(0x8A000000),
                              size: 24.0,
                            ),
                            isActive: false,
                            onTap: () async {
                              context.goNamed(
                                SellerDashboardPageWidget.routeName,
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
                    if (widget.activeNav == SellerNavbar.Dashboard)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.activeDashNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Dashboard',
                            iconNav: Icon(
                              Icons.dashboard_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            isActive: true,
                            onTap: () async {},
                          ),
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.activeNav != SellerNavbar.Search) {
                          return Container(
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.navbarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: NavbarItemWidget(
                                label: 'Search',
                                iconNav: Icon(
                                  Icons.search,
                                  color: Color(0x8A000000),
                                  size: 24.0,
                                ),
                                isActive: false,
                                onTap: () async {
                                  context.goNamed(
                                    SearchPageWidget.routeName,
                                    queryParameters: {
                                      'userType': serializeParam(
                                        UserType.Seller,
                                        ParamType.Enum,
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
                                },
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.activeNavbarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: NavbarItemWidget(
                                label: 'Search',
                                iconNav: Icon(
                                  Icons.search,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                isActive: true,
                                onTap: () async {},
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.activeNav != SellerNavbar.Properties)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.propertyNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'My Homes',
                            iconNav: Icon(
                              Icons.home_outlined,
                              color: Color(0x8A000000),
                              size: 24.0,
                            ),
                            isActive: false,
                            onTap: () async {
                              context.goNamed(
                                SellerPropertyListingPageWidget.routeName,
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
                    if (widget.activeNav == SellerNavbar.Properties)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.activePropertyNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'My Homes',
                            iconNav: Icon(
                              Icons.home_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            isActive: true,
                            onTap: () async {},
                          ),
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.activeNav != SellerNavbar.Offers)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.offerNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Offers',
                            iconNav: Icon(
                              Icons.local_offer,
                              color: Color(0x8A000000),
                              size: 24.0,
                            ),
                            isActive: false,
                            onTap: () async {
                              context.goNamed(
                                SellerOffersPageWidget.routeName,
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
                    if (widget.activeNav == SellerNavbar.Offers)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.activeOfferNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Offers',
                            iconNav: Icon(
                              Icons.local_offer,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            isActive: true,
                            onTap: () async {},
                          ),
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (widget.activeNav != SellerNavbar.Profile)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.profileNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Profile',
                            iconNav: Icon(
                              Icons.person,
                              color: Color(0x8A000000),
                              size: 24.0,
                            ),
                            isActive: false,
                            onTap: () async {
                              context.goNamed(
                                SellerProfilePageWidget.routeName,
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
                    if (widget.activeNav == SellerNavbar.Profile)
                      Container(
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.activeProfileNavbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarItemWidget(
                            label: 'Profile',
                            iconNav: Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            isActive: true,
                            onTap: () async {},
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
