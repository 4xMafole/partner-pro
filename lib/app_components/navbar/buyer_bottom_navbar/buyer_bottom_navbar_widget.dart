import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'buyer_bottom_navbar_model.dart';
export 'buyer_bottom_navbar_model.dart';

class BuyerBottomNavbarWidget extends StatefulWidget {
  const BuyerBottomNavbarWidget({
    super.key,
    required this.activeNav,
  });

  final BuyerNavbar? activeNav;

  @override
  State<BuyerBottomNavbarWidget> createState() =>
      _BuyerBottomNavbarWidgetState();
}

class _BuyerBottomNavbarWidgetState extends State<BuyerBottomNavbarWidget> {
  late BuyerBottomNavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BuyerBottomNavbarModel());
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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.activeNav != BuyerNavbar.Search) {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.navbarModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Search',
                                  iconNav: Icon(
                                    Icons.search_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  isActive: false,
                                  onTap: () async {
                                    context.goNamed(
                                      SearchPageWidget.routeName,
                                      queryParameters: {
                                        'userType': serializeParam(
                                          UserType.Buyer,
                                          ParamType.Enum,
                                        ),
                                      }.withoutNulls,
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
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.activeNavbarModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Search',
                                  iconNav: Icon(
                                    Icons.search_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.activeNav != BuyerNavbar.Tools) {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.navbarModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Tools',
                                  iconNav: FaIcon(
                                    FontAwesomeIcons.tools,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  isActive: false,
                                  onTap: () async {
                                    context.goNamed(
                                      ToolsPageWidget.routeName,
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
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.activeNavbarModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Tools',
                                  iconNav: FaIcon(
                                    FontAwesomeIcons.tools,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.activeNav != BuyerNavbar.MyHomes) {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.navbarModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'My Homes',
                                  iconNav: Icon(
                                    Icons.home_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  isActive: false,
                                  onTap: () async {
                                    context.goNamed(
                                      MyHomesPageWidget.routeName,
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
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.activeNavbarModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'My Homes',
                                  iconNav: Icon(
                                    Icons.home_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.activeNav != BuyerNavbar.Profile) {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.navbarModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Profile',
                                  iconNav: Icon(
                                    Icons.person,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  isActive: false,
                                  onTap: () async {
                                    context.goNamed(
                                      ProfilePageWidget.routeName,
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
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(),
                              child: wrapWithModel(
                                model: _model.activeNavbarModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarItemWidget(
                                  label: 'Profile',
                                  iconNav: Icon(
                                    Icons.person,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
