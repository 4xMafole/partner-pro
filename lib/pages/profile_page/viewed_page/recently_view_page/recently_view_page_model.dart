import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'recently_view_page_widget.dart' show RecentlyViewPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecentlyViewPageModel extends FlutterFlowModel<RecentlyViewPageWidget> {
  ///  Local state fields for this page.

  List<PropertyDataClassStruct> properties = [];
  void addToProperties(PropertyDataClassStruct item) => properties.add(item);
  void removeFromProperties(PropertyDataClassStruct item) =>
      properties.remove(item);
  void removeAtIndexFromProperties(int index) => properties.removeAt(index);
  void insertAtIndexInProperties(int index, PropertyDataClassStruct item) =>
      properties.insert(index, item);
  void updatePropertiesAtIndex(
          int index, Function(PropertyDataClassStruct) updateFn) =>
      properties[index] = updateFn(properties[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getSavedSearches)] action in recently_view_page widget.
  ApiCallResponse? getSavedSearches;
  // Stores action output result for [Custom Action - filteredSavedProperties] action in recently_view_page widget.
  List<PropertyDataClassStruct>? filteredSavedProperties;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels;

  @override
  void initState(BuildContext context) {
    propertyItemModels = FlutterFlowDynamicModels(() => PropertyItemModel());
  }

  @override
  void dispose() {
    propertyItemModels.dispose();
  }
}
