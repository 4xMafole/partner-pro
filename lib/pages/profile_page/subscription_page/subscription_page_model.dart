import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'subscription_page_widget.dart' show SubscriptionPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SubscriptionPageModel extends FlutterFlowModel<SubscriptionPageWidget> {
  ///  Local state fields for this page.

  List<String> premiumItems = [
    'Professional, live transaction coordination from offer acceptance to closing.',
    'Assistance with collecting, verifying, and managing transaction documents.',
    'Task management to ensure all critical deadlines are met.',
    'Coordination with escrow/title companies for a smooth closing process.',
    'Dedicated communication channel for real-time updates and issue resolution.',
    'Reduction of errors and delays through expert oversight.'
  ];
  void addToPremiumItems(String item) => premiumItems.add(item);
  void removeFromPremiumItems(String item) => premiumItems.remove(item);
  void removeAtIndexFromPremiumItems(int index) => premiumItems.removeAt(index);
  void insertAtIndexInPremiumItems(int index, String item) =>
      premiumItems.insert(index, item);
  void updatePremiumItemsAtIndex(int index, Function(String) updateFn) =>
      premiumItems[index] = updateFn(premiumItems[index]);

  List<String> valuePlanItems = [
    'Property Listing',
    'Offer creation',
    'Document automation',
    'Basic communication tools'
  ];
  void addToValuePlanItems(String item) => valuePlanItems.add(item);
  void removeFromValuePlanItems(String item) => valuePlanItems.remove(item);
  void removeAtIndexFromValuePlanItems(int index) =>
      valuePlanItems.removeAt(index);
  void insertAtIndexInValuePlanItems(int index, String item) =>
      valuePlanItems.insert(index, item);
  void updateValuePlanItemsAtIndex(int index, Function(String) updateFn) =>
      valuePlanItems[index] = updateFn(valuePlanItems[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
