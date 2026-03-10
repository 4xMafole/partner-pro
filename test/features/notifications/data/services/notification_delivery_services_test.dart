import 'package:flutter_test/flutter_test.dart';
import 'package:partner_pro/features/notifications/data/models/offer_notification_model.dart';
import 'package:partner_pro/features/notifications/data/services/email_notification_service.dart';
import 'package:partner_pro/features/notifications/data/services/sms_notification_service.dart';

import '../../../../mocks/mock_firestore.dart';

void main() {
  group('Notification delivery services', () {
    late OfferNotificationVariables variables;

    setUp(() {
      variables = OfferNotificationVariables(
        offerId: 'offer-1',
        propertyAddress: '123 Main St, Austin, TX',
        buyerName: 'John Buyer',
        sellerName: 'Jane Seller',
        agentName: 'Agent Smith',
        purchasePrice: '450,000',
        closingDate: '2026-04-01',
        offerStatus: 'pending',
        changedFields: const ['purchasePrice'],
        revisionDescription: 'Counter requested',
        actionUrl: 'https://partnerpro.app/offers/offer-1',
        unsubscribeUrl: 'https://partnerpro.app/unsubscribe',
      );
    });

    test(
        'EmailNotificationService uses local fallback when external sender is not configured',
        () async {
      final firestore = createTestFirestore();
      final service = EmailNotificationService(firestore);

      final result = await service.sendOfferEmail(
        offerId: 'offer-1',
        recipientEmail: 'buyer@example.com',
        notificationType: OfferNotificationType.offerCreated,
        recipientRole: NotificationRecipientRole.buyer,
        variables: variables,
      );

      expect(result, isTrue);
    });

    test('EmailNotificationService uses configured external sender', () async {
      final firestore = createTestFirestore();
      final service = EmailNotificationService(firestore);

      var called = false;
      service.configureExternalEmailSender((content) async {
        called = true;
        expect(content.to, 'buyer@example.com');
        return true;
      });

      final result = await service.sendOfferEmail(
        offerId: 'offer-1',
        recipientEmail: 'buyer@example.com',
        notificationType: OfferNotificationType.offerSubmitted,
        recipientRole: NotificationRecipientRole.agent,
        variables: variables,
      );

      expect(called, isTrue);
      expect(result, isTrue);
    });

    test('SMSNotificationService rejects invalid phone number', () async {
      final firestore = createTestFirestore();
      final service = SMSNotificationService(firestore);

      final result = await service.sendOfferStatusSMS(
        offerId: 'offer-1',
        recipientPhone: 'bad-phone',
        notificationType: OfferNotificationType.offerSubmitted,
        variables: variables,
      );

      expect(result, isFalse);
    });

    test('SMSNotificationService uses configured external sender', () async {
      final firestore = createTestFirestore();
      final service = SMSNotificationService(firestore);

      var called = false;
      service.configureExternalSmsSender((content) async {
        called = true;
        expect(content.to, '+15551234567');
        return true;
      });

      final result = await service.sendOfferStatusSMS(
        offerId: 'offer-1',
        recipientPhone: '+15551234567',
        notificationType: OfferNotificationType.revisionMade,
        variables: variables,
      );

      expect(called, isTrue);
      expect(result, isTrue);
    });
  });
}
