import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'lender_popup_widget.dart' show LenderPopupWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LenderPopupModel extends FlutterFlowModel<LenderPopupWidget> {
  ///  Local state fields for this component.

  bool hasLender = false;

  bool hasAcceptLegal = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for lenderCheckbox widget.
  bool? lenderCheckboxValue;
  // State field(s) for legalCheckbox widget.
  bool? legalCheckboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
