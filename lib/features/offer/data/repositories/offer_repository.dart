import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/offer_remote_datasource.dart';
import '../models/offer_model.dart';
import '../models/offer_revision_model.dart';
import 'offer_revision_repository.dart';

@lazySingleton
class OfferRepository {
  final OfferRemoteDataSource _remote;
  final OfferRevisionRepository _revisionRepo;

  OfferRepository(this._remote, this._revisionRepo);

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
}
