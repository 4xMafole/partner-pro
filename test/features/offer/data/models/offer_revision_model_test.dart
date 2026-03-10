import 'package:flutter_test/flutter_test.dart';
import 'package:partner_pro/features/offer/data/models/offer_revision_model.dart';

void main() {
  group('FieldChange', () {
    test('should create valid FieldChange', () {
      final fieldChange = FieldChange(
        fieldName: 'purchasePrice',
        fieldLabel: 'Purchase Price',
        oldValue: 500000,
        newValue: 550000,
        fieldType: 'number',
      );

      expect(fieldChange.fieldName, 'purchasePrice');
      expect(fieldChange.fieldLabel, 'Purchase Price');
      expect(fieldChange.oldValue, 500000);
      expect(fieldChange.newValue, 550000);
      expect(fieldChange.fieldType, 'number');
    });

    test('should serialize to JSON correctly', () {
      final fieldChange = FieldChange(
        fieldName: 'status',
        fieldLabel: 'Status',
        oldValue: 'pending',
        newValue: 'accepted',
        fieldType: 'string',
      );

      final json = fieldChange.toJson();

      expect(json['fieldName'], 'status');
      expect(json['fieldLabel'], 'Status');
      expect(json['oldValue'], 'pending');
      expect(json['newValue'], 'accepted');
      expect(json['fieldType'], 'string');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'fieldName': 'closingDate',
        'fieldLabel': 'Closing Date',
        'oldValue': '2026-04-01',
        'newValue': '2026-04-15',
        'fieldType': 'date',
      };

      final fieldChange = FieldChange.fromJson(json);

      expect(fieldChange.fieldName, 'closingDate');
      expect(fieldChange.fieldLabel, 'Closing Date');
      expect(fieldChange.oldValue, '2026-04-01');
      expect(fieldChange.newValue, '2026-04-15');
      expect(fieldChange.fieldType, 'date');
    });
  });

  group('OfferRevisionModel', () {
    test('should create valid revision with minimal data', () {
      final revision = OfferRevisionModel(
        offerId: 'offer123',
        userId: 'user456',
        timestamp: DateTime(2026, 3, 10, 14, 30),
      );

      expect(revision.offerId, 'offer123');
      expect(revision.userId, 'user456');
      expect(revision.timestamp, DateTime(2026, 3, 10, 14, 30));
      expect(revision.revisionNumber, 1);
      expect(revision.revisionType, OfferRevisionType.modified);
      expect(revision.fieldChanges, isEmpty);
    });

    test('should create revision with full data', () {
      final fieldChanges = [
        FieldChange(
          fieldName: 'purchasePrice',
          fieldLabel: 'Purchase Price',
          oldValue: 500000,
          newValue: 550000,
          fieldType: 'number',
        ),
      ];

      final revision = OfferRevisionModel(
        id: 'rev789',
        offerId: 'offer123',
        revisionNumber: 3,
        revisionType: OfferRevisionType.countered,
        userId: 'user456',
        userName: 'John Buyer',
        userRole: 'buyer',
        timestamp: DateTime(2026, 3, 10, 14, 30),
        fieldChanges: fieldChanges,
        previousStatus: 'pending',
        newStatus: 'countered',
        changeNotes: 'Adjusted purchase price',
        changeSummary: 'Purchase Price changed',
        ipAddress: '192.168.1.1',
        deviceInfo: 'iOS 17',
      );

      expect(revision.id, 'rev789');
      expect(revision.offerId, 'offer123');
      expect(revision.revisionNumber, 3);
      expect(revision.revisionType, OfferRevisionType.countered);
      expect(revision.userId, 'user456');
      expect(revision.userName, 'John Buyer');
      expect(revision.userRole, 'buyer');
      expect(revision.fieldChanges.length, 1);
      expect(revision.previousStatus, 'pending');
      expect(revision.newStatus, 'countered');
      expect(revision.changeNotes, 'Adjusted purchase price');
      expect(revision.changeSummary, 'Purchase Price changed');
    });

    test('should serialize to JSON correctly', () {
      final revision = OfferRevisionModel(
        id: 'rev789',
        offerId: 'offer123',
        userId: 'user456',
        timestamp: DateTime(2026, 3, 10, 14, 30),
        revisionType: OfferRevisionType.statusChanged,
        previousStatus: 'pending',
        newStatus: 'accepted',
      );

      final json = revision.toJson();

      expect(json['id'], 'rev789');
      expect(json['offerId'], 'offer123');
      expect(json['userId'], 'user456');
      expect(json['revisionType'], 'statusChanged');
      expect(json['previousStatus'], 'pending');
      expect(json['newStatus'], 'accepted');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'rev789',
        'offerId': 'offer123',
        'revisionNumber': 2,
        'revisionType': 'modified',
        'userId': 'user456',
        'userName': 'John Buyer',
        'userRole': 'buyer',
        'timestamp': '2026-03-10T14:30:00.000',
        'fieldChanges': [],
        'changeNotes': '',
        'changeSummary': '',
        'ipAddress': '',
        'deviceInfo': '',
      };

      final revision = OfferRevisionModel.fromJson(json);

      expect(revision.id, 'rev789');
      expect(revision.offerId, 'offer123');
      expect(revision.revisionNumber, 2);
      expect(revision.revisionType, OfferRevisionType.modified);
      expect(revision.userId, 'user456');
      expect(revision.userName, 'John Buyer');
      expect(revision.userRole, 'buyer');
    });
  });

  group('OfferRevisionHelper.compareOffers', () {
    test('should detect simple field changes', () {
      final oldOffer = {
        'purchasePrice': 500000,
        'closingDate': '2026-04-01',
        'loanType': 'FHA',
      };

      final newOffer = {
        'purchasePrice': 550000,
        'closingDate': '2026-04-15',
        'loanType': 'FHA',
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      expect(changes.length, 2);
      expect(changes.any((c) => c.fieldName == 'purchasePrice'), isTrue);
      expect(changes.any((c) => c.fieldName == 'closingDate'), isTrue);
    });

    test('should detect status change', () {
      final oldOffer = {'status': 'pending'};
      final newOffer = {'status': 'accepted'};

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      expect(changes.length, 1);
      expect(changes.first.fieldName, 'status');
      expect(changes.first.oldValue, 'pending');
      expect(changes.first.newValue, 'accepted');
    });

    test('should return empty list for identical offers', () {
      final offer = {
        'purchasePrice': 500000,
        'status': 'pending',
        'loanType': 'FHA',
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: offer,
        newOffer: offer,
      );

      expect(changes, isEmpty);
    });

    test('should detect multiple changes', () {
      final oldOffer = {
        'purchasePrice': 500000,
        'downPaymentAmount': 50000,
        'loanType': 'FHA',
        'propertyCondition': 'as-is',
        'preApproval': false,
      };

      final newOffer = {
        'purchasePrice': 550000,
        'downPaymentAmount': 55000,
        'loanType': 'Conventional',
        'propertyCondition': 'inspected',
        'preApproval': true,
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      expect(changes.length, 5);
      expect(changes.any((c) => c.fieldName == 'purchasePrice'), isTrue);
      expect(changes.any((c) => c.fieldName == 'downPaymentAmount'), isTrue);
      expect(changes.any((c) => c.fieldName == 'loanType'), isTrue);
      expect(changes.any((c) => c.fieldName == 'propertyCondition'), isTrue);
      expect(changes.any((c) => c.fieldName == 'preApproval'), isTrue);
    });

    test('should handle null values correctly', () {
      final oldOffer = {'purchasePrice': 500000, 'loanType': null};
      final newOffer = {'purchasePrice': 500000, 'loanType': 'FHA'};

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      expect(changes.length, 1);
      expect(changes.first.fieldName, 'loanType');
      expect(changes.first.oldValue, isNull);
      expect(changes.first.newValue, 'FHA');
    });

    test('should skip internal fields', () {
      final oldOffer = {
        'id': 'offer123',
        'createdTime': '2026-03-10T10:00:00',
        'purchasePrice': 500000,
        '_internal': 'data',
      };

      final newOffer = {
        'id': 'offer123',
        'createdTime': '2026-03-10T14:00:00',
        'purchasePrice': 550000,
        '_internal': 'changed',
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      // Should only detect purchasePrice change, not id, createdTime, or _internal
      expect(changes.length, 1);
      expect(changes.first.fieldName, 'purchasePrice');
    });

    test('should detect nested object changes', () {
      final oldOffer = {
        'buyer': {'name': 'John', 'email': 'john@example.com'},
      };

      final newOffer = {
        'buyer': {'name': 'John', 'email': 'john.new@example.com'},
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      expect(changes.length, 1);
      expect(changes.first.fieldName, 'buyer');
    });

    test('should determine correct field types', () {
      final oldOffer = {
        'purchasePrice': 500000,
        'preApproval': false,
        'closingDate': '2026-04-01',
        'loanType': 'FHA',
      };

      final newOffer = {
        'purchasePrice': 550000,
        'preApproval': true,
        'closingDate': '2026-04-15',
        'loanType': 'Conventional',
      };

      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      final priceChange = changes.firstWhere((c) => c.fieldName == 'purchasePrice');
      expect(priceChange.fieldType, 'number');

      final boolChange = changes.firstWhere((c) => c.fieldName == 'preApproval');
      expect(boolChange.fieldType, 'boolean');

      final dateChange = changes.firstWhere((c) => c.fieldName == 'closingDate');
      expect(dateChange.fieldType, 'date');

      final stringChange = changes.firstWhere((c) => c.fieldName == 'loanType');
      expect(stringChange.fieldType, 'string');
    });
  });

  group('OfferRevisionHelper.generateChangeSummary', () {
    test('should return "No changes" for empty list', () {
      final summary = OfferRevisionHelper.generateChangeSummary([]);
      expect(summary, 'No changes');
    });

    test('should return single field name for one change', () {
      final changes = [
        FieldChange(
          fieldName: 'purchasePrice',
          fieldLabel: 'Purchase Price',
          oldValue: 500000,
          newValue: 550000,
        ),
      ];

      final summary = OfferRevisionHelper.generateChangeSummary(changes);
      expect(summary, 'Purchase Price changed');
    });

    test('should list all fields for 2-3 changes', () {
      final changes = [
        FieldChange(
          fieldName: 'purchasePrice',
          fieldLabel: 'Purchase Price',
          oldValue: 500000,
          newValue: 550000,
        ),
        FieldChange(
          fieldName: 'closingDate',
          fieldLabel: 'Closing Date',
          oldValue: '2026-04-01',
          newValue: '2026-04-15',
        ),
      ];

      final summary = OfferRevisionHelper.generateChangeSummary(changes);
      expect(summary, 'Purchase Price, Closing Date changed');
    });

    test('should return count for many changes', () {
      final changes = List.generate(
        5,
        (i) => FieldChange(
          fieldName: 'field$i',
          fieldLabel: 'Field $i',
          oldValue: 'old',
          newValue: 'new',
        ),
      );

      final summary = OfferRevisionHelper.generateChangeSummary(changes);
      expect(summary, '5 fields changed');
    });
  });

  group('OfferRevisionHelper field label generation', () {
    test('should auto-generate human-readable labels for camelCase fields', () {
      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: {'purchasePrice': 500000},
        newOffer: {'purchasePrice': 550000},
      );

      expect(changes.first.fieldLabel, 'Purchase Price');
    });

    test('should handle multiple capitals in field names', () {
      final changes = OfferRevisionHelper.compareOffers(
        oldOffer: {'requestForSellerCredit': 5000},
        newOffer: {'requestForSellerCredit': 10000},
      );

      expect(changes.first.fieldLabel, contains('Request'));
      expect(changes.first.fieldLabel, contains('Seller'));
      expect(changes.first.fieldLabel, contains('Credit'));
    });
  });

  group('OfferRevisionType enum', () {
    test('should have all expected types', () {
      expect(OfferRevisionType.values, containsAll([
        OfferRevisionType.created,
        OfferRevisionType.modified,
        OfferRevisionType.statusChanged,
        OfferRevisionType.countered,
        OfferRevisionType.addendumChanged,
        OfferRevisionType.documentChanged,
        OfferRevisionType.agentAction,
        OfferRevisionType.expired,
        OfferRevisionType.closed,
      ]));
    });
  });
}
