import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/offer_revision_model.dart';

/// Remote data source for offer revision tracking in Firestore.
/// 
/// Revisions are stored in a subcollection: offers/{offerId}/revisions/{revisionId}
@lazySingleton
class OfferRevisionDataSource {
  final FirebaseFirestore _firestore;

  OfferRevisionDataSource(this._firestore);

  /// Creates a new revision record for an offer
  /// 
  /// Returns the created revision with generated ID
  Future<OfferRevisionModel> createRevision({
    required String offerId,
    required OfferRevisionModel revision,
  }) async {
    // Get next revision number
    final nextRevisionNumber = await _getNextRevisionNumber(offerId);

    // Prepare revision data
    final revisionData = revision.copyWith(
      revisionNumber: nextRevisionNumber,
      timestamp: DateTime.now(),
    ).toJson();

    // Create revision document
    final docRef = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .add(revisionData);

    // Return revision with generated ID
    return revision.copyWith(
      id: docRef.id,
      revisionNumber: nextRevisionNumber,
      timestamp: DateTime.now(),
    );
  }

  /// Retrieves all revisions for an offer, ordered by timestamp descending
  Future<List<OfferRevisionModel>> getOfferRevisions({
    required String offerId,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OfferRevisionModel.fromJson(data);
    }).toList();
  }

  /// Retrieves a specific revision by ID
  Future<OfferRevisionModel?> getRevisionById({
    required String offerId,
    required String revisionId,
  }) async {
    final doc = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .doc(revisionId)
        .get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    data['id'] = doc.id;
    return OfferRevisionModel.fromJson(data);
  }

  /// Retrieves revisions by user (for audit purposes)
  Future<List<OfferRevisionModel>> getRevisionsByUser({
    required String offerId,
    required String userId,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OfferRevisionModel.fromJson(data);
    }).toList();
  }

  /// Retrieves revisions by type (e.g., all status changes)
  Future<List<OfferRevisionModel>> getRevisionsByType({
    required String offerId,
    required OfferRevisionType revisionType,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .where('revisionType', isEqualTo: revisionType.name)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OfferRevisionModel.fromJson(data);
    }).toList();
  }

  /// Gets the count of revisions for an offer
  Future<int> getRevisionCount({required String offerId}) async {
    final snapshot = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Streams real-time revisions for an offer
  Stream<List<OfferRevisionModel>> streamOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return OfferRevisionModel.fromJson(data);
      }).toList();
    });
  }

  /// Gets the latest revision for an offer
  Future<OfferRevisionModel?> getLatestRevision({required String offerId}) async {
    final snapshot = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final data = snapshot.docs.first.data();
    data['id'] = snapshot.docs.first.id;
    return OfferRevisionModel.fromJson(data);
  }

  /// Helper: Gets next sequential revision number for an offer
  Future<int> _getNextRevisionNumber(String offerId) async {
    final latestRevision = await getLatestRevision(offerId: offerId);
    return (latestRevision?.revisionNumber ?? 0) + 1;
  }

  /// Deletes all revisions for an offer (used when offer is permanently deleted)
  Future<void> deleteAllRevisions({required String offerId}) async {
    final batch = _firestore.batch();
    final snapshot = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .collection('revisions')
        .get();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
