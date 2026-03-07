import '/agent/components/contact_item/contact_item_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'buyer_invite_page_widget.dart' show BuyerInvitePageWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BuyerInvitePageModel extends FlutterFlowModel<BuyerInvitePageWidget> {
  ///  Local state fields for this page.

  EmailProviderStruct? emailProvider;
  void updateEmailProviderStruct(Function(EmailProviderStruct) updateFn) {
    updateFn(emailProvider ??= EmailProviderStruct());
  }

  List<MemberStruct> members = [];
  void addToMembers(MemberStruct item) => members.add(item);
  void removeFromMembers(MemberStruct item) => members.remove(item);
  void removeAtIndexFromMembers(int index) => members.removeAt(index);
  void insertAtIndexInMembers(int index, MemberStruct item) =>
      members.insert(index, item);
  void updateMembersAtIndex(int index, Function(MemberStruct) updateFn) =>
      members[index] = updateFn(members[index]);

  SMSProviderStruct? smsProvider;
  void updateSmsProviderStruct(Function(SMSProviderStruct) updateFn) {
    updateFn(smsProvider ??= SMSProviderStruct());
  }

  List<MemberStruct> selectedMembers = [];
  void addToSelectedMembers(MemberStruct item) => selectedMembers.add(item);
  void removeFromSelectedMembers(MemberStruct item) =>
      selectedMembers.remove(item);
  void removeAtIndexFromSelectedMembers(int index) =>
      selectedMembers.removeAt(index);
  void insertAtIndexInSelectedMembers(int index, MemberStruct item) =>
      selectedMembers.insert(index, item);
  void updateSelectedMembersAtIndex(
          int index, Function(MemberStruct) updateFn) =>
      selectedMembers[index] = updateFn(selectedMembers[index]);

  List<MemberStruct> newInvitees = [];
  void addToNewInvitees(MemberStruct item) => newInvitees.add(item);
  void removeFromNewInvitees(MemberStruct item) => newInvitees.remove(item);
  void removeAtIndexFromNewInvitees(int index) => newInvitees.removeAt(index);
  void insertAtIndexInNewInvitees(int index, MemberStruct item) =>
      newInvitees.insert(index, item);
  void updateNewInviteesAtIndex(int index, Function(MemberStruct) updateFn) =>
      newInvitees[index] = updateFn(newInvitees[index]);

  List<dynamic> emptyList = [];
  void addToEmptyList(dynamic item) => emptyList.add(item);
  void removeFromEmptyList(dynamic item) => emptyList.remove(item);
  void removeAtIndexFromEmptyList(int index) => emptyList.removeAt(index);
  void insertAtIndexInEmptyList(int index, dynamic item) =>
      emptyList.insert(index, item);
  void updateEmptyListAtIndex(int index, Function(dynamic) updateFn) =>
      emptyList[index] = updateFn(emptyList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - API (getCrmByAgent)] action in ChoiceChips widget.
  ApiCallResponse? apiResultmtw2;
  // Stores action output result for [Firestore Query - Query a collection] action in ChoiceChips widget.
  List<InvitationsRecord>? invitationsDocs2;
  // Stores action output result for [Custom Action - mergeContactsWithInvitations] action in ChoiceChips widget.
  List<MemberStruct>? initContacts2;
  // Stores action output result for [Custom Action - mergeContactsWithInvitations] action in Icon widget.
  List<MemberStruct>? initContacts;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<InvitationsRecord>? invitationsDocs1;
  // Stores action output result for [Backend Call - API (getCrmByAgent)] action in Icon widget.
  ApiCallResponse? apiResultmtw1;
  // Stores action output result for [Backend Call - API (postSMS)] action in Icon widget.
  ApiCallResponse? apiSMSResults;
  // Stores action output result for [Backend Call - API (postEmail)] action in Icon widget.
  ApiCallResponse? postInvitation;
  // Stores action output result for [Custom Action - generateInvitationSmsText] action in Icon widget.
  String? smsInvitationProvider;
  // Stores action output result for [Custom Action - generateInvitationEmailHtml] action in Icon widget.
  String? buyerHtml;
  // Models for contact_item dynamic component.
  late FlutterFlowDynamicModels<ContactItemModel> contactItemModels1;
  // Stores action output result for [Firestore Query - Query a collection] action in contact_item widget.
  InvitationsRecord? singleInviteeDoc1;
  // Models for contact_item dynamic component.
  late FlutterFlowDynamicModels<ContactItemModel> contactItemModels2;
  // Stores action output result for [Firestore Query - Query a collection] action in contact_item widget.
  InvitationsRecord? singleInviteeDoc;

  @override
  void initState(BuildContext context) {
    contactItemModels1 = FlutterFlowDynamicModels(() => ContactItemModel());
    contactItemModels2 = FlutterFlowDynamicModels(() => ContactItemModel());
  }

  @override
  void dispose() {
    contactItemModels1.dispose();
    contactItemModels2.dispose();
  }
}
