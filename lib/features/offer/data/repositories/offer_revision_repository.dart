import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/offer_revision_datasource.dart';
import '../models/offer_revision_model.dart';

/// Repository for offer revision operations with error handling
@lazySingleton
class OfferRevisionRepository {
  final OfferRevisionDataSource _datasource;

  OfferRevisionRepository(this._datasource);

  /// Creates a revision record for an offer change
  Future<Either<Failure, OfferRevisionModel>> createRevision({
    required String offerId,
    required OfferRevisionModel revision,
  }) async {
    try {
      final result = await _datasource.createRevision(
        offerId: offerId,
        revision: revision,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create revision: $e'));
    }
  }

  /// Retrieves all revisions for an offer
  Future<Either<Failure, List<OfferRevisionModel>>> getOfferRevisions({
    required String offerId,
    int? limit,
  }) async {
    try {
      final revisions = await _datasource.getOfferRevisions(
        offerId: offerId,
        limit: limit,
      );
      return Right(revisions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch revisions: $e'));
    }
  }

  /// Retrieves a specific revision by ID
  Future<Either<Failure, OfferRevisionModel>> getRevisionById({
    required String offerId,
    required String revisionId,
  }) async {
    try {
      final revision = await _datasource.getRevisionById(
        offerId: offerId,
        revisionId: revisionId,
      );
      if (revision == null) {
        return Left(ServerFailure(message: 'Revision not found', code: 404));
      }
      return Right(revision);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch revision: $e'));
    }
  }

  /// Retrieves revisions made by a specific user
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByUser({
    required String offerId,
    required String userId,
    int? limit,
  }) async {
    try {
      final revisions = await _datasource.getRevisionsByUser(
        offerId: offerId,
        userId: userId,
        limit: limit,
      );
      return Right(revisions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch user revisions: $e'));
    }
  }

  /// Retrieves revisions of a specific type (e.g., status changes)
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByType({
    required String offerId,
    required OfferRevisionType revisionType,
    int? limit,
  }) async {
    try {
      final revisions = await _datasource.getRevisionsByType(
        offerId: offerId,
        revisionType: revisionType,
        limit: limit,
      );
      return Right(revisions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch typed revisions: $e'));
    }
  }

  /// Gets the count of revisions for an offer
  Future<Either<Failure, int>> getRevisionCount({
    required String offerId,
  }) async {
    try {
      final count = await _datasource.getRevisionCount(offerId: offerId);
      return Right(count);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to count revisions: $e'));
    }
  }

  /// Streams real-time revisions for an offer
  Stream<Either<Failure, List<OfferRevisionModel>>> streamOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    try {
      return _datasource
          .streamOfferRevisions(offerId: offerId, limit: limit)
          .map((revisions) => Right<Failure, List<OfferRevisionModel>>(revisions))
          .handleError((error) {
        if (error is ServerException) {
          return Left<Failure, List<OfferRevisionModel>>(
            ServerFailure(message: error.message, code: error.statusCode),
          );
        }
        return Left<Failure, List<OfferRevisionModel>>(
          ServerFailure(message: 'Failed to stream revisions: $error'),
        );
      });
    } catch (e) {
      return Stream.value(
        Left(ServerFailure(message: 'Failed to stream revisions: $e')),
      );
    }
  }

  /// Gets the latest revision for an offer
  Future<Either<Failure, OfferRevisionModel?>> getLatestRevision({
    required String offerId,
  }) async {
    try {
      final revision = await _datasource.getLatestRevision(offerId: offerId);
      return Right(revision);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch latest revision: $e'));
    }
  }

  /// Deletes all revisions for an offer (cleanup when offer deleted)
  Future<Either<Failure, void>> deleteAllRevisions({
    required String offerId,
  }) async {
    try {
      await _datasource.deleteAllRevisions(offerId: offerId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete revisions: $e'));
    }
  }

  /// Helper: Creates a revision from offer comparison
  /// 
  /// Compares old and new offer states and creates a revision record
  Future<Either<Failure, OfferRevisionModel>> createRevisionFromComparison({
    required String offerId,
    required Map<String, dynamic> oldOffer,
    required Map<String, dynamic> newOffer,
    required String userId,
    required String userName,
    required String userRole,
    String changeNotes = '',
    OfferRevisionType? revisionType,
    String? ipAddress,
    String? deviceInfo,
  }) async {
    try {
      // Compare offers and generate field changes
      final fieldChanges = OfferRevisionHelper.compareOffers(
        oldOffer: oldOffer,
        newOffer: newOffer,
      );

      // Determine revision type if not specified
      final actualRevisionType = revisionType ?? _determineRevisionType(
        fieldChanges: fieldChanges,
        oldStatus: oldOffer['status'] as String?,
        newStatus: newOffer['status'] as String?,
      );

      // Generate change summary
      final changeSummary = OfferRevisionHelper.generateChangeSummary(fieldChanges);

      // Check for status change
      String? previousStatus;
      String? newStatus;
      if (oldOffer['status'] != newOffer['status']) {
        previousStatus = oldOffer['status'] as String?;
        newStatus = newOffer['status'] as String?;
      }

      // Create revision model
      final revision = OfferRevisionModel(
        offerId: offerId,
        userId: userId,
        userName: userName,
        userRole: userRole,
        timestamp: DateTime.now(),
        revisionType: actualRevisionType,
        fieldChanges: fieldChanges,
        previousStatus: previousStatus,
        newStatus: newStatus,
        changeNotes: changeNotes,
        changeSummary: changeSummary,
        offerSnapshot: newOffer, // Store complete offer state
        ipAddress: ipAddress ?? '',
        deviceInfo: deviceInfo ?? '',
      );

      // Save revision
      return await createRevision(offerId: offerId, revision: revision);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create comparison revision: $e'));
    }
  }

  /// Helper: Determines revision type based on changes
  OfferRevisionType _determineRevisionType({
    required List<FieldChange> fieldChanges,
    String? oldStatus,
    String? newStatus,
  }) {
    // Status change takes precedence
    if (oldStatus != null && newStatus != null && oldStatus != newStatus) {
      return OfferRevisionType.statusChanged;
    }

    // Check for counter (purchase price change with counter count increase)
    final priceChanged = fieldChanges.any((c) => 
      c.fieldName == 'purchasePrice' || c.fieldName == 'finalPrice'
    );
    final counterChanged = fieldChanges.any((c) => c.fieldName == 'counteredCount');

    if (priceChanged && counterChanged) {
      return OfferRevisionType.countered;
    }

    // Check for addendum changes
    final addendumChanged = fieldChanges.any((c) => 
      c.fieldName == 'addendums' || c.fieldName.startsWith('addendums.')
    );
    if (addendumChanged) {
      return OfferRevisionType.addendumChanged;
    }

    // Check for document changes
    final documentChanged = fieldChanges.any((c) => 
      c.fieldName == 'documents' || c.fieldName.startsWith('documents.')
    );
    if (documentChanged) {
      return OfferRevisionType.documentChanged;
    }

    // Check for agent action
    final agentActionChanged = fieldChanges.any((c) => c.fieldName == 'agentApproved');
    if (agentActionChanged) {
      return OfferRevisionType.agentAction;
    }

    // Default to general modification
    return OfferRevisionType.modified;
  }
}
