import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/agent/components/app_logo/app_logo_widget.dart';
import '/agent/components/notification_popup/notification_popup_widget.dart';
import '/app_components/custom_dialog/custom_dialog_widget.dart';
import '/app_components/navbar/buyer_bottom_navbar/buyer_bottom_navbar_widget.dart';
import '/app_components/navbar/seller_bottom_navbar/seller_bottom_navbar_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/search_result_popup_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/search/search_components/filter_location_popup/filter_location_popup_widget.dart';
import '/pages/search/search_components/property_item/property_item_widget.dart';
import '/pages/search/search_filter/search_filter_widget.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class SearchPageModel extends FlutterFlowModel<SearchPageWidget> {
  ///  Local state fields for this page.

  bool isMapView = false;

  List<String> searchResults = [];
  void addToSearchResults(String item) => searchResults.add(item);
  void removeFromSearchResults(String item) => searchResults.remove(item);
  void removeAtIndexFromSearchResults(int index) =>
      searchResults.removeAt(index);
  void insertAtIndexInSearchResults(int index, String item) =>
      searchResults.insert(index, item);
  void updateSearchResultsAtIndex(int index, Function(String) updateFn) =>
      searchResults[index] = updateFn(searchResults[index]);

  List<PropertyDataClassStruct> initialResults = [];
  void addToInitialResults(PropertyDataClassStruct item) =>
      initialResults.add(item);
  void removeFromInitialResults(PropertyDataClassStruct item) =>
      initialResults.remove(item);
  void removeAtIndexFromInitialResults(int index) =>
      initialResults.removeAt(index);
  void insertAtIndexInInitialResults(int index, PropertyDataClassStruct item) =>
      initialResults.insert(index, item);
  void updateInitialResultsAtIndex(
          int index, Function(PropertyDataClassStruct) updateFn) =>
      initialResults[index] = updateFn(initialResults[index]);

  List<PropertyDataClassStruct> filteredResults = [];
  void addToFilteredResults(PropertyDataClassStruct item) =>
      filteredResults.add(item);
  void removeFromFilteredResults(PropertyDataClassStruct item) =>
      filteredResults.remove(item);
  void removeAtIndexFromFilteredResults(int index) =>
      filteredResults.removeAt(index);
  void insertAtIndexInFilteredResults(
          int index, PropertyDataClassStruct item) =>
      filteredResults.insert(index, item);
  void updateFilteredResultsAtIndex(
          int index, Function(PropertyDataClassStruct) updateFn) =>
      filteredResults[index] = updateFn(filteredResults[index]);

  PropertyDataClassStruct? selectedProperty;
  void updateSelectedPropertyStruct(
      Function(PropertyDataClassStruct) updateFn) {
    updateFn(selectedProperty ??= PropertyDataClassStruct());
  }

  bool hasNetworkFailed = false;

  SearchFilterDataStruct? filterFields;
  void updateFilterFieldsStruct(Function(SearchFilterDataStruct) updateFn) {
    updateFn(filterFields ??= SearchFilterDataStruct());
  }

  int? selectedPropertyZpid;

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getPlaceName)] action in search_page widget.
  ApiCallResponse? apiPlaceNameResults;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in search_page widget.
  ApiCallResponse? initialProperties2;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in search_page widget.
  ApiCallResponse? initialProperties3;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in search_page widget.
  ApiCallResponse? initialProperties1;
  // Model for app_logo component.
  late AppLogoModel appLogoModel;
  // State field(s) for search_property widget.
  FocusNode? searchPropertyFocusNode;
  TextEditingController? searchPropertyTextController;
  String? Function(BuildContext, String?)?
      searchPropertyTextControllerValidator;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in Container widget.
  ApiCallResponse? selectionPropertiesCopy;
  // Stores action output result for [Backend Call - API (getPropertiesByZipId)] action in Container widget.
  ApiCallResponse? searchPropertyByZipIdCopy;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in Container widget.
  ApiCallResponse? citySearchProperties;
  // Stores action output result for [Backend Call - API (getAllProperties)] action in Container widget.
  ApiCallResponse? citySearchProperties1;
  // Stores action output result for [Backend Call - API (getPropertyzpid)] action in Container widget.
  ApiCallResponse? locationZpid;
  // State field(s) for sortChoiceChips widget.
  FormFieldController<List<String>>? sortChoiceChipsValueController;
  String? get sortChoiceChipsValue =>
      sortChoiceChipsValueController?.value?.firstOrNull;
  set sortChoiceChipsValue(String? val) =>
      sortChoiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - sortProperties] action in sortChoiceChips widget.
  List<PropertyDataClassStruct>? sortedProperties;
  // State field(s) for saleChoiceChips widget.
  FormFieldController<List<String>>? saleChoiceChipsValueController;
  String? get saleChoiceChipsValue =>
      saleChoiceChipsValueController?.value?.firstOrNull;
  set saleChoiceChipsValue(String? val) =>
      saleChoiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - API (getAllProperties)] action in saleChoiceChips widget.
  ApiCallResponse? saleProperties;
  // Stores action output result for [Backend Call - API (getSavedSearches)] action in CustomMarkersMap widget.
  ApiCallResponse? getSavedSearches;
  // Stores action output result for [Custom Action - filteredSavedProperties] action in CustomMarkersMap widget.
  List<PropertyDataClassStruct>? filteredSavedProperties1;
  // Stores action output result for [Backend Call - API (insertSavedSearch)] action in CustomMarkersMap widget.
  ApiCallResponse? insertSavedSearch;
  // Stores action output result for [Backend Call - API (insertSavedSearch)] action in CustomMarkersMap widget.
  ApiCallResponse? insertSavedSearch1;
  // Models for property_item dynamic component.
  late FlutterFlowDynamicModels<PropertyItemModel> propertyItemModels;
  // Stores action output result for [Backend Call - API (getSavedSearches)] action in property_item widget.
  ApiCallResponse? getSavedSearches1;
  // Stores action output result for [Custom Action - filteredSavedProperties] action in property_item widget.
  List<PropertyDataClassStruct>? filteredSavedProperties;
  // Stores action output result for [Backend Call - API (insertSavedSearch)] action in property_item widget.
  ApiCallResponse? insertSavedSearch2;
  // Stores action output result for [Backend Call - API (insertSavedSearch)] action in property_item widget.
  ApiCallResponse? insertSavedSearch3;
  // Model for empty_listing component.
  late EmptyListingModel emptyListingModel;
  // Model for buyer_bottom_navbar component.
  late BuyerBottomNavbarModel buyerBottomNavbarModel;
  // Model for agent_bottom_navbar component.
  late AgentBottomNavbarModel agentBottomNavbarModel;
  // Model for seller_bottom_navbar component.
  late SellerBottomNavbarModel sellerBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    appLogoModel = createModel(context, () => AppLogoModel());
    propertyItemModels = FlutterFlowDynamicModels(() => PropertyItemModel());
    emptyListingModel = createModel(context, () => EmptyListingModel());
    buyerBottomNavbarModel =
        createModel(context, () => BuyerBottomNavbarModel());
    agentBottomNavbarModel =
        createModel(context, () => AgentBottomNavbarModel());
    sellerBottomNavbarModel =
        createModel(context, () => SellerBottomNavbarModel());
  }

  @override
  void dispose() {
    appLogoModel.dispose();
    searchPropertyFocusNode?.dispose();
    searchPropertyTextController?.dispose();

    propertyItemModels.dispose();
    emptyListingModel.dispose();
    buyerBottomNavbarModel.dispose();
    agentBottomNavbarModel.dispose();
    sellerBottomNavbarModel.dispose();
  }
}
