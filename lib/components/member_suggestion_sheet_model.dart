import '/agent/components/contact_suggest_item/contact_suggest_item_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'member_suggestion_sheet_widget.dart' show MemberSuggestionSheetWidget;
import 'package:flutter/material.dart';

class MemberSuggestionSheetModel
    extends FlutterFlowModel<MemberSuggestionSheetWidget> {
  ///  Local state fields for this component.

  List<MemberSuggestionStruct> suggestions = [];
  void addToSuggestions(MemberSuggestionStruct item) => suggestions.add(item);
  void removeFromSuggestions(MemberSuggestionStruct item) =>
      suggestions.remove(item);
  void removeAtIndexFromSuggestions(int index) => suggestions.removeAt(index);
  void insertAtIndexInSuggestions(int index, MemberSuggestionStruct item) =>
      suggestions.insert(index, item);
  void updateSuggestionsAtIndex(
          int index, Function(MemberSuggestionStruct) updateFn) =>
      suggestions[index] = updateFn(suggestions[index]);

  List<MemberStruct> memberList = [];
  void addToMemberList(MemberStruct item) => memberList.add(item);
  void removeFromMemberList(MemberStruct item) => memberList.remove(item);
  void removeAtIndexFromMemberList(int index) => memberList.removeAt(index);
  void insertAtIndexInMemberList(int index, MemberStruct item) =>
      memberList.insert(index, item);
  void updateMemberListAtIndex(int index, Function(MemberStruct) updateFn) =>
      memberList[index] = updateFn(memberList[index]);

  bool isLoading = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getAllClientsByAgentId)] action in member_suggestion_sheet widget.
  ApiCallResponse? allClientsByAgentID;
  // Stores action output result for [Firestore Query - Query a collection] action in member_suggestion_sheet widget.
  UsersRecord? buyerDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in member_suggestion_sheet widget.
  SuggestionsRecord? activeSuggestionDoc;
  // Models for contact_suggest_item dynamic component.
  late FlutterFlowDynamicModels<ContactSuggestItemModel>
      contactSuggestItemModels;

  @override
  void initState(BuildContext context) {
    contactSuggestItemModels =
        FlutterFlowDynamicModels(() => ContactSuggestItemModel());
  }

  @override
  void dispose() {
    contactSuggestItemModels.dispose();
  }
}
