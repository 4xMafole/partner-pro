import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../backend/schema/enums/enums.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/validators/offer_status_transition.dart';
import '../datasources/offer_remote_datasource.dart';
import '../models/offer_model.dart';
import '../models/offer_notification_model.dart';
import '../models/offer_revision_model.dart';
import 'offer_notification_repository.dart';
import 'offer_revision_repository.dart';

@lazySingleton
class OfferRepository {
  final OfferRemoteDataSource _remote;
  final OfferRevisionRepository _revisionRepo;
  final OfferNotificationRepository _notificationRepo;

  OfferRepository(this._remote, this._revisionRepo, this._notificationRepo);

  Future<Either<Failure, List<OfferModel>>> getUserOffers({
    required String requesterId,
    String? propertyId,
    String? buyerId,
    String? sellerId,
    String? status,
  }) async {
    try {
      final data = await _remote.getUserOffers(
        requesterId: requesterId,
        propertyId: propertyId,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status,
      );
      return Right(data.map((j) => OfferModel.fromJson(j)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<OfferModel>>> getAgentOffers({
    required String requesterId,
    String? status,
  }) async {
    try {
      final data = await _remote.getAgentOffers(
          requesterId: requesterId, status: status);
      return Right(data.map((j) => OfferModel.fromJson(j)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createOffer({
    required Map<String, dynamic> offerData,
    required String requesterId,
  }) async {
    try {
      final result = await _remote.createOffer(
          offerData: offerData, requesterId: requesterId);

      await _createNotificationsForChange(
        offerBefore: null,
        offerAfter: result,
        actorUserId: requesterId,
        actorName: 'User $requesterId',
        revisionCreated: false,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateOffer({
    required Map<String, dynamic> offerData,
    required String requesterId,
    String requestorName = '',
    String requestorRole = '',
    String changeNotes = '',
    bool trackRevision = true,
  }) async {
    try {
      final offerId =
          offerData['offerID'] as String? ?? offerData['id'] as String? ?? '';

      // Fetch current offer state for comparison if revision tracking is enabled
      Map<String, dynamic>? oldOfferState;
      if (trackRevision && offerId.isNotEmpty) {
        try {
          final currentOffers = await _remote.getUserOffers(
            requesterId: requesterId,
            propertyId: null,
            buyerId: null,
            sellerId: null,
            status: null,
          );
          oldOfferState = currentOffers.firstWhere(
            (o) => o['id'] == offerId,
            orElse: () => <String, dynamic>{},
          );
        } catch (e) {
          // If we can't fetch old state, proceed without revision tracking
          trackRevision = false;
        }
      }

      // Validate status transitions if status is being changed
      if (oldOfferState != null && oldOfferState.isNotEmpty) {
        final oldStatus = _parseStatus(oldOfferState['status']);
        final newStatus = _parseStatus(offerData['status']);

        if (oldStatus != null && newStatus != null && oldStatus != newStatus) {
          // Extract party IDs from the offer data
          final parties = offerData['parties'] as Map<String, dynamic>? ?? {};
          final buyer = parties['buyer'] as Map<String, dynamic>? ?? {};
          final seller = parties['seller'] as Map<String, dynamic>? ?? {};
          final agent = parties['agent'] as Map<String, dynamic>? ?? {};

          final buyerId = buyer['id'] as String?;
          final sellerId = seller['id'] as String?;
          final agentId = agent['id'] as String?;

          // Validate the transition
          final validation = OfferStatusTransition.validateTransition(
            currentStatus: oldStatus,
            newStatus: newStatus,
            userId: requesterId,
            sellerId: sellerId,
            buyerId: buyerId,
            agentId: agentId,
            offerData: offerData,
          );

          if (validation.isLeft()) {
            // Return the failure from validation
            return validation.fold(
              (failure) => Left(failure),
              (status) => Right(<String, dynamic>{}), // Unreachable
            );
          }
        }
      }

      // Update the offer
      final result = await _remote.updateOffer(
        offerData: offerData,
        requesterId: requesterId,
      );

      // Create revision record if tracking is enabled and we have old state
      if (trackRevision && oldOfferState != null && oldOfferState.isNotEmpty) {
        await _revisionRepo.createRevisionFromComparison(
          offerId: offerId,
          oldOffer: oldOfferState,
          newOffer: result,
          userId: requesterId,
          userName: requestorName.isEmpty ? 'User $requesterId' : requestorName,
          userRole: requestorRole.isEmpty ? 'unknown' : requestorRole,
          changeNotes: changeNotes,
        );
      }

      await _createNotificationsForChange(
        offerBefore: oldOfferState,
        offerAfter: result,
        actorUserId: requesterId,
        actorName: requestorName.isEmpty ? 'User $requesterId' : requestorName,
        revisionCreated: trackRevision,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // -- Compare Offers (24 tracked fields) --

  static const _pricingFields = ['list_price', 'purchase_price'];
  static const _financialFields = [
    'loan_type',
    'down_payment_amount',
    'loan_amount',
    'deposit_amount',
    'deposit_type',
    'additional_earnest',
    'option_fee',
    'credit_request',
    'coverage_amount',
  ];
  static const _conditionFields = [
    'property_condition',
    'pre_approval',
    'survey'
  ];
  static const _titleFields = ['company_name', 'choice'];
  static const _contactFields = ['name', 'phone_number', 'email'];
  static const _addressFields = [
    'street_number',
    'street_name',
    'city',
    'state',
    'zip'
  ];

  bool compareOffers(Map<String, dynamic> newO, Map<String, dynamic> oldO) {
    final np = newO['pricing'] as Map<String, dynamic>? ?? {};
    final op = oldO['pricing'] as Map<String, dynamic>? ?? {};
    for (final f in _pricingFields) {
      if (_d(np[f], op[f])) return true;
    }

    final nf = newO['financials'] as Map<String, dynamic>? ?? {};
    final of2 = oldO['financials'] as Map<String, dynamic>? ?? {};
    for (final f in _financialFields) {
      if (_d(nf[f], of2[f])) return true;
    }

    if (_d(newO['closing_date'], oldO['closing_date'])) return true;

    final nc = newO['conditions'] as Map<String, dynamic>? ?? {};
    final oc = oldO['conditions'] as Map<String, dynamic>? ?? {};
    for (final f in _conditionFields) {
      if (_d(nc[f], oc[f])) return true;
    }

    final nt = newO['title_company'] as Map<String, dynamic>? ?? {};
    final ot = oldO['title_company'] as Map<String, dynamic>? ?? {};
    for (final f in _titleFields) {
      if (_d(nt[f], ot[f])) return true;
    }

    for (final role in ['buyer', 'second_buyer', 'agent']) {
      final nParty = (newO['parties'] as Map<String, dynamic>? ?? {})[role]
              as Map<String, dynamic>? ??
          {};
      final oParty = (oldO['parties'] as Map<String, dynamic>? ?? {})[role]
              as Map<String, dynamic>? ??
          {};
      for (final f in _contactFields) {
        if (_d(nParty[f], oParty[f])) return true;
      }
    }

    final na = (newO['property'] as Map<String, dynamic>? ?? {})['address']
            as Map<String, dynamic>? ??
        {};
    final oa = (oldO['property'] as Map<String, dynamic>? ?? {})['address']
            as Map<String, dynamic>? ??
        {};
    for (final f in _addressFields) {
      if (_d(na[f], oa[f])) return true;
    }

    return false;
  }

  List<String> getChangedFields(
      Map<String, dynamic> newO, Map<String, dynamic> oldO) {
    final changed = <String>[];
    final np = newO['pricing'] as Map<String, dynamic>? ?? {};
    final op = oldO['pricing'] as Map<String, dynamic>? ?? {};
    for (final f in _pricingFields) {
      if (_d(np[f], op[f])) changed.add('pricing.$f');
    }

    final nf = newO['financials'] as Map<String, dynamic>? ?? {};
    final of2 = oldO['financials'] as Map<String, dynamic>? ?? {};
    for (final f in _financialFields) {
      if (_d(nf[f], of2[f])) changed.add('financials.$f');
    }

    if (_d(newO['closing_date'], oldO['closing_date']))
      changed.add('closing_date');

    final nc = newO['conditions'] as Map<String, dynamic>? ?? {};
    final oc = oldO['conditions'] as Map<String, dynamic>? ?? {};
    for (final f in _conditionFields) {
      if (_d(nc[f], oc[f])) changed.add('conditions.$f');
    }

    final nt = newO['title_company'] as Map<String, dynamic>? ?? {};
    final ot = oldO['title_company'] as Map<String, dynamic>? ?? {};
    for (final f in _titleFields) {
      if (_d(nt[f], ot[f])) changed.add('title_company.$f');
    }

    for (final role in ['buyer', 'second_buyer', 'agent']) {
      final nParty = (newO['parties'] as Map<String, dynamic>? ?? {})[role]
              as Map<String, dynamic>? ??
          {};
      final oParty = (oldO['parties'] as Map<String, dynamic>? ?? {})[role]
              as Map<String, dynamic>? ??
          {};
      for (final f in _contactFields) {
        if (_d(nParty[f], oParty[f])) changed.add('parties.$role.$f');
      }
    }

    final na = (newO['property'] as Map<String, dynamic>? ?? {})['address']
            as Map<String, dynamic>? ??
        {};
    final oa = (oldO['property'] as Map<String, dynamic>? ?? {})['address']
            as Map<String, dynamic>? ??
        {};
    for (final f in _addressFields) {
      if (_d(na[f], oa[f])) changed.add('address.$f');
    }

    return changed;
  }

  bool _d(dynamic a, dynamic b) {
    if (a == null && b == null) return false;
    return a?.toString() != b?.toString();
  }

  // -- Revision History Access Methods --

  /// Gets all revisions for an offer
  Future<Either<Failure, List<OfferRevisionModel>>> getOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    return _revisionRepo.getOfferRevisions(offerId: offerId, limit: limit);
  }

  /// Gets a specific revision by ID
  Future<Either<Failure, OfferRevisionModel>> getRevisionById({
    required String offerId,
    required String revisionId,
  }) {
    return _revisionRepo.getRevisionById(
        offerId: offerId, revisionId: revisionId);
  }

  /// Gets revisions made by a specific user
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByUser({
    required String offerId,
    required String userId,
    int? limit,
  }) {
    return _revisionRepo.getRevisionsByUser(
      offerId: offerId,
      userId: userId,
      limit: limit,
    );
  }

  /// Gets revisions of a specific type (e.g., status changes)
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByType({
    required String offerId,
    required OfferRevisionType revisionType,
    int? limit,
  }) {
    return _revisionRepo.getRevisionsByType(
      offerId: offerId,
      revisionType: revisionType,
      limit: limit,
    );
  }

  /// Gets the count of revisions for an offer
  Future<Either<Failure, int>> getRevisionCount({required String offerId}) {
    return _revisionRepo.getRevisionCount(offerId: offerId);
  }

  /// Streams real-time revisions for an offer
  Stream<Either<Failure, List<OfferRevisionModel>>> streamOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    return _revisionRepo.streamOfferRevisions(offerId: offerId, limit: limit);
  }

  /// Gets the latest revision for an offer
  Future<Either<Failure, OfferRevisionModel?>> getLatestRevision({
    required String offerId,
  }) {
    return _revisionRepo.getLatestRevision(offerId: offerId);
  }

  // -- Helper Methods --

  /// Parses status string to Status enum
  /// Handles various formats: 'Pending', 'pending', 'PENDING', etc.
  Status? _parseStatus(dynamic status) {
    if (status == null) return null;
    if (status is Status) return status;

    final statusStr = status.toString().toLowerCase();
    switch (statusStr) {
      case 'draft':
        return Status.Draft;
      case 'pending':
        return Status.Pending;
      case 'accepted':
        return Status.Accepted;
      case 'declined':
        return Status.Declined;
      default:
        return null;
    }
  }

  Future<void> _createNotificationsForChange({
    required Map<String, dynamic>? offerBefore,
    required Map<String, dynamic> offerAfter,
    required String actorUserId,
    required String actorName,
    required bool revisionCreated,
  }) async {
    try {
      final recipients = _extractRecipientUserIds(offerAfter, actorUserId);
      if (recipients.isEmpty) return;

      final offerId =
          offerAfter['offerID'] as String? ?? offerAfter['id'] as String? ?? '';
      if (offerId.isEmpty) return;

      final addressMap = (offerAfter['property'] as Map<String, dynamic>? ??
              {})['address'] as Map<String, dynamic>? ??
          {};
      final propertyAddress = [
        addressMap['street_number'],
        addressMap['street_name'],
        addressMap['city'],
      ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' ');

      final oldStatus = _parseStatus(offerBefore?['status']);
      final newStatus = _parseStatus(offerAfter['status']);
      final statusChanged =
          oldStatus != null && newStatus != null && oldStatus != newStatus;

      for (final userId in recipients) {
        if (statusChanged) {
          final statusName = newStatus.name;
          await _notificationRepo.createNotification(
            recipientUserId: userId,
            notification: OfferNotificationModel(
              recipientUserId: userId,
              actorUserId: actorUserId,
              actorName: actorName,
              type: OfferNotificationType.statusChanged,
              offerId: offerId,
              propertyAddress: propertyAddress,
              title: 'Offer Status Updated',
              message: 'Offer is now $statusName.',
              createdAt: DateTime.now(),
              actionTarget: 'offer/$offerId',
              metadata: {
                'oldStatus': oldStatus.name,
                'newStatus': statusName,
              },
            ),
          );
        }

        if (revisionCreated) {
          await _notificationRepo.createNotification(
            recipientUserId: userId,
            notification: OfferNotificationModel(
              recipientUserId: userId,
              actorUserId: actorUserId,
              actorName: actorName,
              type: OfferNotificationType.revisionCreated,
              offerId: offerId,
              propertyAddress: propertyAddress,
              title: 'Offer Updated',
              message: 'A new revision was added to this offer.',
              createdAt: DateTime.now(),
              actionTarget: 'offer/$offerId',
            ),
          );
        }
      }
    } catch (_) {
      // Notification delivery should not block core offer operations.
    }
  }

  Set<String> _extractRecipientUserIds(
    Map<String, dynamic> offerData,
    String actorUserId,
  ) {
    final parties = offerData['parties'] as Map<String, dynamic>? ?? {};
    final ids = <String>{};

    for (final role in ['buyer', 'seller', 'agent', 'second_buyer']) {
      final party = parties[role] as Map<String, dynamic>?;
      final id = party?['id'] as String?;
      if (id != null && id.isNotEmpty && id != actorUserId) {
        ids.add(id);
      }
    }
    return ids;
  }
}
