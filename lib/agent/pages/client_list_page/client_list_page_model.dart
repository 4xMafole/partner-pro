import '/agent/components/agent_bottom_navbar/agent_bottom_navbar_widget.dart';
import '/agent/components/member_item/member_item_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/seller/empty_listing/empty_listing_widget.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'client_list_page_widget.dart' show ClientListPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ClientListPageModel extends FlutterFlowModel<ClientListPageWidget> {
  ///  Local state fields for this page.

  String selectedMemberType = 'agent-to-buyer';

  List<MemberStruct> membersList = [];
  void addToMembersList(MemberStruct item) => membersList.add(item);
  void removeFromMembersList(MemberStruct item) => membersList.remove(item);
  void removeAtIndexFromMembersList(int index) => membersList.removeAt(index);
  void insertAtIndexInMembersList(int index, MemberStruct item) =>
      membersList.insert(index, item);
  void updateMembersListAtIndex(int index, Function(MemberStruct) updateFn) =>
      membersList[index] = updateFn(membersList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Models for member_item dynamic component.
  late FlutterFlowDynamicModels<MemberItemModel> memberItemModels;
  // Model for agent_bottom_navbar component.
  late AgentBottomNavbarModel agentBottomNavbarModel;

  @override
  void initState(BuildContext context) {
    memberItemModels = FlutterFlowDynamicModels(() => MemberItemModel());
    agentBottomNavbarModel =
        createModel(context, () => AgentBottomNavbarModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    memberItemModels.dispose();
    agentBottomNavbarModel.dispose();
  }

  /// Action blocks.
  Future fetchMembers(BuildContext context) async {
    ApiCallResponse? apiResult3rk;

    apiResult3rk = await IwoAgentClientGroup.getAllClientsByAgentIdCall.call(
      agentId: currentUserUid,
    );

    if ((apiResult3rk?.succeeded ?? true)) {
      membersList = ((apiResult3rk?.jsonBody ?? '')
              .toList()
              .map<MemberStruct?>(MemberStruct.maybeFromMap)
              .toList() as Iterable<MemberStruct?>)
          .withoutNulls
          .toList()
          .cast<MemberStruct>();
    }
  }
}
