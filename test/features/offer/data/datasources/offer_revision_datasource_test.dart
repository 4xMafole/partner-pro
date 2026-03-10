import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:partner_pro/features/offer/data/datasources/offer_revision_datasource.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late OfferRevisionDataSource datasource;

  const offerId = 'offer_123';

  OfferRevisionModel buildRevision({
    required String userId,
    OfferRevisionType type = OfferRevisionType.modified,
    DateTime? timestamp,
  }) {
    return OfferRevisionModel(
      offerId: offerId,
      userId: userId,
      userName: 'Test User',
      userRole: 'agent',
      revisionType: type,
      timestamp: timestamp ?? DateTime(2026, 3, 10, 10),
      fieldChanges: const [
        FieldChange(
          fieldName: 'purchasePrice',
          fieldLabel: 'Purchase Price',
          oldValue: 100000,
          newValue: 110000,
          fieldType: 'number',
        ),
      ],
      changeSummary: 'Purchase Price changed',
    );
  }

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = OfferRevisionDataSource(firestore);
  });

  group('OfferRevisionDataSource', () {
    test('createRevision stores revision with generated id', () async {
      final created = await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );

      expect(created.id, isNotEmpty);
      expect(created.offerId, offerId);
      expect(created.revisionNumber, 1);
    });

    test('createRevision increments revision number', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );

      final second = await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u2'),
      );

      expect(second.revisionNumber, 2);
    });

    test('getOfferRevisions returns latest first and supports limit', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u2'),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u3'),
      );

      final all = await datasource.getOfferRevisions(offerId: offerId);
      final limited = await datasource.getOfferRevisions(offerId: offerId, limit: 2);

      expect(all.length, 3);
      expect(all.first.revisionNumber, 3);
      expect(all[1].revisionNumber, 2);
      expect(limited.length, 2);
    });

    test('getRevisionById returns record and null when missing', () async {
      final created = await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );

      final found = await datasource.getRevisionById(
        offerId: offerId,
        revisionId: created.id,
      );
      final missing = await datasource.getRevisionById(
        offerId: offerId,
        revisionId: 'missing',
      );

      expect(found, isNotNull);
      expect(found!.id, created.id);
      expect(missing, isNull);
    });

    test('getRevisionsByUser filters by user', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u2'),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );

      final result = await datasource.getRevisionsByUser(
        offerId: offerId,
        userId: 'u1',
      );

      expect(result.length, 2);
      expect(result.every((r) => r.userId == 'u1'), isTrue);
    });

    test('getRevisionsByType filters by revision type', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1', type: OfferRevisionType.modified),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1', type: OfferRevisionType.statusChanged),
      );

      final result = await datasource.getRevisionsByType(
        offerId: offerId,
        revisionType: OfferRevisionType.statusChanged,
      );

      expect(result.length, 1);
      expect(result.first.revisionType, OfferRevisionType.statusChanged);
    });

    test('getRevisionCount and getLatestRevision reflect data', () async {
      expect(await datasource.getRevisionCount(offerId: offerId), 0);
      expect(await datasource.getLatestRevision(offerId: offerId), isNull);

      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(
          userId: 'u1',
          timestamp: DateTime(2026, 3, 10, 8),
        ),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(
          userId: 'u2',
          timestamp: DateTime(2026, 3, 10, 12),
        ),
      );

      final count = await datasource.getRevisionCount(offerId: offerId);
      final latest = await datasource.getLatestRevision(offerId: offerId);

      expect(count, 2);
      expect(latest, isNotNull);
      expect(latest!.userId, 'u2');
    });

    test('streamOfferRevisions emits records', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );

      final firstEmission = await datasource.streamOfferRevisions(offerId: offerId).first;
      expect(firstEmission.length, 1);
      expect(firstEmission.first.userId, 'u1');
    });

    test('deleteAllRevisions removes all documents', () async {
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u1'),
      );
      await datasource.createRevision(
        offerId: offerId,
        revision: buildRevision(userId: 'u2'),
      );

      await datasource.deleteAllRevisions(offerId: offerId);

      final count = await datasource.getRevisionCount(offerId: offerId);
      expect(count, 0);
    });
  });
}
