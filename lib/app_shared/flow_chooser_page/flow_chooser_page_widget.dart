import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'flow_chooser_page_model.dart';
export 'flow_chooser_page_model.dart';

class FlowChooserPageWidget extends StatefulWidget {
  const FlowChooserPageWidget({super.key});

  static String routeName = 'flow_chooser_page';
  static String routePath = '/flowChooserPage';

  @override
  State<FlowChooserPageWidget> createState() => _FlowChooserPageWidgetState();
}

class _FlowChooserPageWidgetState extends State<FlowChooserPageWidget>
    with TickerProviderStateMixin {
  late FlowChooserPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FlowChooserPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await requestPermission(notificationsPermission);
      await Future.delayed(
        Duration(
          milliseconds: 500,
        ),
      );
      _model.flowUser =
          await UsersRecord.getDocumentOnce(currentUserReference!);
      if (_model.flowUser?.role == UserType.Buyer) {
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
              transitionType: PageTransitionType.fade,
            ),
          },
        );
      } else {
        context.goNamed(AgentDashboardWidget.routeName);
      }
    });

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    percent: 0.8,
                    radius: 45.0,
                    lineWidth: 5.0,
                    animation: true,
                    animateFromLastPercent: true,
                    progressColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                  ).animateOnPageLoad(
                      animationsMap['progressBarOnPageLoadAnimation']!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
