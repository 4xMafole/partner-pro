import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_result_popup_widget.dart' show SearchResultPopupWidget;
import 'package:flutter/material.dart';

class SearchResultPopupModel extends FlutterFlowModel<SearchResultPopupWidget> {
  ///  Local state fields for this component.

  List<String> searchResults = [];
  void addToSearchResults(String item) => searchResults.add(item);
  void removeFromSearchResults(String item) => searchResults.remove(item);
  void removeAtIndexFromSearchResults(int index) =>
      searchResults.removeAt(index);
  void insertAtIndexInSearchResults(int index, String item) =>
      searchResults.insert(index, item);
  void updateSearchResultsAtIndex(int index, Function(String) updateFn) =>
      searchResults[index] = updateFn(searchResults[index]);

  List<dynamic> predictions = [];
  void addToPredictions(dynamic item) => predictions.add(item);
  void removeFromPredictions(dynamic item) => predictions.remove(item);
  void removeAtIndexFromPredictions(int index) => predictions.removeAt(index);
  void insertAtIndexInPredictions(int index, dynamic item) =>
      predictions.insert(index, item);
  void updatePredictionsAtIndex(int index, Function(dynamic) updateFn) =>
      predictions[index] = updateFn(predictions[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for search_property widget.
  FocusNode? searchPropertyFocusNode;
  TextEditingController? searchPropertyTextController;
  String? Function(BuildContext, String?)?
      searchPropertyTextControllerValidator;
  // Stores action output result for [Backend Call - API (googlePlacePicker)] action in search_property widget.
  ApiCallResponse? apiResult3l9;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchPropertyFocusNode?.dispose();
    searchPropertyTextController?.dispose();
  }
}
