import 'package:dartz/dartz.dart';
import '../../../../backend/schema/enums/enums.dart';
import '../../../../core/error/failures.dart';

/// Validates and enforces offer status transitions with business rules and guards.
///
/// ## Valid State Machine Transitions:
/// ```
/// Draft ─────→ Pending ──┬──→ Accepted
///                        └──→ Declined
/// ```
///
/// ## Guards & Business Rules:
/// - Draft → Pending: Requires minimum offer data (buyer, seller, property, price)
/// - Pending → Accepted: Only seller/agent can accept
/// - Pending → Declined: Seller/agent can decline, buyer can withdraw
/// - Accepted/Declined → *: Terminal states (no further transitions)
/// - Draft → Draft: Allowed (draft edits)
/// - Pending → Pending: Allowed (counter offers update but maintain pending status)
class OfferStatusTransition {
  /// Validates if a status transition is allowed based on business rules.
  ///
  /// Returns:
  /// - Right(newStatus) if transition is valid
  /// - Left(Failure) if transition is invalid with reason
  static Either<Failure, Status> validateTransition({
    required Status currentStatus,
    required Status newStatus,
    required String? userId,
    required String? sellerId,
    required String? buyerId,
    required String? agentId,
    Map<String, dynamic>? offerData,
  }) {
    // Allow same-status updates (edits within the same state)
    if (currentStatus == newStatus) {
      return Right(newStatus);
    }

    // Validate state machine transitions
    final transitionAllowed = _isTransitionAllowed(currentStatus, newStatus);
    if (!transitionAllowed) {
      return Left(ValidationFailure(message:
        'Invalid status transition: ${currentStatus.name} → ${newStatus.name}. '
        '${_getTransitionConstraintMessage(currentStatus)}',
      ));
    }

    // Apply role-based guards
    final roleGuard = _validateRolePermissions(
      currentStatus: currentStatus,
      newStatus: newStatus,
      userId: userId,
      sellerId: sellerId,
      buyerId: buyerId,
      agentId: agentId,
    );
    if (roleGuard.isLeft()) {
      return roleGuard;
    }

    // Apply data validation guards for specific transitions
    final dataGuard = _validateTransitionData(
      currentStatus: currentStatus,
      newStatus: newStatus,
      offerData: offerData,
    );
    if (dataGuard.isLeft()) {
      return dataGuard;
    }

    return Right(newStatus);
  }

  /// Checks if the transition is allowed per the state machine
  static bool _isTransitionAllowed(Status from, Status to) {
    // Define valid transitions as a map
    const validTransitions = {
      Status.Draft: [Status.Pending],
      Status.Pending: [Status.Accepted, Status.Declined],
      Status.Accepted: <Status>[], // Terminal state
      Status.Declined: <Status>[], // Terminal state
    };

    return validTransitions[from]?.contains(to) ?? false;
  }

  /// Validates role-based permissions for the transition
  static Either<Failure, Status> _validateRolePermissions({
    required Status currentStatus,
    required Status newStatus,
    required String? userId,
    required String? sellerId,
    required String? buyerId,
    required String? agentId,
  }) {
    // Draft → Pending: Buyer or agent can submit
    if (currentStatus == Status.Draft && newStatus == Status.Pending) {
      if (userId != buyerId && userId != agentId) {
        return Left(AuthFailure(message:
          'Only buyer or their agent can submit a draft offer.',
        ));
      }
    }

    // Pending → Accepted: Seller or their agent can accept
    if (currentStatus == Status.Pending && newStatus == Status.Accepted) {
      if (userId != sellerId && userId != agentId) {
        return Left(AuthFailure(message:
          'Only seller or their agent can accept an offer.',
        ));
      }
    }

    // Pending → Declined: Seller/agent can decline, buyer can withdraw
    if (currentStatus == Status.Pending && newStatus == Status.Declined) {
      final isAuthorized = userId == sellerId ||
          userId == agentId ||
          userId == buyerId;
      if (!isAuthorized) {
        return Left(AuthFailure(message:
          'Only the buyer, seller, or their agents can decline/withdraw an offer.',
        ));
      }
    }

    return Right(newStatus);
  }

  /// Validates required data for specific transitions
  static Either<Failure, Status> _validateTransitionData({
    required Status currentStatus,
    required Status newStatus,
    Map<String, dynamic>? offerData,
  }) {
    // Draft → Pending: Requires minimum offer data
    if (currentStatus == Status.Draft && newStatus == Status.Pending) {
      if (offerData == null) {
        return Left(ValidationFailure(message: 'Offer data is required to submit.'));
      }

      final missingFields = <String>[];
      if (offerData['buyerId'] == null || offerData['buyerId'] == '') {
        missingFields.add('buyerId');
      }
      if (offerData['sellerId'] == null || offerData['sellerId'] == '') {
        missingFields.add('sellerId');
      }
      if (offerData['propertyId'] == null || offerData['propertyId'] == '') {
        missingFields.add('propertyId');
      }
      if (offerData['purchasePrice'] == null ||
          offerData['purchasePrice'] == 0) {
        missingFields.add('purchasePrice');
      }

      if (missingFields.isNotEmpty) {
        return Left(ValidationFailure(message:
          'Cannot submit offer. Missing required fields: ${missingFields.join(', ')}',
        ));
      }
    }

    return Right(newStatus);
  }

  /// Returns available transitions from the current status
  static List<Status> getAvailableTransitions(Status currentStatus) {
    const validTransitions = {
      Status.Draft: [Status.Pending],
      Status.Pending: [Status.Accepted, Status.Declined],
      Status.Accepted: <Status>[],
      Status.Declined: <Status>[],
    };

    return validTransitions[currentStatus] ?? [];
  }

  /// Returns human-readable constraint message for a status
  static String _getTransitionConstraintMessage(Status status) {
    switch (status) {
      case Status.Draft:
        return 'Draft offers can only transition to Pending when submitted.';
      case Status.Pending:
        return 'Pending offers can only be Accepted or Declined.';
      case Status.Accepted:
        return 'Accepted offers are final and cannot be changed.';
      case Status.Declined:
        return 'Declined offers are final and cannot be changed.';
    }
  }

  /// Checks if status is terminal (no further transitions allowed)
  static bool isTerminalStatus(Status status) {
    return status == Status.Accepted || status == Status.Declined;
  }

  /// Gets user-friendly action label for a transition
  static String getTransitionActionLabel(Status from, Status to) {
    if (from == Status.Draft && to == Status.Pending) {
      return 'Submit Offer';
    }
    if (from == Status.Pending && to == Status.Accepted) {
      return 'Accept Offer';
    }
    if (from == Status.Pending && to == Status.Declined) {
      return 'Decline Offer';
    }
    return 'Update Status';
  }
}
