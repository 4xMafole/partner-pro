import 'package:flutter_test/flutter_test.dart';
import 'package:partner_pro/features/notifications/data/models/offer_notification_model.dart';
import 'package:partner_pro/features/notifications/data/services/email_template_provider.dart';

void main() {
  group('EmailTemplateProvider', () {
    final variables = OfferNotificationVariables(
      offerId: 'offer-1',
      propertyAddress: '123 Main St, Austin, TX',
      buyerName: 'John Buyer',
      sellerName: 'Jane Seller',
      agentName: 'Agent Smith',
      purchasePrice: '450,000',
      closingDate: '2026-04-01',
      offerStatus: 'pending',
      changedFields: const ['purchasePrice', 'closingDate'],
      revisionDescription: 'Please update closing timeline',
      actionUrl: 'https://partnerpro.app/offers/offer-1',
      unsubscribeUrl: 'https://partnerpro.app/unsubscribe',
    );

    for (final type in OfferNotificationType.values) {
      test('returns valid content for ${type.name}', () {
        final content = EmailTemplateProvider.getEmailContent(
          type: type,
          recipientRole: NotificationRecipientRole.buyer,
          variables: variables,
        );

        expect(content.subject.trim().isNotEmpty, isTrue);
        expect(content.htmlBody.contains('PartnerPro'), isTrue);
        expect(content.plainTextBody.contains('PartnerPro'), isTrue);
      });
    }
  });
}
