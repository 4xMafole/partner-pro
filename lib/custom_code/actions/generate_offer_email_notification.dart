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

/// Email notification types
/// - 'creationBuyerToAgent': Buyer notifies agent of new offer submission
/// - 'creationAgentToBuyer': Agent confirms to buyer that offer was submitted
/// - 'creationToTc': Notify TC about new offer
/// - 'updateBuyerToAgent': Buyer notifies agent of offer revision
/// - 'updateAgentToBuyer': Agent confirms to buyer that offer was revised
/// - 'updateToTc': Notify TC about offer revision
/// - 'declineBuyerToAgent': Buyer notifies agent of offer decline
/// - 'declineToTc': Notify TC about offer decline

String generateOfferEmailNotification(
  EmailType emailType, // Type of email to generate
  dynamic newOfferData, // Current offer data
  dynamic?
      oldOfferData, // Previous offer data (null for creation, required for updates)
  String logoUrl, // Company logo URL
  String adminPanelUrl, // Link to view full offer
) {
  // Parse offer data
  final property = newOfferData['property'] ?? {};
  final address = property['address'] ?? {};
  final pricing = newOfferData['pricing'] ?? {};
  final parties = newOfferData['parties'] ?? {};
  final buyer = parties['buyer'] ?? {};
  final agent = parties['agent'] ?? {};
  final financials = newOfferData['financials'] ?? {};

  // Format address
  String fullAddress = '';
  if (address['street_number']?.toString().isNotEmpty ?? false) {
    fullAddress += '${address['street_number']} ';
  }
  if (address['street_name']?.toString().isNotEmpty ?? false) {
    fullAddress += '${address['street_name']}, ';
  }
  if (address['city']?.toString().isNotEmpty ?? false) {
    fullAddress += '${address['city']}, ';
  }
  if (address['state']?.toString().isNotEmpty ?? false) {
    fullAddress += '${address['state']} ';
  }
  if (address['zip']?.toString().isNotEmpty ?? false) {
    fullAddress += address['zip'];
  }
  fullAddress = fullAddress.trim();
  if (fullAddress.isEmpty) {
    fullAddress = property['address']?.toString() ?? 'N/A';
  }

  // Format currency
  String formatCurrency(dynamic amount) {
    if (amount == null) return '\$0';
    final num = double.tryParse(amount.toString()) ?? 0;
    return '\$${num.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  // Format date
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.month}/${date.day}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  // Build changes summary for updates
  String buildChangesSummary() {
    if (oldOfferData == null || oldOfferData is! Map || oldOfferData.isEmpty)
      return '';

    final oldPricing = oldOfferData['pricing'] ?? {};
    final oldFinancials = oldOfferData['financials'] ?? {};
    final oldConditions = oldOfferData['conditions'] ?? {};
    final conditions = newOfferData['conditions'] ?? {};
    final oldTitleCompany = oldOfferData['title_company'] ?? {};
    final titleCompany = newOfferData['title_company'] ?? {};

    List<String> changes = [];

    // Check for changes
    bool hasChanged(dynamic newValue, dynamic oldValue) {
      return newValue?.toString() != oldValue?.toString();
    }

    // PRICING CHANGES (2 fields)
    if (hasChanged(pricing['list_price'], oldPricing['list_price'])) {
      changes.add(
          'List Price: ${formatCurrency(oldPricing['list_price'])} → ${formatCurrency(pricing['list_price'])}');
    }
    if (hasChanged(pricing['purchase_price'], oldPricing['purchase_price'])) {
      changes.add(
          'Offer Price: ${formatCurrency(oldPricing['purchase_price'])} → ${formatCurrency(pricing['purchase_price'])}');
    }

    // FINANCIAL CHANGES (9 fields)
    if (hasChanged(financials['loan_type'], oldFinancials['loan_type'])) {
      changes.add(
          'Loan Type: ${oldFinancials['loan_type']} → ${financials['loan_type']}');
    }
    if (hasChanged(financials['down_payment_amount'],
        oldFinancials['down_payment_amount'])) {
      changes.add(
          'Down Payment: ${formatCurrency(oldFinancials['down_payment_amount'])} → ${formatCurrency(financials['down_payment_amount'])}');
    }
    if (hasChanged(financials['loan_amount'], oldFinancials['loan_amount'])) {
      changes.add(
          'Loan Amount: ${formatCurrency(oldFinancials['loan_amount'])} → ${formatCurrency(financials['loan_amount'])}');
    }
    if (hasChanged(
        financials['deposit_amount'], oldFinancials['deposit_amount'])) {
      changes.add(
          'Earnest Money: ${formatCurrency(oldFinancials['deposit_amount'])} → ${formatCurrency(financials['deposit_amount'])}');
    }
    if (hasChanged(financials['deposit_type'], oldFinancials['deposit_type'])) {
      changes.add(
          'Deposit Type: ${oldFinancials['deposit_type']} → ${financials['deposit_type']}');
    }
    if (hasChanged(financials['additional_earnest'],
        oldFinancials['additional_earnest'])) {
      changes.add(
          'Additional Earnest: ${formatCurrency(oldFinancials['additional_earnest'])} → ${formatCurrency(financials['additional_earnest'])}');
    }
    if (hasChanged(financials['option_fee'], oldFinancials['option_fee'])) {
      changes.add(
          'Option Fee: ${formatCurrency(oldFinancials['option_fee'])} → ${formatCurrency(financials['option_fee'])}');
    }
    if (hasChanged(
        financials['credit_request'], oldFinancials['credit_request'])) {
      changes.add(
          'Seller Credit: ${formatCurrency(oldFinancials['credit_request'])} → ${formatCurrency(financials['credit_request'])}');
    }
    if (hasChanged(
        financials['coverage_amount'], oldFinancials['coverage_amount'])) {
      changes.add(
          'Home Warranty: ${formatCurrency(oldFinancials['coverage_amount'])} → ${formatCurrency(financials['coverage_amount'])}');
    }

    // TIMELINE CHANGES (1 field)
    if (hasChanged(
        newOfferData['closing_date'], oldOfferData['closing_date'])) {
      changes.add(
          'Closing Date: ${formatDate(oldOfferData['closing_date'])} → ${formatDate(newOfferData['closing_date'])}');
    }

    // CONDITION CHANGES (3 fields)
    if (hasChanged(conditions['property_condition'],
        oldConditions['property_condition'])) {
      changes.add(
          'Property Condition: ${oldConditions['property_condition']} → ${conditions['property_condition']}');
    }
    if (hasChanged(conditions['pre_approval'], oldConditions['pre_approval'])) {
      final oldVal = oldConditions['pre_approval'] == true ? 'Yes' : 'No';
      final newVal = conditions['pre_approval'] == true ? 'Yes' : 'No';
      changes.add('Pre-Approval: $oldVal → $newVal');
    }
    if (hasChanged(conditions['survey'], oldConditions['survey'])) {
      final oldVal = oldConditions['survey'] == true ? 'Yes' : 'No';
      final newVal = conditions['survey'] == true ? 'Yes' : 'No';
      changes.add('Survey: $oldVal → $newVal');
    }

    // TITLE COMPANY CHANGES (2 fields)
    if (hasChanged(
        titleCompany['company_name'], oldTitleCompany['company_name'])) {
      changes.add(
          'Title Company: ${oldTitleCompany['company_name']} → ${titleCompany['company_name']}');
    }
    if (hasChanged(titleCompany['choice'], oldTitleCompany['choice'])) {
      changes.add(
          'Title Fees Paid By: ${oldTitleCompany['choice']} → ${titleCompany['choice']}');
    }

    if (changes.isEmpty) return '';

    return '''
      <tr><td style="height: 20px;"></td></tr>
      <tr><td style="background-color: #eff6ff; border-left: 4px solid #3b82f6; padding: 20px; border-radius: 8px;">
        <p style="font-size: 16px; font-weight: 600; color: #1e40af; margin: 0 0 12px 0;">📝 What Changed:</p>
        <ul style="margin: 0; padding-left: 20px; color: #1f2937;">
          ${changes.map((c) => '<li style="margin-bottom: 8px; font-size: 14px;">$c</li>').join('')}
        </ul>
      </td></tr>
    ''';
  }

  // Get email content based on type
  Map<String, String> getEmailContent() {
    final buyerName = buyer['name'] ?? 'Buyer';
    final agentName = agent['name'] ?? 'Agent';

    switch (emailType) {
      // CREATION EMAILS
      case EmailType.creationBuyerToAgent:
        return {
          'subject': 'New Offer Submitted - $fullAddress',
          'title': 'New Offer Submitted',
          'badge': 'NEW',
          'badgeColor': '#10b981',
          'greeting': 'Hi $agentName,',
          'message':
              'I have submitted a new offer through PartnerPro for the property below. Please review the details and let me know the next steps.',
          'showChanges': 'false',
        };

      case EmailType.creationAgentToBuyer:
        return {
          'subject': 'Your Offer Has Been Submitted - $fullAddress',
          'title': 'Offer Submitted Successfully',
          'badge': 'CONFIRMED',
          'badgeColor': '#10b981',
          'greeting': 'Hi $buyerName,',
          'message':
              'Great news! I have successfully submitted your offer on your behalf through PartnerPro. Below are the details of your submission. I\'ll keep you updated on any responses.',
          'showChanges': 'false',
        };

      case EmailType.creationToTc:
        return {
          'subject': 'New Offer to Coordinate - $fullAddress',
          'title': 'New Offer Received',
          'badge': 'NEW',
          'badgeColor': '#10b981',
          'greeting': 'Hello Transaction Coordinator,',
          'message':
              'A new offer has been submitted through PartnerPro and requires coordination. Please review the details below and prepare the necessary documentation.',
          'showChanges': 'false',
        };

      // UPDATE EMAILS
      case EmailType.updateBuyerToAgent:
        return {
          'subject': 'Offer Revised - $fullAddress',
          'title': 'Offer Has Been Revised',
          'badge': 'UPDATED',
          'badgeColor': '#3b82f6',
          'greeting': 'Hi $agentName,',
          'message':
              'I have revised my offer through PartnerPro. Please review the updated terms below and advise on the next steps.',
          'showChanges': 'true',
        };

      case EmailType.updateAgentToBuyer:
        return {
          'subject': 'Your Offer Has Been Revised - $fullAddress',
          'title': 'Offer Updated Successfully',
          'badge': 'REVISED',
          'badgeColor': '#3b82f6',
          'greeting': 'Hi $buyerName,',
          'message':
              'I have successfully updated your offer on your behalf through PartnerPro. Below is a summary of the revised terms. I\'ll continue to advocate for your best interests throughout the process.',
          'showChanges': 'true',
        };

      case EmailType.updateToTc:
        return {
          'subject': 'Offer Revised - Action Required - $fullAddress',
          'title': 'Offer Has Been Revised',
          'badge': 'UPDATED',
          'badgeColor': '#3b82f6',
          'greeting': 'Hello Transaction Coordinator,',
          'message':
              'The offer has been revised through PartnerPro. Please review the changes below and update all documentation accordingly.',
          'showChanges': 'true',
        };

      // DECLINE EMAILS
      case EmailType.declineBuyerToAgent:
        return {
          'subject': 'Offer Declined - $fullAddress',
          'title': 'Offer Declined',
          'badge': 'DECLINED',
          'badgeColor': '#ef4444',
          'greeting': 'Hi $agentName,',
          'message':
              'I have decided to decline this offer. Thank you for your assistance with this property. I look forward to continuing our search for the right home.',
          'showChanges': 'false',
        };

      case EmailType.declineToTc:
        return {
          'subject':
              'Offer Declined - No Further Action Required - $fullAddress',
          'title': 'Offer Declined',
          'badge': 'DECLINED',
          'badgeColor': '#ef4444',
          'greeting': 'Hello Transaction Coordinator,',
          'message':
              'This offer has been declined by the buyer. No further action is required for this transaction. Please archive all related documentation.',
          'showChanges': 'false',
        };

      default:
        return {
          'subject': 'Offer Notification - $fullAddress',
          'title': 'Offer Notification',
          'badge': 'INFO',
          'badgeColor': '#6b7280',
          'greeting': 'Hello,',
          'message':
              'An offer notification has been generated through PartnerPro.',
          'showChanges': 'false',
        };
    }
  }

  final content = getEmailContent();
  final showChanges = content['showChanges'] == 'true';
  final buyerName = buyer['name'] ?? 'Buyer';
  final agentName = agent['name'] ?? 'Agent';

  // Determine sender name and title based on email type
  String getSenderName() {
    switch (emailType) {
      case EmailType.creationBuyerToAgent:
      case EmailType.updateBuyerToAgent:
      case EmailType.declineBuyerToAgent:
        return buyerName; // Buyer is sending
      case EmailType.creationAgentToBuyer:
      case EmailType.updateAgentToBuyer:
        return agentName; // Agent is sending
      case EmailType.creationToTc:
      case EmailType.updateToTc:
      case EmailType.declineToTc:
        return agentName; // Agent notifying TC (or could be empty)
      default:
        return agentName;
    }
  }

  String getSenderRole() {
    switch (emailType) {
      case EmailType.creationBuyerToAgent:
      case EmailType.updateBuyerToAgent:
      case EmailType.declineBuyerToAgent:
        return 'Buyer'; // Buyer is sending
      case EmailType.creationAgentToBuyer:
      case EmailType.updateAgentToBuyer:
        return "Buyer's Agent"; // Agent is sending to buyer
      case EmailType.creationToTc:
      case EmailType.updateToTc:
      case EmailType.declineToTc:
        return "Buyer's Agent"; // TC emails - no role signature needed
      default:
        return '';
    }
  }

  final senderName = getSenderName();
  final senderRole = getSenderRole();

  return '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${content['subject']}</title>
    <style type="text/css">
        body, table, td, div, p, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; margin: 0; padding: 0; }
        table { border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
        .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; }
        .header { padding: 40px 40px 30px; border-bottom: 2px solid #D0B27D; text-align: center; }
        .logo-img { max-width: 180px; height: auto; display: block; margin: 0 auto 20px; }
        .logo-text { font-size: 28px; font-weight: bold; color: #D0B27D; margin-bottom: 10px; }
        .title { font-size: 24px; font-weight: bold; color: #1f2937; margin: 10px 0 5px 0; }
        .status-badge { display: inline-block; background-color: ${content['badgeColor']}; color: white; padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 600; margin-left: 10px; }
        .subtitle { font-size: 14px; color: #6b7280; margin-top: 10px; }
        .body-content { padding: 40px; }
        .greeting { font-size: 16px; color: #1f2937; font-weight: 600; margin-bottom: 15px; }
        .message { font-size: 15px; color: #4b5563; margin-bottom: 25px; line-height: 1.8; }
        .address-title { font-size: 14px; font-weight: 600; color: #6b7280; margin: 25px 0 10px 0; }
        .property-address { font-size: 18px; font-weight: 600; color: #1f2937; }
        .summary-title { font-size: 16px; font-weight: 600; color: #1f2937; margin: 25px 0 15px 0; }
        .summary-item { font-size: 15px; color: #4b5563; padding: 8px 0; border-bottom: 1px solid #e5e7eb; }
        .summary-item:last-child { border-bottom: none; }
        .summary-label { font-weight: 600; color: #6b7280; }
        .summary-value { color: #1f2937; font-weight: 500; }
        .cta-button { display: block; width: fit-content; margin: 30px auto; background-color: #D0B27D; color: #ffffff !important; text-decoration: none; padding: 14px 32px; border-radius: 6px; font-weight: 600; font-size: 16px; text-align: center; }
        .contact-box { background-color: #f9fafb; padding: 20px; margin: 20px 0; border-radius: 8px; }
        .contact-title { font-weight: 600; color: #1f2937; margin-bottom: 10px; font-size: 14px; }
        .contact-detail { color: #4b5563; font-size: 14px; margin: 5px 0; }
        .footer { margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb; font-size: 13px; color: #6b7280; text-align: center; }
        .decline-notice { background-color: #fef2f2; border-left: 4px solid #ef4444; padding: 15px; margin: 20px 0; border-radius: 8px; color: #991b1b; font-size: 14px; }
        @media (max-width: 600px) {
            .body-content { padding: 25px; }
            .header { padding: 25px; }
            .logo-img { max-width: 150px; }
        }
    </style>
</head>
<body style="margin: 0; padding: 20px; background-color: #f8f9fa; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa;">
        <tr><td align="center" style="padding: 20px;">
            <table class="container" width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 8px;">
                <!-- HEADER -->
                <tr><td class="header">
                    ${logoUrl.isNotEmpty ? '<img src="$logoUrl" alt="PartnerPro Logo" class="logo-img" style="max-width: 180px;">' : '<div class="logo-text">PartnerPro</div>'}
                    <div class="title">${content['title']}</div>
                    <span class="status-badge">${content['badge']}</span>
                    <div class="subtitle">${formatDate(newOfferData['created_time'])}</div>
                </td></tr>

                <!-- BODY -->
                <tr><td class="body-content">
                    <div class="greeting">${content['greeting']}</div>
                    <div class="message">${content['message']}</div>

                    ${emailType.name.startsWith('decline') ? '<div class="decline-notice">⚠️ This offer has been declined and is no longer active.</div>' : ''}

                    <!-- PROPERTY ADDRESS -->
                    <div class="address-title">Property Address</div>
                    <div class="property-address">$fullAddress</div>

                    <!-- OFFER SUMMARY -->
                    <div class="summary-title">Updated Offer Summary</div>
                    <div class="summary-item">
                        <span class="summary-label">Offer Price:</span>
                        <span class="summary-value">${formatCurrency(pricing['purchase_price'])}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Loan Type:</span>
                        <span class="summary-value">${financials['loan_type'] ?? 'N/A'}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Earnest Money:</span>
                        <span class="summary-value">${formatCurrency(financials['deposit_amount'])}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Closing Date:</span>
                        <span class="summary-value">${formatDate(newOfferData['closing_date'])}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Seller Credit:</span>
                        <span class="summary-value">${formatCurrency(financials['credit_request'])}</span>
                    </div>

                    ${showChanges ? buildChangesSummary() : ''}

                    <!-- CTA -->
                    <center>
                        <a href="$adminPanelUrl" class="cta-button">Review Full Details in PartnerPro</a>
                    </center>

                    <p style="font-size: 15px; color: #4b5563; margin: 20px 0; line-height: 1.8;">If you have any questions or would like to discuss next steps, feel free to reach out.</p>

                    ${senderRole.isNotEmpty ? '<p style="font-size: 15px; color: #4b5563; margin: 20px 0; line-height: 1.8;"><strong>Best regards,</strong><br>$senderName<br>$senderRole</p>' : '<p style="font-size: 15px; color: #4b5563; margin: 20px 0; line-height: 1.8;"><strong>Best regards,</strong><br>$senderName</p>'}
                </td></tr>

                <!-- FOOTER -->
                <tr><td class="footer" style="padding: 20px 40px;">
                    <p style="margin: 5px 0;">This notification was generated through PartnerPro</p>
                </td></tr>
            </table>
        </td></tr>
    </table>
</body>
</html>
''';
}
