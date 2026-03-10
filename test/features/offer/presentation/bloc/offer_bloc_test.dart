import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:partner_pro/core/error/failures.dart';
import 'package:partner_pro/features/offer/data/models/offer_model.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_repository.dart';
import 'package:partner_pro/features/offer/presentation/bloc/offer_bloc.dart';

class MockOfferRepository extends Mock implements OfferRepository {}

void main() {
  late MockOfferRepository repository;
  late OfferBloc bloc;

  setUp(() {
    repository = MockOfferRepository();
    bloc = OfferBloc(repository);
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
