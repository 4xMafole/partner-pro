import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';

/// Remote data source for offer-related Firestore operations.
@lazySingleton
class OfferRemoteDataSource {
  final FirebaseFirestore _firestore;

  OfferRemoteDataSource(this._firestore);

  // -- Get Offers --

  /// Fetches offers for a buyer user.
  Future<List<Map<String, dynamic>>> getUserOffers({
    required String requesterId,
    String? propertyId,
    String? buyerId,
    String? sellerId,
    String? status,
  }) async {
    final base = _firestore.collection(AppConstants.offersCollection);

    Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _runForField(
      String field,
      String value,
    ) async {
      Query<Map<String, dynamic>> q = base.where(field, isEqualTo: value);
      if (propertyId != null) q = q.where('property_id', isEqualTo: propertyId);
      if (status != null) q = q.where('status', isEqualTo: status);
      try {
        final snap = await q.orderBy('created_at', descending: true).get();
        return snap.docs;
      } catch (_) {
        // Legacy docs may not have created_at indexed/populated consistently.
        final snap = await q.get();
        return snap.docs;
      }
    }

    final docsById = <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

    if (buyerId != null) {
      for (final f in ['buyer_id', 'buyerId']) {
        final docs = await _runForField(f, buyerId);
        for (final d in docs) {
          docsById[d.id] = d;
        }
      }
    } else if (sellerId != null) {
      for (final f in ['seller_id', 'sellerId']) {
        final docs = await _runForField(f, sellerId);
        for (final d in docs) {
          docsById[d.id] = d;
        }
      }
    } else {
      // Default buyer perspective: support both current and legacy field names.
      for (final f in ['buyer_id', 'buyerId', 'created_by']) {
        final docs = await _runForField(f, requesterId);
        for (final d in docs) {
          docsById[d.id] = d;
        }
      }
    }

    final docs = docsById.values.toList()
      ..sort((a, b) {
        final at = a.data()['created_at'];
        final bt = b.data()['created_at'];
        if (at is Timestamp && bt is Timestamp) {
          return bt.compareTo(at);
        }
        return 0;
      });

    return docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Fetches a single offer document by ID.
  Future<Map<String, dynamic>?> getOfferById({
    required String offerId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .get();
    if (!snap.exists) return null;
    return {...?snap.data(), 'id': snap.id};
  }

  /// Fetches offers from agent perspective.
  Future<List<Map<String, dynamic>>> getAgentOffers({
    required String requesterId,
    String? status,
  }) async {
    final docsById = <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

    Future<void> run(String field) async {
      Query<Map<String, dynamic>> q = _firestore
          .collection(AppConstants.offersCollection)
          .where(field, isEqualTo: requesterId);
      if (status != null) q = q.where('status', isEqualTo: status);
      try {
        final snap = await q.orderBy('created_at', descending: true).get();
        for (final d in snap.docs) {
          docsById[d.id] = d;
        }
      } catch (_) {
        final snap = await q.get();
        for (final d in snap.docs) {
          docsById[d.id] = d;
        }
      }
    }

    await run('agent_id');
    await run('agentId');

    final docs = docsById.values.toList()
      ..sort((a, b) {
        final at = a.data()['created_at'];
        final bt = b.data()['created_at'];
        if (at is Timestamp && bt is Timestamp) {
          return bt.compareTo(at);
        }
        return 0;
      });

    return docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  Future<Map<String, dynamic>?> getRelationshipForSubjectUid({
    required String subjectUid,
  }) async {
    final snap = await _firestore
        .collection('relationships')
        .where('relationship.subjectUid', isEqualTo: subjectUid)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    return {...doc.data(), 'id': doc.id};
  }

  Future<Map<String, dynamic>?> getUserByUid({
    required String uid,
  }) async {
    final snap = await _firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    return {...doc.data(), 'id': doc.id};
  }

  // -- Create / Update Offers --

  /// Creates a new offer.
  Future<Map<String, dynamic>> createOffer({
    required String requesterId,
    required Map<String, dynamic> offerData,
  }) async {
    final docRef =
        await _firestore.collection(AppConstants.offersCollection).add({
      ...offerData,
      'created_by': requesterId,
      'created_at': FieldValue.serverTimestamp(),
    });
    final snap = await docRef.get();
    return {
      ...?snap.data(),
      'id': docRef.id,
      'offerID': docRef.id,
      'createdDate': DateTime.now().toIso8601String(),
      'userID': requesterId,
    };
  }

  /// Updates an existing offer.
  Future<Map<String, dynamic>> updateOffer({
    required String requesterId,
    required Map<String, dynamic> offerData,
  }) async {
    final offerId =
        offerData['offerID'] as String? ?? offerData['id'] as String? ?? '';
    if (offerId.isEmpty) {
      throw ArgumentError('offerData must contain offerID or id');
    }

    final updateData = Map<String, dynamic>.from(offerData)
      ..remove('offerID')
      ..remove('id');
    updateData['updated_at'] = FieldValue.serverTimestamp();
    updateData['updated_by'] = requesterId;

    await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .update(updateData);
    final snap = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .get();
    return {...snap.data()!, 'id': snap.id};
  }
}
