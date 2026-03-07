import '../../core/enums/app_enums.dart';

/// Generates HTML email body for offer notifications.
///
/// Handles all 8 EmailType variants (creation/update/decline for buyer↔agent↔TC).
String generateOfferEmailNotification({
  required EmailType emailType,
  required Map<String, dynamic> newOfferData,
  Map<String, dynamic>? oldOfferData,
  required String logoUrl,
  required String adminPanelUrl,
}) {
  // Extract common data
  final property = newOfferData['property'] as Map<String, dynamic>? ?? {};
  final address = property['address'] as Map<String, dynamic>? ?? {};
  final pricing = newOfferData['pricing'] as Map<String, dynamic>? ?? {};
  final financials = newOfferData['financials'] as Map<String, dynamic>? ?? {};
  final parties = newOfferData['parties'] as Map<String, dynamic>? ?? {};
  final buyer = parties['buyer'] as Map<String, dynamic>? ?? {};
  final agent = parties['agent'] as Map<String, dynamic>? ?? {};

  final streetNum = address['street_number'] ?? '';
  final streetName = address['street_name'] ?? '';
  final city = address['city'] ?? '';
  final state = address['state'] ?? '';
  final zip = address['zip'] ?? '';
  final fullAddress = '$streetNum $streetName, $city, $state $zip';

  final listPrice = _formatCurrency(pricing['list_price']);
  final purchasePrice = _formatCurrency(pricing['purchase_price']);
  final loanType = financials['loan_type'] ?? 'N/A';
  final closingDate = newOfferData['closing_date'] ?? 'TBD';
  final creditRequest = _formatCurrency(financials['credit_request']);

  final buyerName = buyer['name'] ?? 'Buyer';
  final agentName = agent['name'] ?? 'Agent';

  // Determine status info
  String statusLabel;
  String statusColor;
  String greeting;
  String messageBody;

  switch (emailType) {
    case EmailType.creationBuyerToAgent:
      statusLabel = 'New Offer Submitted';
      statusColor = '#4CAF50';
      greeting = 'Hi $agentName,';
      messageBody =
          '$buyerName has submitted a new offer on <strong>$fullAddress</strong>.';
      break;
    case EmailType.creationAgentToBuyer:
      statusLabel = 'Offer Confirmed';
      statusColor = '#4CAF50';
      greeting = 'Hi $buyerName,';
      messageBody =
          'Your offer on <strong>$fullAddress</strong> has been successfully submitted. I\'ll keep you updated on any progress.';
      break;
    case EmailType.creationToTc:
      statusLabel = 'New Offer \u2013 Action Required';
      statusColor = '#FF9800';
      greeting = 'Hello,';
      messageBody =
          'A new offer has been submitted on <strong>$fullAddress</strong>. Please review the details below.';
      break;
    case EmailType.updateBuyerToAgent:
      statusLabel = 'Offer Revised';
      statusColor = '#2196F3';
      greeting = 'Hi $agentName,';
      messageBody =
          '$buyerName has revised their offer on <strong>$fullAddress</strong>.';
      break;
    case EmailType.updateAgentToBuyer:
      statusLabel = 'Offer Revision Confirmed';
      statusColor = '#2196F3';
      greeting = 'Hi $buyerName,';
      messageBody =
          'Your offer revision on <strong>$fullAddress</strong> has been submitted. Check PartnerPro for the latest details.';
      break;
    case EmailType.updateToTc:
      statusLabel = 'Offer Revised \u2013 Review Required';
      statusColor = '#FF9800';
      greeting = 'Hello,';
      messageBody =
          'An offer has been revised on <strong>$fullAddress</strong>. Please review the updated details.';
      break;
    case EmailType.declineBuyerToAgent:
      statusLabel = 'Offer Declined';
      statusColor = '#F44336';
      greeting = 'Hi $agentName,';
      messageBody =
          '$buyerName has decided to decline the offer on <strong>$fullAddress</strong>.';
      break;
    case EmailType.declineToTc:
      statusLabel = 'Offer Declined';
      statusColor = '#F44336';
      greeting = 'Hello,';
      messageBody =
          'The buyer has declined the offer on <strong>$fullAddress</strong>.';
      break;
    case EmailType.unknown:
      statusLabel = 'Offer Update';
      statusColor = '#9E9E9E';
      greeting = 'Hello,';
      messageBody =
          'There has been an update on the offer for <strong>$fullAddress</strong>.';
      break;
  }

  // Build "What Changed" section for updates
  String changedSection = '';
  if (oldOfferData != null &&
      (emailType == EmailType.updateBuyerToAgent ||
          emailType == EmailType.updateAgentToBuyer ||
          emailType == EmailType.updateToTc)) {
    final changes = _getChanges(newOfferData, oldOfferData);
    if (changes.isNotEmpty) {
      final rows = changes.map((c) => '''
<tr>
  <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#666;">${c['field']}</td>
  <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#F44336;text-decoration:line-through;">${c['old']}</td>
  <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#4CAF50;font-weight:bold;">${c['new']}</td>
</tr>''').join('');

      changedSection = '''
<div style="margin-top:24px;">
  <h3 style="color:#333;font-size:16px;">What Changed</h3>
  <table width="100%" cellpadding="0" cellspacing="0" style="border:1px solid #eee;border-radius:8px;overflow:hidden;">
    <tr style="background:#f5f5f5;">
      <th style="padding:10px 12px;text-align:left;color:#666;font-size:13px;">Field</th>
      <th style="padding:10px 12px;text-align:left;color:#666;font-size:13px;">Previous</th>
      <th style="padding:10px 12px;text-align:left;color:#666;font-size:13px;">Updated</th>
    </tr>
    $rows
  </table>
</div>''';
    }
  }

  return '''
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="margin:0;padding:0;background-color:#f5f5f5;font-family:Arial,sans-serif;">
<table width="100%" cellpadding="0" cellspacing="0" style="max-width:600px;margin:0 auto;background:#ffffff;">
  <tr>
    <td style="padding:24px;text-align:center;background:linear-gradient(135deg,#D0B27D,#B8963E);">
      <img src="$logoUrl" alt="PartnerPro" style="height:48px;" />
    </td>
  </tr>
  <tr>
    <td style="padding:0 24px;text-align:center;">
      <div style="display:inline-block;background:$statusColor;color:#fff;padding:8px 20px;border-radius:0 0 8px 8px;font-size:14px;font-weight:bold;">
        $statusLabel
      </div>
    </td>
  </tr>
  <tr>
    <td style="padding:24px;">
      <p style="font-size:15px;color:#333;">$greeting</p>
      <p style="font-size:15px;color:#333;">$messageBody</p>

      <div style="background:#f9f9f9;border-radius:8px;padding:16px;margin:16px 0;">
        <p style="margin:0 0 4px;font-size:13px;color:#999;">Property</p>
        <p style="margin:0;font-size:16px;font-weight:bold;color:#333;">$fullAddress</p>
      </div>

      <table width="100%" cellpadding="0" cellspacing="0" style="margin:16px 0;">
        <tr>
          <td style="padding:8px 0;border-bottom:1px solid #eee;">
            <span style="color:#999;font-size:13px;">List Price</span><br/>
            <span style="color:#333;font-size:15px;font-weight:bold;">$listPrice</span>
          </td>
          <td style="padding:8px 0;border-bottom:1px solid #eee;">
            <span style="color:#999;font-size:13px;">Offer Price</span><br/>
            <span style="color:#333;font-size:15px;font-weight:bold;">$purchasePrice</span>
          </td>
        </tr>
        <tr>
          <td style="padding:8px 0;border-bottom:1px solid #eee;">
            <span style="color:#999;font-size:13px;">Loan Type</span><br/>
            <span style="color:#333;font-size:15px;">$loanType</span>
          </td>
          <td style="padding:8px 0;border-bottom:1px solid #eee;">
            <span style="color:#999;font-size:13px;">Closing Date</span><br/>
            <span style="color:#333;font-size:15px;">$closingDate</span>
          </td>
        </tr>
        <tr>
          <td colspan="2" style="padding:8px 0;">
            <span style="color:#999;font-size:13px;">Credit Request</span><br/>
            <span style="color:#333;font-size:15px;">$creditRequest</span>
          </td>
        </tr>
      </table>

      $changedSection

      <table cellpadding="0" cellspacing="0" style="margin:24px auto;">
        <tr>
          <td style="background:#D0B27D;border-radius:8px;padding:14px 32px;">
            <a href="$adminPanelUrl" style="color:#ffffff;text-decoration:none;font-weight:bold;font-size:16px;">View Offer Details</a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td style="padding:16px;text-align:center;background:#f9f9f9;color:#999;font-size:12px;">
      &copy; PartnerPro. All rights reserved.
    </td>
  </tr>
</table>
</body>
</html>''';
}

/// Generates SMS text for offer notifications.
String generateOfferSmsContent({
  required EmailType emailType,
  required Map<String, dynamic> offerData,
}) {
  final property = offerData['property'] as Map<String, dynamic>? ?? {};
  final address = property['address'] as Map<String, dynamic>? ?? {};
  final pricing = offerData['pricing'] as Map<String, dynamic>? ?? {};
  final parties = offerData['parties'] as Map<String, dynamic>? ?? {};
  final buyer = parties['buyer'] as Map<String, dynamic>? ?? {};
  final agent = parties['agent'] as Map<String, dynamic>? ?? {};

  final fullAddress =
      '${address['street_number']} ${address['street_name']}, ${address['city']}, ${address['state']}';
  final listPrice = _formatCurrency(pricing['list_price']);
  final purchasePrice = _formatCurrency(pricing['purchase_price']);
  final buyerName = buyer['name'] ?? 'Buyer';
  final agentName = agent['name'] ?? 'Agent';

  switch (emailType) {
    case EmailType.creationBuyerToAgent:
      return 'Hi $agentName, I submitted a new offer on $fullAddress. Offer: $purchasePrice (List: $listPrice). Please check PartnerPro for details.';
    case EmailType.creationAgentToBuyer:
      return 'Hi $buyerName, I have successfully submitted your offer on $fullAddress. Offer: $purchasePrice (List: $listPrice). I\'ll keep you updated.';
    case EmailType.updateBuyerToAgent:
      return 'Hi $agentName, I revised my offer on $fullAddress. New offer: $purchasePrice. Please review the changes in PartnerPro.';
    case EmailType.updateAgentToBuyer:
      return 'Hi $buyerName, I have successfully revised your offer on $fullAddress. New offer: $purchasePrice. Check PartnerPro for details.';
    case EmailType.declineBuyerToAgent:
      return 'Hi $agentName, I\'ve decided to decline the offer on $fullAddress. Thank you for your help with this property.';
    // TC recipients don't get SMS
    case EmailType.creationToTc:
    case EmailType.updateToTc:
    case EmailType.declineToTc:
    case EmailType.unknown:
      return '';
  }
}

/// Generates HTML email for property suggestion from agent to buyer.
String generatePropertySuggestionEmail({
  required Map<String, dynamic> propertyData,
  required String buyerName,
  required String agentName,
  required String agentPhone,
  required String agentEmail,
  required String logoUrl,
  required String propertyUrl,
}) {
  final address = propertyData['address'] as Map<String, dynamic>? ?? {};
  final fullAddress =
      '${address['street_number'] ?? ''} ${address['street_name'] ?? ''}, ${address['city'] ?? ''}, ${address['state'] ?? ''} ${address['zip'] ?? ''}';
  final price =
      _formatCurrency(propertyData['list_price'] ?? propertyData['listPrice']);
  final beds = propertyData['bedrooms']?.toString() ?? 'N/A';
  final baths = propertyData['bathrooms_total']?.toString() ?? 'N/A';
  final sqft = propertyData['living_area']?.toString() ?? 'N/A';
  final yearBuilt = propertyData['year_built']?.toString() ?? 'N/A';
  final propertyType = propertyData['property_type']?.toString() ?? 'N/A';
  final lotSize = propertyData['lot_size_area']?.toString() ?? 'N/A';
  final imageUrl = propertyData['media_url'] ?? propertyData['mediaURL'] ?? '';

  return '''
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="margin:0;padding:0;background-color:#f5f5f5;font-family:Arial,sans-serif;">
<table width="100%" cellpadding="0" cellspacing="0" style="max-width:600px;margin:0 auto;background:#ffffff;">
  <tr>
    <td style="padding:24px;text-align:center;background:linear-gradient(135deg,#D0B27D,#B8963E);">
      <img src="$logoUrl" alt="PartnerPro" style="height:48px;" />
    </td>
  </tr>
  ${imageUrl.isNotEmpty ? '''
  <tr>
    <td style="padding:0;">
      <img src="$imageUrl" alt="Property" style="width:100%;height:200px;object-fit:cover;" />
    </td>
  </tr>''' : ''}
  <tr>
    <td style="padding:24px;">
      <p style="font-size:15px;color:#333;">Hi $buyerName,</p>
      <p style="font-size:15px;color:#333;">I found a property that I think matches your criteria. Check it out!</p>

      <div style="background:#D0B27D22;border-left:4px solid #D0B27D;padding:12px 16px;margin:16px 0;border-radius:4px;">
        <p style="margin:0;font-weight:bold;font-size:16px;color:#333;">$fullAddress</p>
      </div>

      <table width="100%" cellpadding="0" cellspacing="0" style="margin:16px 0;">
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Price</td>
          <td style="padding:6px 0;color:#333;font-weight:bold;">$price</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Beds</td>
          <td style="padding:6px 0;color:#333;">$beds</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Baths</td>
          <td style="padding:6px 0;color:#333;">$baths</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Sq Ft</td>
          <td style="padding:6px 0;color:#333;">$sqft</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Year Built</td>
          <td style="padding:6px 0;color:#333;">$yearBuilt</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Type</td>
          <td style="padding:6px 0;color:#333;">$propertyType</td>
        </tr>
        <tr>
          <td style="padding:6px 0;color:#999;font-size:13px;">Lot Size</td>
          <td style="padding:6px 0;color:#333;">$lotSize</td>
        </tr>
      </table>

      <table cellpadding="0" cellspacing="0" style="margin:24px auto;">
        <tr>
          <td style="background:#D0B27D;border-radius:8px;padding:14px 32px;">
            <a href="$propertyUrl" style="color:#ffffff;text-decoration:none;font-weight:bold;font-size:16px;">View Property</a>
          </td>
        </tr>
      </table>

      <div style="margin-top:24px;padding-top:16px;border-top:1px solid #eee;">
        <p style="color:#666;font-size:13px;margin:0;">$agentName</p>
        <p style="color:#666;font-size:13px;margin:2px 0;">$agentPhone</p>
        <p style="color:#666;font-size:13px;margin:2px 0;">$agentEmail</p>
      </div>
    </td>
  </tr>
  <tr>
    <td style="padding:16px;text-align:center;background:#f9f9f9;color:#999;font-size:12px;">
      &copy; PartnerPro. All rights reserved.
    </td>
  </tr>
</table>
</body>
</html>''';
}

/// Generates SMS text for property suggestion.
String generatePropertySuggestionSms({
  required Map<String, dynamic> propertyData,
  required String buyerName,
  required String agentName,
}) {
  final address = propertyData['address'] as Map<String, dynamic>? ?? {};
  final fullAddress =
      '${address['street_number'] ?? ''} ${address['street_name'] ?? ''}, ${address['city'] ?? ''}, ${address['state'] ?? ''}';
  final price =
      _formatCurrency(propertyData['list_price'] ?? propertyData['listPrice']);
  final beds = propertyData['bedrooms']?.toString() ?? '?';
  final baths = propertyData['bathrooms_total']?.toString() ?? '?';

  return 'Hi $buyerName! I found a property that matches your criteria: $fullAddress - $price, $beds bed, $baths bath. Check PartnerPro for full details! - $agentName';
}

// ── Helpers ──────────────────────────────────────────────────

String _formatCurrency(dynamic value) {
  if (value == null) return '\$0';
  final num = double.tryParse(value.toString()) ?? 0;
  if (num >= 1000) {
    return '\$${num.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }
  return '\$${num.toStringAsFixed(0)}';
}

List<Map<String, String>> _getChanges(
    Map<String, dynamic> newData, Map<String, dynamic> oldData) {
  final changes = <Map<String, String>>[];

  void check(String label, dynamic newVal, dynamic oldVal) {
    final n = newVal?.toString() ?? '';
    final o = oldVal?.toString() ?? '';
    if (n != o) {
      changes.add({
        'field': label,
        'old': o.isEmpty ? 'N/A' : o,
        'new': n.isEmpty ? 'N/A' : n
      });
    }
  }

  final np = newData['pricing'] as Map<String, dynamic>? ?? {};
  final op = oldData['pricing'] as Map<String, dynamic>? ?? {};
  check('List Price', _formatCurrency(np['list_price']),
      _formatCurrency(op['list_price']));
  check('Purchase Price', _formatCurrency(np['purchase_price']),
      _formatCurrency(op['purchase_price']));

  final nf = newData['financials'] as Map<String, dynamic>? ?? {};
  final of2 = oldData['financials'] as Map<String, dynamic>? ?? {};
  check('Loan Type', nf['loan_type'], of2['loan_type']);
  check('Down Payment', _formatCurrency(nf['down_payment_amount']),
      _formatCurrency(of2['down_payment_amount']));
  check('Loan Amount', _formatCurrency(nf['loan_amount']),
      _formatCurrency(of2['loan_amount']));
  check('Deposit', _formatCurrency(nf['deposit_amount']),
      _formatCurrency(of2['deposit_amount']));
  check('Option Fee', _formatCurrency(nf['option_fee']),
      _formatCurrency(of2['option_fee']));
  check('Credit Request', _formatCurrency(nf['credit_request']),
      _formatCurrency(of2['credit_request']));

  check('Closing Date', newData['closing_date'], oldData['closing_date']);

  final nc = newData['conditions'] as Map<String, dynamic>? ?? {};
  final oc = oldData['conditions'] as Map<String, dynamic>? ?? {};
  check(
      'Property Condition', nc['property_condition'], oc['property_condition']);

  return changes;
}

/// Static helper class for invitation-specific email/SMS generators.
class EmailGenerators {
  EmailGenerators._();

  static String buyerInvitationEmail({
    required String inviterFullName,
    required String signUpUrl,
    required String logoUrl,
    String? inviterMLS,
    String? inviterContact,
    String? brokerageName,
    required String inviteeFirstName,
  }) {
    final mlsLine = inviterMLS != null && inviterMLS.isNotEmpty
        ? '<p style="margin:0;color:#666;">MLS#: $inviterMLS</p>'
        : '';
    final contactLine = inviterContact != null && inviterContact.isNotEmpty
        ? '<p style="margin:0;color:#666;">Contact: $inviterContact</p>'
        : '';
    final brokerageLine = brokerageName != null && brokerageName.isNotEmpty
        ? '<p style="margin:0;color:#666;">Brokerage: $brokerageName</p>'
        : '';

    return '''<!DOCTYPE html>
<html><head><meta charset="UTF-8"></head>
<body style="font-family:Arial,sans-serif;background:#f4f4f4;padding:20px;">
<table width="600" align="center" style="background:#fff;border-radius:8px;overflow:hidden;">
<tr><td style="background:#1a73e8;padding:24px;text-align:center;">
<img src="$logoUrl" alt="PartnerPro" height="40" style="max-height:40px;">
</td></tr>
<tr><td style="padding:32px;">
<h2 style="color:#333;">Hi $inviteeFirstName,</h2>
<p style="color:#555;line-height:1.6;">$inviterFullName has invited you to join <strong>PartnerPro</strong> — the easiest way to search properties, submit offers, and stay connected with your real estate agent.</p>
$mlsLine$contactLine$brokerageLine
<div style="text-align:center;margin:32px 0;">
<a href="$signUpUrl" style="background:#1a73e8;color:#fff;padding:14px 32px;border-radius:8px;text-decoration:none;font-weight:bold;">Get Started</a>
</div>
<p style="color:#999;font-size:12px;">If the button doesn't work, copy this link: $signUpUrl</p>
</td></tr>
<tr><td style="background:#f8f8f8;padding:16px;text-align:center;color:#999;font-size:12px;">
© PartnerPro. All rights reserved.
</td></tr></table></body></html>''';
  }

  static String invitationSms({
    required String firstName,
    required String shortLink,
    required String agentName,
    required bool isBuyer,
  }) {
    return 'Hi $firstName! $agentName has invited you to PartnerPro. Sign up here: $shortLink';
  }
}
