import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/range_filter_item_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'search_filter_widget.dart' show SearchFilterWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchFilterModel extends FlutterFlowModel<SearchFilterWidget> {
  ///  Local state fields for this component.

  bool isEmpty = false;

  SearchFilterDataStruct? newFilterData;
  void updateNewFilterDataStruct(Function(SearchFilterDataStruct) updateFn) {
    updateFn(newFilterData ??= SearchFilterDataStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Model for price_range_item.
  late RangeFilterItemModel priceRangeItemModel;
  // Model for beds_range_item.
  late RangeFilterItemModel bedsRangeItemModel;
  // Model for bath_range_item.
  late RangeFilterItemModel bathRangeItemModel;
  // Model for sqft_range_item.
  late RangeFilterItemModel sqftRangeItemModel;
  // Model for year_range_item.
  late RangeFilterItemModel yearRangeItemModel;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in Button widget.
  ApiCallResponse? getHomeType;
  // Stores action output result for [Custom Action - filterProperties] action in Button widget.
  List<PropertyDataClassStruct>? filteredItems;
  // Stores action output result for [Custom Action - filterProperties] action in Button widget.
  List<PropertyDataClassStruct>? defaultFilteredItems;

  @override
  void initState(BuildContext context) {
    priceRangeItemModel = createModel(context, () => RangeFilterItemModel());
    bedsRangeItemModel = createModel(context, () => RangeFilterItemModel());
    bathRangeItemModel = createModel(context, () => RangeFilterItemModel());
    sqftRangeItemModel = createModel(context, () => RangeFilterItemModel());
    yearRangeItemModel = createModel(context, () => RangeFilterItemModel());
  }

  @override
  void dispose() {
    priceRangeItemModel.dispose();
    bedsRangeItemModel.dispose();
    bathRangeItemModel.dispose();
    sqftRangeItemModel.dispose();
    yearRangeItemModel.dispose();
  }
}
