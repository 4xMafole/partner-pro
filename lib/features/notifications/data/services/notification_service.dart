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

  /// Build a richer description by appending contextual metadata.
  static String _enrichDescription(
    Map<String, dynamic> raw,
    Map<String, dynamic> meta,
    String type,
  ) {
    final base =
        (raw['message'] ?? raw['body'] ?? raw['description'] ?? '').toString();
    final parts = <String>[];
    final property = (meta['propertyAddress'] ?? meta['property_address'] ?? '')
        .toString()
        .trim();
    final buyer =
        (meta['buyerName'] ?? meta['buyer_name'] ?? '').toString().trim();
    final amount =
        (meta['offerAmount'] ?? meta['offer_amount'] ?? '').toString().trim();

    if (buyer.isNotEmpty) parts.add(buyer);
    if (property.isNotEmpty) parts.add(property);
    if (amount.isNotEmpty) parts.add('\$$amount');

    if (parts.isEmpty) return base;
    final context = parts.join(' · ');
    return base.isNotEmpty ? '$base\n$context' : context;
  }

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
              final rawType = (raw['type'] ?? 'offer').toString().trim();
              final rawTypeLower = rawType.toLowerCase();
              // Map known Firestore type strings to enum names.
              // Unknown types fall back to 'offer' to prevent crashes.
              const knownTypes = {
                'offer',
                'property',
                'propertySuggestion',
                'appointment',
                'transactionCoordinator',
                'revisionCreated',
                'showing',
              };
              const aliasMap = {
                'showami': 'showing',
                'tour': 'showing',
                'scheduled_tour': 'showing',
                'showing_request': 'showing',
                'property_suggestion': 'propertySuggestion',
                'transaction_coordinator': 'transactionCoordinator',
                'revision_created': 'revisionCreated',
                'status_changed': 'offer',
                'statusChanged': 'offer',
              };
              final mappedType = knownTypes.contains(rawType)
                  ? rawType
                  : (aliasMap[rawType] ?? aliasMap[rawTypeLower] ?? 'offer');
              final meta = (raw['metadata'] as Map<String, dynamic>?) ?? {};
              final data = <String, dynamic>{
                'id': d.id,
                'title': raw['title'] ?? '',
                'description': _enrichDescription(raw, meta, mappedType),
                'type': mappedType,
                'createdAt': raw['createdAt'],
                'isRead': raw['isRead'] ?? false,
                'offerId':
                    meta['offerId'] ?? meta['propertyId'] ?? raw['offerId'],
                'metadata': meta,
              };
              return NotificationModel.fromJson(data);
            }).toList());
  }

  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
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

    await batch.commit();
  }

  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .delete();
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
      'offerId': data?['offerId'],
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
