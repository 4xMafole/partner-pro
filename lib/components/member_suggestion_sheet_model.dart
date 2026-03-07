import '/agent/components/contact_suggest_item/contact_suggest_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'member_suggestion_sheet_widget.dart' show MemberSuggestionSheetWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

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
