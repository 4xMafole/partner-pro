import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
    test('creates status-change and revision notifications for other parties',
        () async {
      final oldOffer = {
        'id': 'offer_1',
        'status': 'Pending',
      };
      final requestOffer = {
        'id': 'offer_1',
        'status': 'Accepted',
        'parties': {
          'buyer': {'id': 'buyer_1'},
          'seller': {'id': 'seller_1'},
          'agent': {'id': 'agent_1'},
        },
      };
      final updatedOffer = {
        ...requestOffer,
        'property': {
          'address': {'street_number': '1', 'street_name': 'Main', 'city': 'A'}
        }
      };

      when(() => remote.getUserOffers(
            requesterId: 'agent_1',
            propertyId: null,
            buyerId: null,
            sellerId: null,
            status: null,
          )).thenAnswer((_) async => [oldOffer]);

      when(() => remote.updateOffer(
            offerData: requestOffer,
            requesterId: 'agent_1',
          )).thenAnswer((_) async => updatedOffer);

      when(() => revisionRepo.createRevisionFromComparison(
            offerId: 'offer_1',
            oldOffer: oldOffer,
            newOffer: updatedOffer,
            userId: 'agent_1',
            userName: any(named: 'userName'),
            userRole: any(named: 'userRole'),
            changeNotes: any(named: 'changeNotes'),
            revisionType: any(named: 'revisionType'),
            ipAddress: any(named: 'ipAddress'),
            deviceInfo: any(named: 'deviceInfo'),
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
      verify(() => revisionRepo.createRevisionFromComparison(
            offerId: 'offer_1',
            oldOffer: oldOffer,
            newOffer: updatedOffer,
            userId: 'agent_1',
            userName: 'Agent Name',
            userRole: 'agent',
            changeNotes: '',
            revisionType: null,
            ipAddress: null,
            deviceInfo: null,
          )).called(1);

      // Buyer and seller should each receive status + revision notifications.
      verify(() => notificationRepo.createNotification(
            recipientUserId: 'buyer_1',
            notification: any(named: 'notification'),
          )).called(2);
      verify(() => notificationRepo.createNotification(
            recipientUserId: 'seller_1',
            notification: any(named: 'notification'),
          )).called(2);

      // Requester is excluded.
      verifyNever(() => notificationRepo.createNotification(
            recipientUserId: 'agent_1',
            notification: any(named: 'notification'),
          ));
    });
  });
}
