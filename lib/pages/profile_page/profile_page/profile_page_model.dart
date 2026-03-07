import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for notificationSwitch widget.
  bool? notificationSwitchValue;
  // Stores action output result for [Backend Call - Create Document] action in convertComponent widget.
  SupportRecord? supportCreated;
  // Model for buyer_bottom_navbar component.
  late BuyerBottomNavbarModel buyerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    buyerBottomNavbarModel =
        createModel(context, () => BuyerBottomNavbarModel());
  }

  @override
  void dispose() {
    buyerBottomNavbarModel.dispose();
  }
}
