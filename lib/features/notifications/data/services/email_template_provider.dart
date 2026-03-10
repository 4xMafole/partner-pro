import '../models/offer_notification_model.dart';

/// Provider for email templates with variable substitution
class EmailTemplateProvider {
  /// Generate email subject and body for offer-related notifications
  static EmailNotificationContent getEmailContent({
    required OfferNotificationType type,
    required NotificationRecipientRole recipientRole,
    required OfferNotificationVariables variables,
  }) {
    switch (type) {
      case OfferNotificationType.offerCreated:
        return _offerCreatedTemplate(recipientRole, variables);
      
      case OfferNotificationType.offerSubmitted:
        return _offerSubmittedTemplate(recipientRole, variables);
      
      case OfferNotificationType.statusChangedAccepted:
        return _offerAcceptedTemplate(recipientRole, variables);
      
      case OfferNotificationType.statusChangedDeclined:
        return _offerDeclinedTemplate(recipientRole, variables);
      
      case OfferNotificationType.revisionRequested:
        return _revisionRequestedTemplate(recipientRole, variables);
      
      case OfferNotificationType.revisionMade:
        return _revisionMadeTemplate(recipientRole, variables);
      
      case OfferNotificationType.offerExpired:
        return _offerExpiredTemplate(recipientRole, variables);
      
      case OfferNotificationType.offerClosed:
        return _offerClosedTemplate(recipientRole, variables);
    }
  }

  // Template 1: Offer Created (Buyer Confirmation)
  static EmailNotificationContent _offerCreatedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = 'Offer Created: ${variables.propertyAddress}';
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Created</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #2563eb; margin-bottom: 20px;">Offer Created Successfully</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Hi ${variables.buyerName ?? 'there'},
    </p>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Your offer for <strong>${variables.propertyAddress}</strong> has been created successfully and is ready for submission.
    </p>
    
    <div style="background-color: #f0f9ff; border-left: 4px solid #2563eb; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #1e40af;">Offer Details</h3>
      <p style="margin: 5px 0;"><strong>Property:</strong> ${variables.propertyAddress}</p>
      <p style="margin: 5px 0;"><strong>Purchase Price:</strong> ${variables.purchasePrice ?? 'N/A'}</p>
      <p style="margin: 5px 0;"><strong>Closing Date:</strong> ${variables.closingDate ?? 'N/A'}</p>
      <p style="margin: 5px 0;"><strong>Status:</strong> ${variables.offerStatus ?? 'Draft'}</p>
    </div>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      You can review and submit your offer by clicking the button below:
    </p>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #2563eb; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Offer
      </a>
    </div>
    
    <p style="font-size: 14px; color: #666; margin-top: 30px;">
      If you have any questions, please contact your agent: ${variables.agentName ?? 'your PartnerPro agent'}.
    </p>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Offer Created Successfully

Hi ${variables.buyerName ?? 'there'},

Your offer for ${variables.propertyAddress} has been created successfully and is ready for submission.

Offer Details:
- Property: ${variables.propertyAddress}
- Purchase Price: ${variables.purchasePrice ?? 'N/A'}
- Closing Date: ${variables.closingDate ?? 'N/A'}
- Status: ${variables.offerStatus ?? 'Draft'}

View your offer: ${variables.actionUrl ?? '#'}

If you have any questions, please contact your agent: ${variables.agentName ?? 'your PartnerPro agent'}.

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '', // Will be set by service
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 2: Offer Submitted (Agent Notification)
  static EmailNotificationContent _offerSubmittedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = 'New Offer Submitted: ${variables.propertyAddress}';
    final recipientName = recipientRole == NotificationRecipientRole.agent
        ? variables.agentName
        : variables.sellerName;

    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Submitted</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2 4px rgba(0,0,0,0.1);">
   <h1 style="color: #16a34a; margin-bottom: 20px;">🎉 New Offer Submitted</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Hi ${recipientName ?? 'there'},
    </p>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      A new offer has been submitted for <strong>${variables.propertyAddress}</strong>.
    </p>
    
    <div style="background-color: #f0fdf4; border-left: 4px solid #16a34a; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #15803d;">Offer Summary</h3>
      <p style="margin: 5px 0;"><strong>Buyer:</strong> ${variables.buyerName ?? 'N/A'}</p>
      <p style="margin: 5px 0;"><strong>Property:</strong> ${variables.propertyAddress}</p>
      <p style="margin: 5px 0;"><strong>Purchase Price:</strong> ${variables.purchasePrice ?? 'N/A'}</p>
      <p style="margin: 5px 0;"><strong>Closing Date:</strong> ${variables.closingDate ?? 'N/A'}</p>
    </div>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Please review the offer details and respond within 48 hours.
    </p>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #16a34a; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        Review Offer
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
New Offer Submitted

Hi ${recipientName ?? 'there'},

A new offer has been submitted for ${variables.propertyAddress}.

Offer Summary:
- Buyer: ${variables.buyerName ?? 'N/A'}
- Property: ${variables.propertyAddress}
- Purchase Price: ${variables.purchasePrice ?? 'N/A'}
- Closing Date: ${variables.closingDate ?? 'N/A'}

Please review the offer details and respond within 48 hours.

Review offer: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 3: Offer Accepted
  static EmailNotificationContent _offerAcceptedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = '✅ Offer Accepted: ${variables.propertyAddress}';
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Accepted</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #16a34a; margin-bottom: 20px;">🎉 Congratulations! Offer Accepted</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Great news! The offer for <strong>${variables.propertyAddress}</strong> has been accepted!
    </p>
    
    <div style="background-color: #f0fdf4; border-left: 4px solid #16a34a; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #15803d;">Next Steps</h3>
      <p style="margin: 5px 0;">1. Review the accepted offer details</p>
      <p style="margin: 5px 0;">2. Coordinate with your title company</p>
      <p style="margin: 5px 0;">3. Schedule the closing date: ${variables.closingDate ?? 'TBD'}</p>
      <p style="margin: 5px 0;">4. Complete all required documentation</p>
    </div>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #16a34a; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Details
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Congratulations! Offer Accepted

Great news! The offer for ${variables.propertyAddress} has been accepted!

Next Steps:
1. Review the accepted offer details
2. Coordinate with your title company
3. Schedule the closing date: ${variables.closingDate ?? 'TBD'}
4. Complete all required documentation

View details: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 4: Offer Declined
  static EmailNotificationContent _offerDeclinedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = 'Offer Status Update: ${variables.propertyAddress}';
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Declined</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #dc2626; margin-bottom: 20px;">Offer Status Update</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      The offer for <strong>${variables.propertyAddress}</strong> has been declined.
    </p>
    
    <div style="background-color: #fef2f2; border-left: 4px solid #dc2626; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #991b1b;">What's Next?</h3>
      <p style="margin: 5px 0;">• Consider submitting a revised offer</p>
      <p style="margin: 5px 0;">• Contact your agent for guidance: ${variables.agentName ?? 'your PartnerPro agent'}</p>
      <p style="margin: 5px 0;">• Explore other available properties</p>
    </div>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #2563eb; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Offer Details
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Offer Status Update

The offer for ${variables.propertyAddress} has been declined.

What's Next?
• Consider submitting a revised offer
• Contact your agent for guidance: ${variables.agentName ?? 'your PartnerPro agent'}
• Explore other available properties

View offer details: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 5: Revision Requested
  static EmailNotificationContent _revisionRequestedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = 'Revision Requested: ${variables.propertyAddress}';
    final changedFieldsList = variables.changedFields?.join(', ') ?? 'N/A';
    
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Revision Requested</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #ea580c; margin-bottom: 20px;">📝 Offer Revision Requested</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      A revision has been requested for the offer on <strong>${variables.propertyAddress}</strong>.
    </p>
    
    <div style="background-color: #fff7ed; border-left: 4px solid #ea580c; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #c2410c;">Requested Changes</h3>
      <p style="margin: 5px 0;"><strong>Fields:</strong> $changedFieldsList</p>
      ${variables.revisionDescription != null ? '<p style="margin: 5px 0;"><strong>Description:</strong> ${variables.revisionDescription}</p>' : ''}
    </div>
    
 <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #ea580c; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        Review & Respond
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Offer Revision Requested

A revision has been requested for the offer on ${variables.propertyAddress}.

Requested Changes:
- Fields: $changedFieldsList
${variables.revisionDescription != null ? '- Description: ${variables.revisionDescription}' : ''}

Review & respond: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 6: Revision Made
  static EmailNotificationContent _revisionMadeTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = 'Offer Revised: ${variables.propertyAddress}';
    final changedFieldsList = variables.changedFields?.join(', ') ?? 'N/A';
    
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Revised</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #2563eb; margin-bottom: 20px;">✏️ Offer Has Been Revised</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      The offer for <strong>${variables.propertyAddress}</strong> has been updated.
    </p>
    
    <div style="background-color: #eff6ff; border-left: 4px solid #2563eb; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #1e40af;">Changes Made</h3>
      <p style="margin: 5px 0;"><strong>Fields Updated:</strong> $changedFieldsList</p>
      ${variables.revisionDescription != null ? '<p style="margin: 5px 0;"><strong>Notes:</strong> ${variables.revisionDescription}</p>' : ''}
    </div>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #2563eb; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Revised Offer
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Offer Has Been Revised

The offer for ${variables.propertyAddress} has been updated.

Changes Made:
- Fields Updated: $changedFieldsList
${variables.revisionDescription != null ? '- Notes: ${variables.revisionDescription}' : ''}

View revised offer: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 7: Offer Expired
  static EmailNotificationContent _offerExpiredTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = '⏰ Offer Expired: ${variables.propertyAddress}';
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Expired</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #9333ea; margin-bottom: 20px;">⏰ Offer Expired</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      The offer for <strong>${variables.propertyAddress}</strong> has expired.
    </p>
    
    <div style="background-color: #faf5ff; border-left: 4px solid #9333ea; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #7e22ce;">Next Steps</h3>
      <p style="margin: 5px 0;">• Consider submitting a new offer</p>
      <p style="margin: 5px 0;">• Contact ${variables.agentName ?? 'your agent'} for guidance</p>
      <p style="margin: 5px 0;">• Review updated property status</p>
    </div>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #9333ea; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Details
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Offer Expired

The offer for ${variables.propertyAddress} has expired.

Next Steps:
• Consider submitting a new offer
• Contact ${variables.agentName ?? 'your agent'} for guidance
• Review updated property status

View details: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }

  // Template 8: Offer Closed/Completed
  static EmailNotificationContent _offerClosedTemplate(
    NotificationRecipientRole recipientRole,
    OfferNotificationVariables variables,
  ) {
    final subject = '🏡 Offer Closed: ${variables.propertyAddress}';
    final htmlBody = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Offer Closed</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #16a34a; margin-bottom: 20px;">🏡 Congratulations! Transaction Complete</h1>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      The transaction for <strong>${variables.propertyAddress}</strong> has been successfully completed!
    </p>
    
    <div style="background-color: #f0fdf4; border-left: 4px solid #16a34a; padding: 15px; margin: 20px 0;">
      <h3 style="margin: 0 0 10px 0; color: #15803d;">Transaction Summary</h3>
      <p style="margin: 5px 0;"><strong>Property:</strong> ${variables.propertyAddress}</p>
      <p style="margin: 5px 0;"><strong>Final Price:</strong> ${variables.purchasePrice ?? 'N/A'}</p>
      <p style="margin: 5px 0;"><strong>Closed Date:</strong> ${variables.closingDate ?? 'N/A'}</p>
    </div>
    
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      Thank you for using PartnerPro! We wish you all the best in your new home.
    </p>
    
    <div style="text-align: center; margin: 30px 0;">
      <a href="${variables.actionUrl ?? '#'}" 
         style="background-color: #16a34a; color: white; padding: 12px 30px; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: bold;">
        View Final Details
      </a>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      <a href="${variables.unsubscribeUrl ?? '#'}" style="color: #999; text-decoration: underline;">Unsubscribe</a> | 
      PartnerPro &copy; 2026
    </p>
  </div>
</body>
</html>
''';

    final plainText = '''
Congratulations! Transaction Complete

The transaction for ${variables.propertyAddress} has been successfully completed!

Transaction Summary:
- Property: ${variables.propertyAddress}
- Final Price: ${variables.purchasePrice ?? 'N/A'}
- Closed Date: ${variables.closingDate ?? 'N/A'}

Thank you for using PartnerPro! We wish you all the best in your new home.

View final details: ${variables.actionUrl ?? '#'}

---
Unsubscribe: ${variables.unsubscribeUrl ?? '#'}
PartnerPro © 2026
''';

    return EmailNotificationContent(
      to: '',
      subject: subject,
      htmlBody: htmlBody,
      plainTextBody: plainText,
      fromName: 'PartnerPro',
      replyTo: null,
      headers: null,
    );
  }
}
