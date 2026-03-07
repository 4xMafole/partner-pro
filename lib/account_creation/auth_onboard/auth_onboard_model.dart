import '/agent/components/app_logo/app_logo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'auth_onboard_widget.dart' show AuthOnboardWidget;
import 'package:flutter/material.dart';

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
