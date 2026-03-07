import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/property/property_item_option/property_item_option_widget.dart';
import '/seller/shared_components/warning_popup_card/warning_popup_card_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'seller_property_item_widget.dart' show SellerPropertyItemWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerPropertyItemModel
    extends FlutterFlowModel<SellerPropertyItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (deleteSellerProperty)] action in Container widget.
  ApiCallResponse? apiResult8;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
