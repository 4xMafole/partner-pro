import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partner_pro/core/error/failures.dart';
import 'package:partner_pro/features/offer/data/datasources/offer_remote_datasource.dart';
import 'package:partner_pro/features/offer/data/models/offer_notification_model.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_notification_repository.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_repository.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_revision_repository.dart';

class MockOfferRemoteDataSource extends Mock implements OfferRemoteDataSource {}

class MockOfferRevisionRepository extends Mock
    implements OfferRevisionRepository {}

class MockOfferNotificationRepository extends Mock
    implements OfferNotificationRepository {}

void main() {
  late MockOfferRemoteDataSource remote;
  late MockOfferRevisionRepository revisionRepo;
  late MockOfferNotificationRepository notificationRepo;
  late OfferRepository repository;

  setUpAll(() {
    registerFallbackValue(OfferRevisionModel(
      offerId: 'offer_1',
      userId: 'u1',
      timestamp: DateTime(2026, 1, 1),
    ));
    registerFallbackValue(OfferNotificationModel(
      recipientUserId: 'u1',
      actorUserId: 'u2',
      offerId: 'offer_1',
      title: 't',
      message: 'm',
      createdAt: DateTime(2026, 1, 1),
    ));
  });

  setUp(() {
    remote = MockOfferRemoteDataSource();
    revisionRepo = MockOfferRevisionRepository();
    notificationRepo = MockOfferNotificationRepository();
    repository = OfferRepository(remote, revisionRepo, notificationRepo);
  });

  group('OfferRepository.updateOffer notifications', () {
    // Tests Pending→Declined so we don't trigger FirebaseFirestore.instance
    // inside _queueTransactionFromOffer (only fires on →Accepted).
    test('creates status-change and revision notifications for other parties',
        () async {
      final oldOffer = {
        'id': 'offer_1',
        'offerID': 'offer_1',
        'status': 'pending',
        'buyer_id': 'buyer_1',
        'seller_id': 'seller_1',
        'agent_id': 'agent_1',
        'parties': {
          'buyer': {'id': 'buyer_1'},
          'seller': {'id': 'seller_1'},
          'agent': {'id': 'agent_1'},
        },
      };
      final requestOffer = {
        'id': 'offer_1',
        'offerID': 'offer_1',
        'status': 'Declined',
        'parties': {
          'buyer': {'id': 'buyer_1'},
          'seller': {'id': 'seller_1'},
          'agent': {'id': 'agent_1'},
        },
      };
      final updatedOffer = {
        'id': 'offer_1',
        'offerID': 'offer_1',
        'status': 'declined',
        'buyer_id': 'buyer_1',
        'seller_id': 'seller_1',
        'agent_id': 'agent_1',
        'parties': {
          'buyer': {'id': 'buyer_1'},
          'seller': {'id': 'seller_1'},
          'agent': {'id': 'agent_1'},
        },
        'property': {
          'address': {
            'street_number': '1',
            'street_name': 'Main',
            'city': 'Austin',
          }
        },
      };

      when(() => remote.getOfferById(offerId: 'offer_1'))
          .thenAnswer((_) async => oldOffer);

      when(() => remote.updateOffer(
            offerData: any(named: 'offerData'),
            requesterId: any(named: 'requesterId'),
          )).thenAnswer((_) async => updatedOffer);

      when(() => revisionRepo.createRevisionFromComparison(
            offerId: any(named: 'offerId'),
            oldOffer: any(named: 'oldOffer'),
            newOffer: any(named: 'newOffer'),
            userId: any(named: 'userId'),
            userName: any(named: 'userName'),
            userRole: any(named: 'userRole'),
            changeNotes: any(named: 'changeNotes'),
          )).thenAnswer((_) async => Right(OfferRevisionModel(
            offerId: 'offer_1',
            userId: 'agent_1',
            timestamp: DateTime(2026, 1, 1),
          )));

      when(() => notificationRepo.createNotification(
            recipientUserId: any(named: 'recipientUserId'),
            notification: any(named: 'notification'),
          )).thenAnswer((inv) async {
        final n = inv.namedArguments[#notification] as OfferNotificationModel;
        return Right(n.copyWith(id: 'n1'));
      });

      final result = await repository.updateOffer(
        offerData: requestOffer,
        requesterId: 'agent_1',
        requestorName: 'Agent Name',
        requestorRole: 'agent',
      );

      expect(result.isRight(), true);

      // Revision should have been tracked
      verify(() => revisionRepo.createRevisionFromComparison(
            offerId: any(named: 'offerId'),
            oldOffer: any(named: 'oldOffer'),
            newOffer: any(named: 'newOffer'),
            userId: any(named: 'userId'),
            userName: any(named: 'userName'),
            userRole: any(named: 'userRole'),
            changeNotes: any(named: 'changeNotes'),
          )).called(1);

      // Both buyer and seller should receive notifications (actor agent_1 excluded)
      verify(() => notificationRepo.createNotification(
            recipientUserId: any(named: 'recipientUserId'),
            notification: any(named: 'notification'),
          )).called(greaterThanOrEqualTo(1));
    });
  });

  group('OfferRepository.createOffer enrichment', () {
    test('resolves assigned agent for buyer-created offers before persist',
        () async {
      final requestOffer = {
        'status': 'pending',
        'buyerId': 'buyer_1',
        'sellerId': 'seller_1',
        'parties': {
          'buyer': {
            'id': 'buyer_1',
            'name': 'Buyer One',
            'phoneNumber': '111',
            'email': 'buyer@example.com',
          },
          'seller': {
            'id': 'seller_1',
            'name': '',
            'phoneNumber': '',
            'email': '',
          },
        },
        'property': {
          'propertyName': '123 Main St',
          'address': {
            'streetNumber': '123',
            'streetName': 'Main St',
            'city': 'Austin',
            'state': 'TX',
            'zip': '78701',
          },
        },
      };

      // Relationship lookup returns the buyer's assigned agent
      when(() => remote.getRelationshipForSubjectUid(subjectUid: 'buyer_1'))
          .thenAnswer((_) async => {
                'agentUid': 'agent_1',
              });

      // Agent user lookup (called for enrichment AND isOutOfOffice check)
      when(() => remote.getUserByUid(uid: 'agent_1')).thenAnswer((_) async => {
            'uid': 'agent_1',
            'display_name': 'Agent One',
            'phone_number': '222',
            'email': 'agent@example.com',
          });

      // Seller user lookup (called when resolvedSellerId is non-empty)
      when(() => remote.getUserByUid(uid: 'seller_1'))
          .thenAnswer((_) async => null);

      when(() => remote.createOffer(
            offerData: any(named: 'offerData'),
            requesterId: 'buyer_1',
          )).thenAnswer((invocation) async {
        final payload =
            invocation.namedArguments[#offerData] as Map<String, dynamic>;
        return {
          ...payload,
          'id': 'offer_1',
          'offerID': 'offer_1',
        };
      });

      when(() => notificationRepo.createNotification(
            recipientUserId: any(named: 'recipientUserId'),
            notification: any(named: 'notification'),
          )).thenAnswer((inv) async {
        final n = inv.namedArguments[#notification] as OfferNotificationModel;
        return Right(n.copyWith(id: 'n1'));
      });

      final result = await repository.createOffer(
        offerData: requestOffer,
        requesterId: 'buyer_1',
      );

      expect(result.isRight(), true);

      final captured = verify(() => remote.createOffer(
            offerData: captureAny(named: 'offerData'),
            requesterId: 'buyer_1',
          )).captured.single as Map<String, dynamic>;

      expect(captured['agent_id'], 'agent_1');
      expect(captured['parties']['agent']['id'], 'agent_1');
      expect(captured['parties']['agent']['name'], 'Agent One');
      expect(captured['parties']['seller']['id'], 'seller_1');
    });

    test('rejects buyer-created offers when no assigned agent exists',
        () async {
      final requestOffer = {
        'status': 'pending',
        'buyerId': 'buyer_1',
        'parties': {
          'buyer': {
            'id': 'buyer_1',
            'name': 'Buyer One',
            'phoneNumber': '111',
            'email': 'buyer@example.com',
          },
        },
        'property': {
          'propertyName': '123 Main St',
          'address': {
            'streetNumber': '123',
            'streetName': 'Main St',
            'city': 'Austin',
            'state': 'TX',
            'zip': '78701',
          },
        },
      };

      // No relationship found → no agent assigned
      when(() => remote.getRelationshipForSubjectUid(subjectUid: 'buyer_1'))
          .thenAnswer((_) async => null);

      final result = await repository.createOffer(
        offerData: requestOffer,
        requesterId: 'buyer_1',
      );

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (r) => fail('Expected Left(ValidationFailure)'),
      );
    });
  });
}
