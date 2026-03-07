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

/// Generate SMS notification content for offers
/// Returns SMS text based on notification type
/// Returns empty string for TC notifications (SMS not needed)

String generateOfferSMSContent(
  EmailType emailType,
  dynamic offerData,
) {
  // Parse offer data
  final property = offerData['property'] ?? {};
  final address = property['address'] ?? {};
  final pricing = offerData['pricing'] ?? {};
  final parties = offerData['parties'] ?? {};
  final buyer = parties['buyer'] ?? {};
  final agent = parties['agent'] ?? {};

  // Get short address for SMS
  String getShortAddress() {
    final street = address['street_number']?.toString() ?? '';
    final streetName = address['street_name']?.toString() ?? '';
    final city = address['city']?.toString() ?? '';

    if (street.isNotEmpty && streetName.isNotEmpty) {
      return '$street $streetName${city.isNotEmpty ? ", $city" : ""}';
    }
    return property['address']?.toString() ?? 'the property';
  }

  // Format currency (short version for SMS)
  String formatPrice(dynamic amount) {
    if (amount == null) return '\$0';
    final num = double.tryParse(amount.toString()) ?? 0;
    if (num >= 1000000) {
      return '\$${(num / 1000000).toStringAsFixed(2)}M';
    } else if (num >= 1000) {
      return '\$${(num / 1000).toStringAsFixed(0)}K';
    }
    return '\$${num.toStringAsFixed(0)}';
  }

  final shortAddress = getShortAddress();
  final offerPrice = formatPrice(pricing['purchase_price']);
  final listPrice = formatPrice(pricing['list_price']);
  final buyerName = buyer['name'] ?? 'Buyer';
  final agentName = agent['name'] ?? 'Agent';

  // Return SMS content based on type
  switch (emailType) {
    // CREATION - Buyer to Agent
    case EmailType.creationBuyerToAgent:
      return 'Hi $agentName, I submitted a new offer on $shortAddress. Offer: $offerPrice (List: $listPrice). Please check PartnerPro for details.';

    // CREATION - Agent to Buyer
    case EmailType.creationAgentToBuyer:
      return 'Hi $buyerName, I have successfully submitted your offer on your behalf for $shortAddress. Offer: $offerPrice (List: $listPrice). I\'ll keep you updated. - $agentName';

    // UPDATE - Buyer to Agent
    case EmailType.updateBuyerToAgent:
      return 'Hi $agentName, I revised my offer on $shortAddress. New offer: $offerPrice. Please review the changes in PartnerPro.';

    // UPDATE - Agent to Buyer
    case EmailType.updateAgentToBuyer:
      return 'Hi $buyerName, I have successfully revised your offer on your behalf for $shortAddress. New offer: $offerPrice. Check PartnerPro for details. - $agentName';

    // DECLINE - Buyer to Agent
    case EmailType.declineBuyerToAgent:
      return 'Hi $agentName, I\'ve decided to decline the offer on $shortAddress. Thank you for your help with this property.';

    // TC notifications - return empty (no SMS needed)
    case EmailType.creationToTc:
    case EmailType.updateToTc:
    case EmailType.declineToTc:
      return '';

    // Default fallback
    default:
      return 'PartnerPro offer notification for $shortAddress.';
  }
}
