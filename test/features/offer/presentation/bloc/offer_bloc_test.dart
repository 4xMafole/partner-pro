import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:partner_pro/core/enums/app_enums.dart';
import 'package:partner_pro/core/error/failures.dart';
import 'package:partner_pro/features/offer/data/models/offer_model.dart';
import 'package:partner_pro/features/offer/data/models/offer_notification_model.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';
import 'package:partner_pro/features/property/data/models/property_model.dart';
import 'package:partner_pro/features/notifications/data/services/notification_service.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_notification_repository.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_repository.dart';
import 'package:partner_pro/features/offer/presentation/bloc/offer_bloc.dart';

class MockOfferRepository extends Mock implements OfferRepository {}

class MockOfferNotificationRepository extends Mock
    implements OfferNotificationRepository {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockOfferRepository repository;
  late MockOfferNotificationRepository notificationRepository;
  late MockNotificationService notificationService;
  late OfferBloc bloc;

  setUp(() {
    repository = MockOfferRepository();
    notificationRepository = MockOfferNotificationRepository();
    notificationService = MockNotificationService();
    bloc = OfferBloc(repository, notificationRepository, notificationService);
  });

  tearDown(() {
    bloc.close();
  });

  group('OfferBloc CompareOffers', () {
    blocTest<OfferBloc, OfferState>(
      'updates hasChanges and changedFields from repository compare logic',
      build: () {
        when(() => repository.compareOffers(any(), any())).thenReturn(true);
        when(() => repository.getChangedFields(any(), any()))
            .thenReturn(['purchase_price', 'status']);
        return bloc;
      },
      act: (b) => b.add(
        const CompareOffers(
          newOffer: {'status': 'Accepted'},
          oldOffer: {'status': 'Pending'},
        ),
      ),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.hasChanges, 'hasChanges', true)
            .having((s) => s.changedFields, 'changedFields',
                ['purchase_price', 'status']),
      ],
      verify: (_) {
        verify(() => repository.compareOffers(any(), any())).called(1);
        verify(() => repository.getChangedFields(any(), any())).called(1);
      },
    );
  });

  group('OfferBloc LoadOfferRevisions', () {
    final revision = OfferRevisionModel(
      offerId: 'offer_1',
      userId: 'user_1',
      timestamp: DateTime(2026, 1, 1),
      revisionNumber: 2,
      changeSummary: 'Status changed',
    );

    blocTest<OfferBloc, OfferState>(
      'loads revisions successfully',
      build: () {
        when(() => repository.getOfferRevisions(offerId: 'offer_1', limit: 20))
            .thenAnswer((_) async => Right([revision]));
        return bloc;
      },
      act: (b) =>
          b.add(const LoadOfferRevisions(offerId: 'offer_1', limit: 20)),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.revisions.length, 'revisions length', 1)
            .having(
                (s) => s.revisions.first.revisionNumber, 'revision number', 2),
      ],
      verify: (_) {
        verify(() =>
                repository.getOfferRevisions(offerId: 'offer_1', limit: 20))
            .called(1);
      },
    );

    blocTest<OfferBloc, OfferState>(
      'sets error when loading revisions fails',
      build: () {
        when(() => repository.getOfferRevisions(offerId: 'offer_1', limit: 20))
            .thenAnswer(
          (_) async => const Left(ServerFailure(message: 'fetch failed')),
        );
        return bloc;
      },
      act: (b) =>
          b.add(const LoadOfferRevisions(offerId: 'offer_1', limit: 20)),
      expect: () => [
        isA<OfferState>().having((s) => s.error, 'error', 'fetch failed'),
      ],
    );
  });

  group('OfferBloc Draft', () {
    blocTest<OfferBloc, OfferState>(
      'merges draft values',
      build: () => bloc,
      seed: () => const OfferState(currentDraft: {'loanType': 'FHA'}),
      act: (b) =>
          b.add(const UpdateOfferDraft(draftData: {'loanAmount': 120000})),
      expect: () => [
        isA<OfferState>().having(
          (s) => s.currentDraft,
          'currentDraft',
          {'loanType': 'FHA', 'loanAmount': 120000},
        ),
      ],
    );
  });

  group('OfferBloc ClearOfferDraft', () {
    blocTest<OfferBloc, OfferState>(
      'clears draft and comparison flags',
      build: () => bloc,
      seed: () => const OfferState(
        currentDraft: {'x': 1},
        hasChanges: true,
        changedFields: ['status'],
      ),
      act: (b) => b.add(ClearOfferDraft()),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.currentDraft, 'currentDraft', const {}).having(
                (s) => s.hasChanges, 'hasChanges', false),
      ],
    );
  });

  group('OfferBloc Notifications', () {
    final notification = OfferNotificationModel(
      id: 'n1',
      recipientUserId: 'u1',
      actorUserId: 'u2',
      offerId: 'offer_1',
      title: 'Offer Updated',
      message: 'The offer status changed to pending.',
      createdAt: DateTime(2026, 1, 1),
    );

    blocTest<OfferBloc, OfferState>(
      'loads notifications and unread count',
      build: () {
        when(() => notificationRepository.getUserNotifications(
              userId: 'u1',
              unreadOnly: null,
              limit: null,
            )).thenAnswer((_) async => Right([notification]));
        return bloc;
      },
      act: (b) => b.add(const LoadUserNotifications(userId: 'u1')),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.error, 'error', null),
        isA<OfferState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.notifications.length, 'notifications length', 1)
            .having((s) => s.unreadNotificationCount, 'unread count', 1),
      ],
    );

    blocTest<OfferBloc, OfferState>(
      'marks notification as read and updates unread count',
      build: () {
        when(() => notificationRepository.markAsRead(
              userId: 'u1',
              notificationId: 'n1',
            )).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () =>
          OfferState(notifications: [notification], unreadNotificationCount: 1),
      act: (b) => b.add(
          const MarkNotificationAsRead(userId: 'u1', notificationId: 'n1')),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.notifications.first.isRead, 'isRead', true)
            .having((s) => s.unreadNotificationCount, 'unread count', 0),
      ],
    );
  });

  group('OfferBloc WithdrawOffer', () {
    final offer = OfferModel(
      id: 'offer_w1',
      status: OfferStatus.pending,
      agent: const BuyerModel(id: 'agent_1', name: 'Agent Smith'),
      property: const PropertyModel(title: '123 Main St'),
    );

    blocTest<OfferBloc, OfferState>(
      'withdraws offer and notifies agent',
      build: () {
        when(() => repository.updateOffer(
              offerData: any(named: 'offerData'),
              requesterId: 'buyer_1',
              requestorName: 'Jane Doe',
              requestorRole: 'buyer',
              changeNotes: 'Offer withdrawn by buyer',
            )).thenAnswer((_) async => const Right({}));
        when(() => notificationService.createNotification(
              userId: 'agent_1',
              title: any(named: 'title'),
              body: any(named: 'body'),
              type: 'offer',
              data: any(named: 'data'),
            )).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => OfferState(offers: [offer]),
      act: (b) => b.add(const WithdrawOffer(
        offerId: 'offer_w1',
        requesterId: 'buyer_1',
        requesterName: 'Jane Doe',
      )),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true)
            .having((s) => s.error, 'error', null),
        isA<OfferState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.offers.first.status, 'status',
                OfferStatus.declined)
            .having(
                (s) => s.successMessage, 'successMessage', 'Offer withdrawn'),
      ],
    );

    blocTest<OfferBloc, OfferState>(
      'emits error when offer not found',
      build: () => bloc,
      seed: () => const OfferState(offers: []),
      act: (b) => b.add(const WithdrawOffer(
        offerId: 'nonexistent',
        requesterId: 'buyer_1',
        requesterName: 'Jane Doe',
      )),
      expect: () => [
        isA<OfferState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true),
        isA<OfferState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.error, 'error', 'Offer not found'),
      ],
    );
  });

  test('OfferState copyWith keeps revisions by default', () {
    final state = OfferState(
      offers: const [OfferModel(id: 'o1')],
      revisions: [
        OfferRevisionModel(
          offerId: 'o1',
          userId: 'u1',
          timestamp: DateTime(2026, 1, 1),
        )
      ],
    );

    final next = state.copyWith(isLoading: true);
    expect(next.revisions.length, 1);
    expect(next.revisions.first.offerId, 'o1');
  });
}
