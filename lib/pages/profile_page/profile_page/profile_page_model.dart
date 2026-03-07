import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/profile_page/support_sheet/support_sheet_widget.dart';
import '/seller/property/congrats_sheet/congrats_sheet_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
