import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partner_pro/core/error/failures.dart';
import 'package:partner_pro/features/offer/data/datasources/offer_revision_datasource.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';
import 'package:partner_pro/features/offer/data/repositories/offer_revision_repository.dart';

class MockOfferRevisionDataSource extends Mock
    implements OfferRevisionDataSource {}

void main() {
  late MockOfferRevisionDataSource mockDatasource;
  late OfferRevisionRepository repository;

  setUpAll(() {
    registerFallbackValue(OfferRevisionModel(
      offerId: 'test',
      userId: 'test',
      timestamp: DateTime.now(),
    ));
    registerFallbackValue(OfferRevisionType.modified);
  });

  setUp(() {
    mockDatasource = MockOfferRevisionDataSource();
    repository = OfferRevisionRepository(mockDatasource);
  });

  group('OfferRevisionRepository.createRevision', () {
    test('should return revision on success', () async {
      final revision = OfferRevisionModel(
        offerId: 'offer123',
        userId: 'user456',
        timestamp: DateTime(2026, 3, 10),
      );

      final expected = revision.copyWith(id: 'rev789', revisionNumber: 1);

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((_) async => expected);

      final result = await repository.createRevision(
        offerId: 'offer123',
        revision: revision,
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => throw Exception()), expected);
    });

    test('should return failure on error', () async {
      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenThrow(Exception('Create failed'));

      final result = await repository.createRevision(
        offerId: 'offer123',
        revision: OfferRevisionModel(
          offerId: 'offer123',
          userId: 'user456',
          timestamp: DateTime.now(),
        ),
      );

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
    });
  });

  group('OfferRevisionRepository.getOfferRevisions', () {
    test('should return list of revisions', () async {
      final revisions = [
        OfferRevisionModel(
          id: 'rev1',
          offerId: 'offer123',
          userId: 'user1',
          timestamp: DateTime(2026, 3, 10),
          revisionNumber: 1,
        ),
        OfferRevisionModel(
          id: 'rev2',
          offerId: 'offer123',
          userId: 'user2',
          timestamp: DateTime(2026, 3, 11),
          revisionNumber: 2,
        ),
      ];

      when(() => mockDatasource.getOfferRevisions(
            offerId: any(named: 'offerId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => revisions);

      final result = await repository.getOfferRevisions(offerId: 'offer123');

      expect(result, isA<Right>());
      final list = result.getOrElse(() => []);
      expect(list.length, 2);
      expect(list[0].id, 'rev1');
      expect(list[1].id, 'rev2');
    });

    test('should pass limit parameter', () async {
      when(() => mockDatasource.getOfferRevisions(
            offerId: any(named: 'offerId'),
            limit: 10,
          )).thenAnswer((_) async => []);

      await repository.getOfferRevisions(offerId: 'offer123', limit: 10);

      verify(() => mockDatasource.getOfferRevisions(
            offerId: 'offer123',
            limit: 10,
          )).called(1);
    });
  });

  group('OfferRevisionRepository.getRevisionById', () {
    test('should return revision when found', () async {
      final revision = OfferRevisionModel(
        id: 'rev123',
        offerId: 'offer123',
        userId: 'user456',
        timestamp: DateTime(2026, 3, 10),
      );

      when(() => mockDatasource.getRevisionById(
            offerId: any(named: 'offerId'),
            revisionId: any(named: 'revisionId'),
          )).thenAnswer((_) async => revision);

      final result = await repository.getRevisionById(
        offerId: 'offer123',
        revisionId: 'rev123',
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => throw Exception()).id, 'rev123');
    });

    test('should return failure when revision not found', () async {
      when(() => mockDatasource.getRevisionById(
            offerId: any(named: 'offerId'),
            revisionId: any(named: 'revisionId'),
          )).thenAnswer((_) async => null);

      final result = await repository.getRevisionById(
        offerId: 'offer123',
        revisionId: 'nonexistent',
      );

      expect(result, isA<Left>());
      final failure = result.fold((l) => l, (r) => null) as ServerFailure;
      expect(failure.message, contains('not found'));
      expect(failure.code, 404);
    });
  });

  group('OfferRevisionRepository.getRevisionsByUser', () {
    test('should filter revisions by user ID', () async {
      final userRevisions = [
        OfferRevisionModel(
          id: 'rev1',
          offerId: 'offer123',
          userId: 'user456',
          timestamp: DateTime(2026, 3, 10),
        ),
      ];

      when(() => mockDatasource.getRevisionsByUser(
            offerId: any(named: 'offerId'),
            userId: any(named: 'userId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => userRevisions);

      final result = await repository.getRevisionsByUser(
        offerId: 'offer123',
        userId: 'user456',
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).length, 1);
    });
  });

  group('OfferRevisionRepository.getRevisionsByType', () {
    test('should filter revisions by type', () async {
      final statusRevisions = [
        OfferRevisionModel(
          id: 'rev1',
          offerId: 'offer123',
          userId: 'user456',
          timestamp: DateTime(2026, 3, 10),
          revisionType: OfferRevisionType.statusChanged,
        ),
      ];

      when(() => mockDatasource.getRevisionsByType(
            offerId: any(named: 'offerId'),
            revisionType: any(named: 'revisionType'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => statusRevisions);

      final result = await repository.getRevisionsByType(
        offerId: 'offer123',
        revisionType: OfferRevisionType.statusChanged,
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first.revisionType,
          OfferRevisionType.statusChanged);
    });
  });

  group('OfferRevisionRepository.getRevisionCount', () {
    test('should return revision count', () async {
      when(() => mockDatasource.getRevisionCount(
            offerId: any(named: 'offerId'),
          )).thenAnswer((_) async => 5);

      final result = await repository.getRevisionCount(offerId: 'offer123');

      expect(result, isA<Right>());
      expect(result.getOrElse(() => 0), 5);
    });
  });

  group('OfferRevisionRepository.createRevisionFromComparison', () {
    test('should create revision from offer comparison', () async {
      final oldOffer = {
        'purchasePrice': 500000,
        'status': 'pending',
      };

      final newOffer = {
        'purchasePrice': 550000,
        'status': 'pending',
      };

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123', revisionNumber: 1);
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: oldOffer,
        newOffer: newOffer,
        userId: 'user456',
        userName: 'Test User',
        userRole: 'buyer',
      );

      expect(result, isA<Right>());
      final revision = result.getOrElse(() => throw Exception());
      expect(revision.fieldChanges.length, greaterThan(0));
      expect(revision.fieldChanges.any((c) => c.fieldName == 'purchasePrice'),
          isTrue);
    });

    test('should detect status change and set revisionType correctly',
        () async {
      final oldOffer = {'status': 'pending'};
      final newOffer = {'status': 'accepted'};

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123');
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: oldOffer,
        newOffer: newOffer,
        userId: 'user456',
        userName: 'Agent Smith',
        userRole: 'agent',
      );

      final revision = result.getOrElse(() => throw Exception());
      expect(revision.revisionType, OfferRevisionType.statusChanged);
      expect(revision.previousStatus, 'pending');
      expect(revision.newStatus, 'accepted');
    });

    test('should generate change summary automatically', () async {
      final oldOffer = {'purchasePrice': 500000};
      final newOffer = {'purchasePrice': 550000};

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123');
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: oldOffer,
        newOffer: newOffer,
        userId: 'user456',
        userName: 'Test User',
        userRole: 'buyer',
      );

      final revision = result.getOrElse(() => throw Exception());
      expect(revision.changeSummary, isNotEmpty);
      expect(revision.changeSummary, contains('changed'));
    });

    test('should store complete offer snapshot', () async {
      final newOffer = {
        'id': 'offer123',
        'purchasePrice': 550000,
        'status': 'pending',
      };

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123');
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: {},
        newOffer: newOffer,
        userId: 'user456',
        userName: 'Test User',
        userRole: 'buyer',
      );

      final revision = result.getOrElse(() => throw Exception());
      expect(revision.offerSnapshot, isNotNull);
      expect(revision.offerSnapshot!['purchasePrice'], 550000);
    });

    test('should detect counter offer type', () async {
      final oldOffer = {
        'purchasePrice': 500000,
        'counteredCount': 0,
      };
      final newOffer = {
        'purchasePrice': 550000,
        'counteredCount': 1,
      };

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123');
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: oldOffer,
        newOffer: newOffer,
        userId: 'user456',
        userName: 'Agent',
        userRole: 'agent',
      );

      final revision = result.getOrElse(() => throw Exception());
      expect(revision.revisionType, OfferRevisionType.countered);
    });

    test('should detect agent action type', () async {
      final oldOffer = {'agentApproved': false};
      final newOffer = {'agentApproved': true};

      when(() => mockDatasource.createRevision(
            offerId: any(named: 'offerId'),
            revision: any(named: 'revision'),
          )).thenAnswer((invocation) async {
        final revision =
            invocation.namedArguments[#revision] as OfferRevisionModel;
        return revision.copyWith(id: 'rev123');
      });

      final result = await repository.createRevisionFromComparison(
        offerId: 'offer123',
        oldOffer: oldOffer,
        newOffer: newOffer,
        userId: 'agent789',
        userName: 'Agent Smith',
        userRole: 'agent',
      );

      final revision = result.getOrElse(() => throw Exception());
      expect(revision.revisionType, OfferRevisionType.agentAction);
    });
  });

  group('OfferRevisionRepository.streamOfferRevisions', () {
    test('should return stream of revisions', () async {
      final revisions = [
        OfferRevisionModel(
          id: 'rev1',
          offerId: 'offer123',
          userId: 'user1',
          timestamp: DateTime(2026, 3, 10),
        ),
      ];

      when(() => mockDatasource.streamOfferRevisions(
            offerId: any(named: 'offerId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) => Stream.value(revisions));

      final stream = repository.streamOfferRevisions(offerId: 'offer123');
      final result = await stream.first;

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).length, 1);
    });
  });

  group('OfferRevisionRepository.deleteAllRevisions', () {
    test('should delete all revisions successfully', () async {
      when(() => mockDatasource.deleteAllRevisions(
            offerId: any(named: 'offerId'),
          )).thenAnswer((_) async => {});

      final result = await repository.deleteAllRevisions(offerId: 'offer123');

      expect(result, isA<Right>());
      verify(() => mockDatasource.deleteAllRevisions(offerId: 'offer123'))
          .called(1);
    });
  });
}
