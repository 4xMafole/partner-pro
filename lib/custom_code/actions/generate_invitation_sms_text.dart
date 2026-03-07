// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
String generateInvitationSmsText(
  String firstName,
  String shortLink,
  String agentName,
  String invitationType, // 'buyer' or 'agent'
) {
  // Generate SMS content based on invitation type
  if (invitationType.toLowerCase() == 'buyer') {
    return 'Hi $firstName: You now have VIP access to PartnerPro—search homes, book showings & write offers with ease. Tap here to get started: $shortLink — $agentName';
  } else {
    // Agent invitation SMS
    return 'Hi $firstName: $agentName invited you to join PartnerPro to automate your real estate business. Create your account: $shortLink — PartnerPro';
  }
}
