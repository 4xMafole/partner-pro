import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'auth_register_role_dialog_widget.dart'
    show AuthRegisterRoleDialogWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthRegisterRoleDialogModel
    extends FlutterFlowModel<AuthRegisterRoleDialogWidget> {
  ///  Local state fields for this component.

  List<String> accountType = ['I\'m a buyer', 'I\'m an agent'];
  void addToAccountType(String item) => accountType.add(item);
  void removeFromAccountType(String item) => accountType.remove(item);
  void removeAtIndexFromAccountType(int index) => accountType.removeAt(index);
  void insertAtIndexInAccountType(int index, String item) =>
      accountType.insert(index, item);
  void updateAccountTypeAtIndex(int index, Function(String) updateFn) =>
      accountType[index] = updateFn(accountType[index]);

  String? selectedAccount;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
