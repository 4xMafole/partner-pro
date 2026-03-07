import '/app_components/navbar/navbar_item/navbar_item_widget.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'agent_bottom_navbar_model.dart';
export 'agent_bottom_navbar_model.dart';

class AgentBottomNavbarWidget extends StatefulWidget {
  const AgentBottomNavbarWidget({
    super.key,
    required this.activeNav,
  });

  final AgentNavbar? activeNav;

  @override
  State<AgentBottomNavbarWidget> createState() =>
      _AgentBottomNavbarWidgetState();
}

class _AgentBottomNavbarWidgetState extends State<AgentBottomNavbarWidget> {
  late AgentBottomNavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentBottomNavbarModel());
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
                Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.navbarItemModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarItemWidget(
                      label: 'Dashboard',
                      iconNav: Icon(
                        Icons.dashboard_outlined,
                        color: widget!.activeNav == AgentNavbar.Dashboard
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      isActive: widget!.activeNav == AgentNavbar.Dashboard,
                      onTap: () async {
                        context.goNamed(
                          AgentDashboardWidget.routeName,
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
                Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.navbarItemModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarItemWidget(
                      label: 'Search',
                      iconNav: Icon(
                        Icons.search_sharp,
                        color: widget!.activeNav == AgentNavbar.Search
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      isActive: widget!.activeNav == AgentNavbar.Search,
                      onTap: () async {
                        context.goNamed(
                          SearchPageWidget.routeName,
                          queryParameters: {
                            'userType': serializeParam(
                              UserType.Agent,
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
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.navbarItemModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarItemWidget(
                      label: 'Offers',
                      iconNav: Icon(
                        Icons.home_outlined,
                        color: widget!.activeNav == AgentNavbar.Offers
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      isActive: widget!.activeNav == AgentNavbar.Offers,
                      onTap: () async {
                        context.goNamed(
                          AgentOffersWidget.routeName,
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
                Container(
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.navbarItemModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: NavbarItemWidget(
                      label: 'Clients',
                      iconNav: Icon(
                        Icons.people_outlined,
                        color: widget!.activeNav == AgentNavbar.Clients
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      isActive: widget!.activeNav == AgentNavbar.Clients,
                      onTap: () async {
                        context.goNamed(
                          ClientListPageWidget.routeName,
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
          ],
        ),
      ),
    );
  }
}
