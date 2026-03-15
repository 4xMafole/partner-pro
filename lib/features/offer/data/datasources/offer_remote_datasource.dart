import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';

/// Remote data source for offer-related Firestore operations.
@lazySingleton
class OfferRemoteDataSource {
  final FirebaseFirestore _firestore;

  OfferRemoteDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> _userOfferCollection(
      String userId) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .collection(AppConstants.offersCollection);
  }

  String? _stringValue(Map<String, dynamic> source, List<String> keys) {
    for (final key in keys) {
      final value = source[key];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v));
    }
    return <String, dynamic>{};
  }

  Set<String> _offerParticipantIds(Map<String, dynamic> offerData) {
    final ids = <String>{};
    final parties = _asMap(offerData['parties']);

    void addValue(String? value) {
      if (value != null && value.isNotEmpty) ids.add(value);
    }

    addValue(_stringValue(offerData, ['buyerId', 'buyer_id']));
    addValue(_stringValue(offerData, ['sellerId', 'seller_id']));
    addValue(_stringValue(offerData, ['agentId', 'agent_id']));
    addValue(_stringValue(_asMap(parties['buyer']), ['id']));
    addValue(_stringValue(_asMap(parties['seller']), ['id']));
    addValue(_stringValue(_asMap(parties['agent']), ['id']));
    addValue(_stringValue(_asMap(parties['secondBuyer']), ['id']));
    addValue(_stringValue(_asMap(parties['second_buyer']), ['id']));
    return ids;
  }

  Future<void> _syncOfferMirrors({
    required String offerId,
    required Map<String, dynamic> offerData,
    Set<String> oldParticipantIds = const <String>{},
  }) async {
    final participantIds = _offerParticipantIds(offerData);
    final mirrorData = {...offerData};

    final batch = _firestore.batch();

    for (final uid in participantIds) {
      batch.set(_userOfferCollection(uid).doc(offerId), mirrorData);
    }

    final staleParticipantIds = oldParticipantIds.difference(participantIds);
    for (final uid in staleParticipantIds) {
      batch.delete(_userOfferCollection(uid).doc(offerId));
    }

    await batch.commit();
  }

  // -- Get Offers --

  /// Fetches offers for a buyer user.
  Future<List<Map<String, dynamic>>> getUserOffers({
    required String requesterId,
    String? propertyId,
    String? buyerId,
    String? sellerId,
    String? status,
  }) async {
    final ownerId = buyerId ?? sellerId ?? requesterId;
    Query<Map<String, dynamic>> query =
        _firestore.collection(AppConstants.offersCollection).where(Filter.or(
              Filter('parties.buyer.id', isEqualTo: ownerId),
              Filter('buyer_id', isEqualTo: ownerId),
              Filter('buyerId', isEqualTo: ownerId),
              // Filter('parties.secondBuyer.id', isEqualTo: ownerId),
            ));

    final snap = await query.get();

    final data =
        snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).where((offer) {
      if (propertyId != null &&
          offer['property_id'] != propertyId &&
          offer['propertyId'] != propertyId) {
        return false;
      }
      if (status != null &&
          (offer['status']?.toString().toLowerCase() != status.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    data.sort((a, b) => (b['created_at']?.toString() ?? '')
        .compareTo(a['created_at']?.toString() ?? ''));

    return data;
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
    Query<Map<String, dynamic>> query =
        _firestore.collection(AppConstants.offersCollection).where(Filter.or(
              Filter('parties.agent.id', isEqualTo: requesterId),
              Filter('agent_id', isEqualTo: requesterId),
              Filter('agentId', isEqualTo: requesterId),
            ));

    final snap = await query.get();

    final data =
        snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).where((offer) {
      if (status == null) return true;
      return offer['status']?.toString().toLowerCase() == status.toLowerCase();
    }).toList();

    data.sort((a, b) => (b['created_at']?.toString() ?? '')
        .compareTo(a['created_at']?.toString() ?? ''));

    return data;
  }

  Future<Map<String, dynamic>?> getRelationshipForSubjectUid({
    required String subjectUid,
  }) async {
    final collection = _firestore.collection('relationships');
    final buyerSnap = await collection
        .where('buyerId', isEqualTo: subjectUid)
        .where('status', isEqualTo: 'active')
        .limit(1)
        .get();
    if (buyerSnap.docs.isNotEmpty) {
      final doc = buyerSnap.docs.first;
      return {...doc.data(), 'id': doc.id};
    }

    final legacySnap = await collection
        .where('relationship.subjectUid', isEqualTo: subjectUid)
        .limit(1)
        .get();
    final snap = legacySnap;
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    return {...doc.data(), 'id': doc.id};
  }

  Future<Map<String, dynamic>?> getUserByUid({
    required String uid,
  }) async {
    final byDoc = await _firestore.collection('users').doc(uid).get();
    if (byDoc.exists) {
      return {...?byDoc.data(), 'id': byDoc.id};
    }

    final snap = await _firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final doc = snap.docs.first;
    return {...doc.data(), 'id': doc.id};
  }

  Future<Map<String, dynamic>?> getPropertyById({
    required String propertyId,
  }) async {
    if (propertyId.isEmpty) return null;
    final doc = await _firestore
        .collection(AppConstants.propertiesCollection)
        .doc(propertyId)
        .get();
    if (!doc.exists) return null;
    return {...?doc.data(), 'id': doc.id};
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
    final result = {
      ...?snap.data(),
      'id': docRef.id,
      'offerID': docRef.id,
      'createdDate': DateTime.now().toIso8601String(),
      'userID': requesterId,
    };
    return result;
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
    final result = {...snap.data()!, 'id': snap.id};
    return result;
  }

  /// Updates only the status field of an existing offer.
  Future<Map<String, dynamic>> updateOfferStatus({
    required String offerId,
    required String status,
    required String requesterId,
  }) async {
    if (offerId.isEmpty) {
      throw ArgumentError('offerId cannot be empty');
    }

    await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .update({
      'status': status,
      'updated_at': FieldValue.serverTimestamp(),
      'updated_by': requesterId,
    });

    final snap = await _firestore
        .collection(AppConstants.offersCollection)
        .doc(offerId)
        .get();
    return {...snap.data()!, 'id': snap.id};
  }
}
