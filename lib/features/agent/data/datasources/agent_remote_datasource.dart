import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';

/// Remote data source for user account and agent-client Firestore operations.
@lazySingleton
class UserAccountRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserAccountRemoteDataSource(this._firestore);

  // -- User Accounts --

  /// Fetch a user account by email, userName, or id.
  Future<Map<String, dynamic>> fetchUserAccount({
    String? userName,
    String? email,
    String? id,
  }) async {
    if (id != null && id.isNotEmpty) {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(id)
          .get();
      if (doc.exists) return {...doc.data()!, 'id': doc.id};
      return {};
    }

    Query<Map<String, dynamic>> query =
        _firestore.collection(AppConstants.usersCollection);
    if (email != null && email.isNotEmpty) {
      query = query.where('email', isEqualTo: email);
    } else if (userName != null && userName.isNotEmpty) {
      query = query.where('user_name', isEqualTo: userName);
    }

    final snap = await query.limit(1).get();
    if (snap.docs.isEmpty) return {};
    return {...snap.docs.first.data(), 'id': snap.docs.first.id};
  }

  /// Create a new user account.
  Future<Map<String, dynamic>> createUserAccount({
    required Map<String, dynamic> userData,
  }) async {
    final userId =
        userData['uid'] as String? ?? userData['id'] as String?;
    if (userId != null && userId.isNotEmpty) {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .set({
        ...userData,
        'created_at': FieldValue.serverTimestamp(),
      });
      return {...userData, 'id': userId};
    }
    final docRef =
        await _firestore.collection(AppConstants.usersCollection).add({
      ...userData,
      'created_at': FieldValue.serverTimestamp(),
    });
    return {...userData, 'id': docRef.id};
  }

  /// Update an existing user account.
  Future<Map<String, dynamic>> updateUserAccount({
    required Map<String, dynamic> userData,
  }) async {
    final userId = userData['uid'] as String? ??
        userData['id'] as String? ??
        userData['user_id'] as String? ??
        '';
    if (userId.isEmpty) {
      throw ArgumentError('userData must contain uid, id, or user_id');
    }

    final updateData = Map<String, dynamic>.from(userData)
      ..remove('uid')
      ..remove('id')
      ..remove('user_id');
    updateData['updated_at'] = FieldValue.serverTimestamp();

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update(updateData);
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();
    return {...doc.data()!, 'id': doc.id};
  }

  /// Deactivate a user account.
  Future<void> deactivateUserAccount({required String userId}) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update({
      'status': 'inactive',
      'deactivated_at': FieldValue.serverTimestamp(),
    });
  }

  // -- Agents --

  /// Create / register agent record.
  Future<Map<String, dynamic>> createAgent({
    required String requesterId,
    required Map<String, dynamic> agentData,
  }) async {
    final agentId =
        agentData['uid'] as String? ?? agentData['id'] as String?;
    if (agentId != null && agentId.isNotEmpty) {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(agentId)
          .set(
        {
          ...agentData,
          'role': 'agent',
          'created_at': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      return {...agentData, 'id': agentId};
    }
    final docRef =
        await _firestore.collection(AppConstants.usersCollection).add({
      ...agentData,
      'role': 'agent',
      'created_at': FieldValue.serverTimestamp(),
    });
    return {...agentData, 'id': docRef.id};
  }

  /// Get agent profile.
  Future<Map<String, dynamic>> getAgent({
    required String agentId,
    required String requesterId,
  }) async {
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(agentId)
        .get();
    if (!doc.exists) return {};
    return {...doc.data()!, 'id': doc.id};
  }

  /// Get all clients for an agent.
  Future<List<Map<String, dynamic>>> getAgentClients({
    required String agentId,
    required String requesterId,
  }) async {
    final relSnap = await _firestore
        .collection(AppConstants.relationshipsCollection)
        .where('agentId', isEqualTo: agentId)
        .where('status', isEqualTo: 'active')
        .get();

    final clientIds = relSnap.docs
        .map((doc) => doc.data()['buyerId'] as String?)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    if (clientIds.isEmpty) return [];

    // Firestore 'in' queries support max 30 items per batch
    final clients = <Map<String, dynamic>>[];
    for (var i = 0; i < clientIds.length; i += 30) {
      final end =
          (i + 30 > clientIds.length) ? clientIds.length : i + 30;
      final batch = clientIds.sublist(i, end);
      final snap = await _firestore
          .collection(AppConstants.usersCollection)
          .where(FieldPath.documentId, whereIn: batch)
          .get();
      clients.addAll(snap.docs.map(
          (doc) => {...doc.data(), 'id': doc.id, 'clientID': doc.id}));
    }
    return clients;
  }

  /// Get activity feed for agent's clients.
  Future<List<Map<String, dynamic>>> getClientActivities({
    required String agentId,
    required String requesterId,
  }) async {
    final relSnap = await _firestore
        .collection(AppConstants.relationshipsCollection)
        .where('agentId', isEqualTo: agentId)
        .where('status', isEqualTo: 'active')
        .get();

    final clientIds = relSnap.docs
        .map((doc) => doc.data()['buyerId'] as String?)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    if (clientIds.isEmpty) return [];

    final activities = <Map<String, dynamic>>[];
    for (var i = 0; i < clientIds.length; i += 30) {
      final end =
          (i + 30 > clientIds.length) ? clientIds.length : i + 30;
      final batch = clientIds.sublist(i, end);
      final snap = await _firestore
          .collection('activities')
          .where('user_id', whereIn: batch)
          .orderBy('created_at', descending: true)
          .limit(50)
          .get();
      activities
          .addAll(snap.docs.map((doc) => {...doc.data(), 'id': doc.id}));
    }
    return activities;
  }
}