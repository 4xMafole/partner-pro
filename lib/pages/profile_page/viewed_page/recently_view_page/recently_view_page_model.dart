import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/index.dart';
import 'recently_view_page_widget.dart' show RecentlyViewPageWidget;
import 'package:flutter/material.dart';

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
