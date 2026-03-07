// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
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
