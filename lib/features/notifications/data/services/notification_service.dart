import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../notifications/data/models/notification_model.dart';

@lazySingleton
class NotificationService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;

  NotificationService(this._firestore, this._messaging);

  Future<String?> initializeFCM() async {
    final settings = await _messaging.requestPermission(
        alert: true, badge: true, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return await _messaging.getToken();
    }
    return null;
  }

  Stream<List<NotificationModel>> notificationsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final raw = d.data();
              final data = <String, dynamic>{
                'id': d.id,
                'title': raw['title'] ?? '',
                'description':
                    raw['message'] ?? raw['body'] ?? raw['description'] ?? '',
                // Keep existing UI icon mapping stable by mapping offer notifications to 'offer'.
                'type': 'offer',
                'createdAt': raw['createdAt'],
                'isRead': raw['isRead'] ?? false,
              };
              return NotificationModel.fromJson(data);
            }).toList());
  }

  Future<void> markAsRead(String notificationId) async {
    // New schema path (preferred).
    final hits = await _firestore
        .collectionGroup('notifications')
        .where(FieldPath.documentId, isEqualTo: notificationId)
        .limit(1)
        .get();

    if (hits.docs.isNotEmpty) {
      await hits.docs.first.reference.update({'isRead': true});
      return;
    }

    // Legacy fallback path.
    await _firestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  Future<void> markAllAsRead(String userId) async {
    final batch = _firestore.batch();
    final snap = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .get();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    // Legacy fallback path for older notifications.
    final legacySnap = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();
    for (final doc in legacySnap.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Future<void> deleteNotification(String notificationId) async {
    final hits = await _firestore
        .collectionGroup('notifications')
        .where(FieldPath.documentId, isEqualTo: notificationId)
        .limit(1)
        .get();

    if (hits.docs.isNotEmpty) {
      await hits.docs.first.reference.delete();
      return;
    }

    // Legacy fallback path.
    await _firestore.collection('notifications').doc(notificationId).delete();
  }

  Future<void> createNotification(
      {required String userId,
      required String title,
      required String body,
      String? type,
      Map<String, dynamic>? data}) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
      'recipientUserId': userId,
      'title': title,
      'message': body,
      'type': type ?? 'general',
      'metadata': data,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
