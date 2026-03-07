import '/agent/components/contact_item/contact_item_widget.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'search_list_widget.dart' show SearchListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchListModel extends FlutterFlowModel<SearchListWidget> {
  ///  Local state fields for this page.

  List<MemberStruct> searchResults = [];
  void addToSearchResults(MemberStruct item) => searchResults.add(item);
  void removeFromSearchResults(MemberStruct item) => searchResults.remove(item);
  void removeAtIndexFromSearchResults(int index) =>
      searchResults.removeAt(index);
  void insertAtIndexInSearchResults(int index, MemberStruct item) =>
      searchResults.insert(index, item);
  void updateSearchResultsAtIndex(int index, Function(MemberStruct) updateFn) =>
      searchResults[index] = updateFn(searchResults[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for contact_item dynamic component.
  late FlutterFlowDynamicModels<ContactItemModel> contactItemModels;

  @override
  void initState(BuildContext context) {
    contactItemModels = FlutterFlowDynamicModels(() => ContactItemModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    contactItemModels.dispose();
  }
}
