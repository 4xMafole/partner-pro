import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

/// Firestore data source for invitations, relationships, and activities.
@lazySingleton
class FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSource(this._firestore);

  // ── Invitations ────────────────────────────────────────────

  /// Create a batch of buyer invitations in Firestore.
  Future<void> createInvitations({
    required String inviterUid,
    required String inviterName,
    required List<Map<String, dynamic>> invitees,
  }) async {
    final batch = _firestore.batch();
    for (final invitee in invitees) {
      final docRef = _firestore.collection('invitations').doc();
      batch.set(docRef, {
        'inviterUid': inviterUid,
        'inviterName': inviterName,
        'inviteeName': invitee['name'] ??
            [invitee['first_name'], invitee['last_name']]
                .where((e) => e != null && e.toString().isNotEmpty)
                .join(' '),
        'inviteeEmail': invitee['email'] ?? '',
        'inviteePhoneNumber': invitee['phone'] ?? '',
        'inviteeType': invitee['type'] ?? 'buyer',
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }

  /// Stream invitations created by an agent.
  Stream<List<Map<String, dynamic>>> watchInvitations(String inviterUid) {
    return _firestore
        .collection('invitations')
        .where('inviterUid', isEqualTo: inviterUid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  /// Get all invitations for an agent (one-time fetch).
  Future<List<Map<String, dynamic>>> getInvitations(String inviterUid) async {
    final snap = await _firestore
        .collection('invitations')
        .where('inviterUid', isEqualTo: inviterUid)
        .orderBy('createdAt', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Update invitation status (e.g., pending → accepted).
  Future<void> updateInvitationStatus({
    required String invitationId,
    required String status,
  }) async {
    await _firestore.collection('invitations').doc(invitationId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete an invitation.
  Future<void> deleteInvitation(String invitationId) async {
    await _firestore.collection('invitations').doc(invitationId).delete();
  }

  /// Get pending invitations for a buyer by email.
  Future<List<Map<String, dynamic>>> getInvitationsForBuyer(
      String email) async {
    final snap = await _firestore
        .collection('invitations')
        .where('inviteeEmail', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Stream pending invitations for a buyer by email.
  Stream<List<Map<String, dynamic>>> watchInvitationsForBuyer(String email) {
    return _firestore
        .collection('invitations')
        .where('inviteeEmail', isEqualTo: email)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  // ── Relationships ──────────────────────────────────────────

  /// Create a relationship (agent ↔ buyer link).
  Future<void> createRelationship({
    required String agentId,
    required String buyerId,
    required String agentName,
    required String buyerName,
  }) async {
    await _firestore.collection('relationships').add({
      'agentId': agentId,
      'buyerId': buyerId,
      'agentName': agentName,
      'buyerName': buyerName,
      'status': 'active',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Stream relationships for a user (agent or buyer).
  Stream<List<Map<String, dynamic>>> watchRelationships({
    required String userId,
    required bool isAgent,
  }) {
    final field = isAgent ? 'agentId' : 'buyerId';
    return _firestore
        .collection('relationships')
        .where(field, isEqualTo: userId)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  // ── Customers / Subscriptions ──────────────────────────────

  /// Get Stripe customer record for a user.
  Future<Map<String, dynamic>?> getCustomer(String userId) async {
    final snap = await _firestore.collection('customers').doc(userId).get();
    return snap.exists ? snap.data() : null;
  }

  /// Stream active subscriptions for a customer.
  Stream<List<Map<String, dynamic>>> watchSubscriptions(String userId) {
    return _firestore
        .collection('customers')
        .doc(userId)
        .collection('subscriptions')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  // ── Generic helpers ────────────────────────────────────────

  /// Stream a single document.
  Stream<Map<String, dynamic>?> watchDocument(String collection, String docId) {
    return _firestore
        .collection(collection)
        .doc(docId)
        .snapshots()
        .map((snap) => snap.exists ? {...snap.data()!, 'id': snap.id} : null);
  }

  // ── Client Notes ───────────────────────────────────────────

  /// Add a note between an agent and a client.
  Future<void> addClientNote({
    required String agentId,
    required String clientId,
    required String note,
  }) async {
    await _firestore.collection('client_notes').add({
      'agentId': agentId,
      'clientId': clientId,
      'note': note,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update an existing client note.
  Future<void> updateClientNote({
    required String noteId,
    required String updatedNote,
  }) async {
    await _firestore.collection('client_notes').doc(noteId).update({
      'note': updatedNote,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete a client note.
  Future<void> deleteClientNote(String noteId) async {
    await _firestore.collection('client_notes').doc(noteId).delete();
  }

  /// Get notes for a specific agent-client pair.
  Future<List<Map<String, dynamic>>> getClientNotes({
    required String agentId,
    required String clientId,
  }) async {
    final snap = await _firestore
        .collection('client_notes')
        .where('agentId', isEqualTo: agentId)
        .where('clientId', isEqualTo: clientId)
        .orderBy('createdAt', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }
}
