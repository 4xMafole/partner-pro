import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_revision_model.freezed.dart';
part 'offer_revision_model.g.dart';

/// Represents a specific field change within an offer revision
@freezed
class FieldChange with _$FieldChange {
  const factory FieldChange({
    /// Name of the field that changed (e.g., 'purchasePrice', 'closingDate')
    required String fieldName,

    /// Human-readable label for the field (e.g., 'Purchase Price', 'Closing Date')
    required String fieldLabel,

    /// Previous value before the change (JSON-serializable)
    required dynamic oldValue,

    /// New value after the change (JSON-serializable)
    required dynamic newValue,

    /// Type of the field for proper comparison (string, number, date, boolean, object)
    @Default('string') String fieldType,
  }) = _FieldChange;

  factory FieldChange.fromJson(Map<String, dynamic> json) =>
      _$FieldChangeFromJson(json);
}

/// Types of offer revisions
enum OfferRevisionType {
  /// Initial offer creation
  created,

  /// General field modifications
  modified,

  /// Status transition (draft → pending, pending → accepted, etc.)
  statusChanged,

  /// Counter offer submitted
  countered,

  /// Addendum added or modified
  addendumChanged,

  /// Document uploaded or removed
  documentChanged,

  /// Agent approval/rejection
  agentAction,

  /// Offer expired due to timeout
  expired,

  /// Offer closed/withdrawn
  closed,
}

/// Comprehensive audit record for offer changes
@freezed
class OfferRevisionModel with _$OfferRevisionModel {
  const factory OfferRevisionModel({
    /// Unique revision ID (Firestore document ID)
    @Default('') String id,

    /// Offer ID this revision belongs to
    required String offerId,

    /// Revision number (sequential, starts at 1 for creation)
    @Default(1) int revisionNumber,

    /// Type of revision
    @Default(OfferRevisionType.modified) OfferRevisionType revisionType,

    /// User ID who made the change
    required String userId,

    /// User name who made the change (denormalized for display)
    @Default('') String userName,

    /// User role at time of change (buyer, agent, seller)
    @Default('') String userRole,

    /// Timestamp when revision was created
    required DateTime timestamp,

    /// List of specific field changes
    @Default([]) List<FieldChange> fieldChanges,

    /// Previous offer status (for status change tracking)
    String? previousStatus,

    /// New offer status (for status change tracking)
    String? newStatus,

    /// Optional notes or reason for change
    @Default('') String changeNotes,

    /// Human-readable summary of changes (auto-generated)
    @Default('') String changeSummary,

    /// Snapshot of complete offer state at this revision (optional for large offers)
    Map<String, dynamic>? offerSnapshot,

    /// IP address of user making change (for audit)
    @Default('') String ipAddress,

    /// Device information (web, iOS, Android)
    @Default('') String deviceInfo,
  }) = _OfferRevisionModel;

  factory OfferRevisionModel.fromJson(Map<String, dynamic> json) =>
      _$OfferRevisionModelFromJson(json);
}

/// Helper class for comparing offer states and generating revisions
class OfferRevisionHelper {
  /// Compares two offer states and generates FieldChange records
  static List<FieldChange> compareOffers({
    required Map<String, dynamic> oldOffer,
    required Map<String, dynamic> newOffer,
  }) {
    final changes = <FieldChange>[];

    // Map of field names to human-readable labels
    final fieldLabels = <String, String>{
      'purchasePrice': 'Purchase Price',
      'finalPrice': 'Final Price',
      'closingDate': 'Closing Date',
      'downPaymentAmount': 'Down Payment',
      'loanAmount': 'Loan Amount',
      'requestForSellerCredit': 'Seller Credit Request',
      'depositAmount': 'Deposit Amount',
      'optionFee': 'Option Fee',
      'additionalEarnest': 'Additional Earnest',
      'coverageAmount': 'Coverage Amount',
      'status': 'Status',
      'loanType': 'Loan Type',
      'depositType': 'Deposit Type',
      'propertyCondition': 'Property Condition',
      'preApproval': 'Pre-Approval',
      'survey': 'Survey',
      'agentApproved': 'Agent Approved',
    };

    // Track all keys from both maps
    final allKeys = {...oldOffer.keys, ...newOffer.keys};

    for (final key in allKeys) {
      final oldValue = oldOffer[key];
      final newValue = newOffer[key];

      // Skip if values are the same
      if (_areValuesEqual(oldValue, newValue)) continue;

      // Skip internal fields
      if (key.startsWith('_') ||
          key == 'id' ||
          key == 'createdTime' ||
          key == 'updatedAt' ||
          key == 'updated_at' ||
          key == 'created_at' ||
          key == 'createdAt') {
        continue;
      }

      // Determine field type
      final fieldType = _determineFieldType(newValue ?? oldValue);

      changes.add(FieldChange(
        fieldName: key,
        fieldLabel: fieldLabels[key] ?? _humanizeFieldName(key),
        oldValue: oldValue,
        newValue: newValue,
        fieldType: fieldType,
      ));
    }

    return changes;
  }

  /// Generates human-readable summary from field changes
  static String generateChangeSummary(List<FieldChange> changes) {
    if (changes.isEmpty) return 'No changes';
    if (changes.length == 1) {
      final change = changes.first;
      return '${change.fieldLabel} changed';
    }
    return '${changes.length} fields changed';
  }

  /// Compares two values for equality (handles nested objects, lists)
  static bool _areValuesEqual(dynamic a, dynamic b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a is Map && b is Map) {
      return _areMapsEqual(a, b);
    }
    if (a is List && b is List) {
      return _areListsEqual(a, b);
    }
    return false;
  }

  /// Deep comparison for maps
  static bool _areMapsEqual(Map a, Map b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!_areValuesEqual(a[key], b[key])) return false;
    }
    return true;
  }

  /// Deep comparison for lists
  static bool _areListsEqual(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!_areValuesEqual(a[i], b[i])) return false;
    }
    return true;
  }

  /// Determines field type from value
  static String _determineFieldType(dynamic value) {
    if (value == null) return 'string';
    if (value is num) return 'number';
    if (value is bool) return 'boolean';
    if (value is DateTime) return 'date';
    if (value is String && DateTime.tryParse(value) != null) return 'date';
    if (value is Map) return 'object';
    if (value is List) return 'array';
    return 'string';
  }

  /// Converts camelCase field name to human-readable format
  static String _humanizeFieldName(String fieldName) {
    // Insert space before capital letters
    final withSpaces = fieldName.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    // Capitalize first letter
    return withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }
}
