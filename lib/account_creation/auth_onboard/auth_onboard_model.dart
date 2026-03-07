import '/agent/components/app_logo/app_logo_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'auth_onboard_widget.dart' show AuthOnboardWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthOnboardModel extends FlutterFlowModel<AuthOnboardWidget> {
  ///  Local state fields for this page.

  bool isBuyer = false;

  ///  State fields for stateful widgets in this page.

  // Model for app_logo component.
  late AppLogoModel appLogoModel;
  // State field(s) for starterPageView widget.
  PageController? starterPageViewController;

  int get starterPageViewCurrentIndex => starterPageViewController != null &&
          starterPageViewController!.hasClients &&
          starterPageViewController!.page != null
      ? starterPageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
  }

  @override
  void dispose() {
    appLogoModel.dispose();
  }
}
