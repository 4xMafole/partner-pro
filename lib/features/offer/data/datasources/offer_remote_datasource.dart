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
    Query<Map<String, dynamic>> query =
        _firestore.collection(AppConstants.offersCollection);
    if (propertyId != null) {
      query = query.where('property_id', isEqualTo: propertyId);
    }
    if (buyerId != null) query = query.where('buyer', isEqualTo: buyerId);
    if (sellerId != null) query = query.where('seller', isEqualTo: sellerId);
    if (status != null) query = query.where('status', isEqualTo: status);

    final snap = await query.orderBy('created_at', descending: true).get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Fetches offers from agent perspective.
  Future<List<Map<String, dynamic>>> getAgentOffers({
    required String requesterId,
    String? status,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection(AppConstants.offersCollection)
        .where('agent_id', isEqualTo: requesterId);
    if (status != null) query = query.where('status', isEqualTo: status);

    final snap = await query.orderBy('created_at', descending: true).get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
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
    return {
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
    final offerId = offerData['offerID'] as String? ??
        offerData['id'] as String? ??
        '';
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