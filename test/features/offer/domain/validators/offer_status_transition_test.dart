import 'package:flutter_test/flutter_test.dart';

import 'package:partner_pro/backend/schema/enums/enums.dart';
import 'package:partner_pro/core/error/failures.dart';
import 'package:partner_pro/features/offer/domain/validators/offer_status_transition.dart';

void main() {
  group('OfferStatusTransition', () {
    const buyerId = 'buyer123';
    const sellerId = 'seller456';
    const agentId = 'agent789';

    group('validateTransition', () {
      test('allows Draft → Pending with valid data and buyer', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Draft,
          newStatus: Status.Pending,
          userId: buyerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
          offerData: {
            'buyerId': buyerId,
            'sellerId': sellerId,
            'propertyId': 'prop123',
            'purchasePrice': 300000,
          },
        );

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (status) => expect(status, Status.Pending),
        );
      });

      test('allows Draft → Pending with agent as submitter', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Draft,
          newStatus: Status.Pending,
          userId: agentId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
          offerData: {
            'buyerId': buyerId,
            'sellerId': sellerId,
            'propertyId': 'prop123',
            'purchasePrice': 300000,
          },
        );

        expect(result.isRight(), true);
      });

      test('rejects Draft → Pending with missing required fields', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Draft,
          newStatus: Status.Pending,
          userId: buyerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
          offerData: {
            'buyerId': buyerId,
            // Missing sellerId, propertyId, purchasePrice
          },
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Missing required fields'));
          },
          (status) => fail('Should fail validation'),
        );
      });

      test('rejects Draft → Pending from unauthorized user', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Draft,
          newStatus: Status.Pending,
          userId: 'unauthorized_user',
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
          offerData: {
            'buyerId': buyerId,
            'sellerId': sellerId,
            'propertyId': 'prop123',
            'purchasePrice': 300000,
          },
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<AuthFailure>());
            expect(failure.message, contains('Only buyer or their agent'));
          },
          (status) => fail('Should fail authorization'),
        );
      });

      test('allows Pending → Accepted with seller', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Pending,
          newStatus: Status.Accepted,
          userId: sellerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (status) => expect(status, Status.Accepted),
        );
      });

      test('allows Pending → Accepted with agent', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Pending,
          newStatus: Status.Accepted,
          userId: agentId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isRight(), true);
      });

      test('rejects Pending → Accepted from buyer', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Pending,
          newStatus: Status.Accepted,
          userId: buyerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<AuthFailure>());
            expect(failure.message, contains('Only seller or their agent'));
          },
          (status) => fail('Should fail authorization'),
        );
      });

      test('allows Pending → Declined from seller', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Pending,
          newStatus: Status.Declined,
          userId: sellerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isRight(), true);
      });

      test('allows Pending → Declined from buyer (withdrawal)', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Pending,
          newStatus: Status.Declined,
          userId: buyerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isRight(), true);
      });

      test('rejects invalid transition Draft → Accepted', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Draft,
          newStatus: Status.Accepted,
          userId: buyerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Invalid status transition'));
          },
          (status) => fail('Should fail validation'),
        );
      });

      test('rejects transition from Accepted (terminal state)', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Accepted,
          newStatus: Status.Pending,
          userId: sellerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Accepted offers are final'));
          },
          (status) => fail('Should fail validation'),
        );
      });

      test('rejects transition from Declined (terminal state)', () {
        final result = OfferStatusTransition.validateTransition(
          currentStatus: Status.Declined,
          newStatus: Status.Pending,
          userId: sellerId,
          sellerId: sellerId,
          buyerId: buyerId,
          agentId: agentId,
        );

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Declined offers are final'));
          },
          (status) => fail('Should fail validation'),
        );
      });

      test('allows same-status updates', () {
        for (final status in [
          Status.Draft,
          Status.Pending,
          Status.Accepted,
          Status.Declined
        ]) {
          final result = OfferStatusTransition.validateTransition(
            currentStatus: status,
            newStatus: status,
            userId: buyerId,
            sellerId: sellerId,
            buyerId: buyerId,
            agentId: agentId,
          );

          expect(result.isRight(), true,
              reason: 'Same-status update should be allowed for $status');
        }
      });
    });

    group('getAvailableTransitions', () {
      test('returns correct transitions for Draft', () {
        final transitions = OfferStatusTransition.getAvailableTransitions(
          Status.Draft,
        );
        expect(transitions, [Status.Pending]);
      });

      test('returns correct transitions for Pending', () {
        final transitions = OfferStatusTransition.getAvailableTransitions(
          Status.Pending,
        );
        expect(transitions, unorderedEquals([Status.Accepted, Status.Declined]));
      });

      test('returns empty list for Accepted (terminal)', () {
        final transitions = OfferStatusTransition.getAvailableTransitions(
          Status.Accepted,
        );
        expect(transitions, isEmpty);
      });

      test('returns empty list for Declined (terminal)', () {
        final transitions = OfferStatusTransition.getAvailableTransitions(
          Status.Declined,
        );
        expect(transitions, isEmpty);
      });
    });

    group('isTerminalStatus', () {
      test('identifies Accepted as terminal', () {
        expect(OfferStatusTransition.isTerminalStatus(Status.Accepted), true);
      });

      test('identifies Declined as terminal', () {
        expect(OfferStatusTransition.isTerminalStatus(Status.Declined), true);
      });

      test('identifies Draft as non-terminal', () {
        expect(OfferStatusTransition.isTerminalStatus(Status.Draft), false);
      });

      test('identifies Pending as non-terminal', () {
        expect(OfferStatusTransition.isTerminalStatus(Status.Pending), false);
      });
    });

    group('getTransitionActionLabel', () {
      test('returns Submit Offer for Draft → Pending', () {
        final label = OfferStatusTransition.getTransitionActionLabel(
          Status.Draft,
          Status.Pending,
        );
        expect(label, 'Submit Offer');
      });

      test('returns Accept Offer for Pending → Accepted', () {
        final label = OfferStatusTransition.getTransitionActionLabel(
          Status.Pending,
          Status.Accepted,
        );
        expect(label, 'Accept Offer');
      });

      test('returns Decline Offer for Pending → Declined', () {
        final label = OfferStatusTransition.getTransitionActionLabel(
          Status.Pending,
          Status.Declined,
        );
        expect(label, 'Decline Offer');
      });

      test('returns generic label for other transitions', () {
        final label = OfferStatusTransition.getTransitionActionLabel(
          Status.Accepted,
          Status.Pending,
        );
        expect(label, 'Update Status');
      });
    });
  });
}
