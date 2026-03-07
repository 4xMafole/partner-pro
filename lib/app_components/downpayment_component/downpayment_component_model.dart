import '/components/conventional_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'downpayment_component_widget.dart' show DownpaymentComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DownpaymentComponentModel
    extends FlutterFlowModel<DownpaymentComponentWidget> {
  ///  Local state fields for this component.

  List<String> types = [
    'VA 0%',
    'FHA 3.5%',
    'Conventional 5-20%',
    'Cash',
    'Other'
  ];
  void addToTypes(String item) => types.add(item);
  void removeFromTypes(String item) => types.remove(item);
  void removeAtIndexFromTypes(int index) => types.removeAt(index);
  void insertAtIndexInTypes(int index, String item) =>
      types.insert(index, item);
  void updateTypesAtIndex(int index, Function(String) updateFn) =>
      types[index] = updateFn(types[index]);

  String? selectedType;

  ///  State fields for stateful widgets in this component.

  // Models for conventional_dropdown dynamic component.
  late FlutterFlowDynamicModels<ConventionalDropdownModel>
      conventionalDropdownModels;

  @override
  void initState(BuildContext context) {
    conventionalDropdownModels =
        FlutterFlowDynamicModels(() => ConventionalDropdownModel());
  }

  @override
  void dispose() {
    conventionalDropdownModels.dispose();
  }
}
