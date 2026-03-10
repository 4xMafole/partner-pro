import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/offer_notification_model.dart';

/// Remote data source for offer notifications in Firestore.
///
/// Notifications are stored in a subcollection: users/{userId}/notifications/{notificationId}
/// This allows for per-user notification streams and efficient querying.
@lazySingleton
class OfferNotificationDataSource {
  final FirebaseFirestore _firestore;

  OfferNotificationDataSource(this._firestore);

  /// Creates a new notification for a user
  ///
  /// Notifications are stored in: users/{userId}/notifications/{id}
  /// Returns the created notification with generated ID
  Future<OfferNotificationModel> createNotification({
    required String recipientUserId,
    required OfferNotificationModel notification,
  }) async {
    final notificationData = notification.toJson();

    final docRef = await _firestore
        .collection('users')
        .doc(recipientUserId)
        .collection('notifications')
        .add(notificationData);

    return notification.copyWith(id: docRef.id);
  }

  /// Retrieves all notifications for a user, ordered by creation date descending
  Future<List<OfferNotificationModel>> getUserNotifications({
    required String userId,
    bool? unreadOnly,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true);

    if (unreadOnly == true) {
      query = query.where('isRead', isEqualTo: false);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OfferNotificationModel.fromJson(data);
    }).toList();
  }

  /// Streams real-time notifications for a user
  ///
  /// Useful for showing live notification updates in the UI
  Stream<List<OfferNotificationModel>> streamUserNotifications({
    required String userId,
    bool? unreadOnly,
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true);

    if (unreadOnly == true) {
      query = query.where('isRead', isEqualTo: false);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return OfferNotificationModel.fromJson(data);
      }).toList();
    });
  }

  /// Retrieves notifications for a specific offer
  Future<List<OfferNotificationModel>> getOfferNotifications({
    required String userId,
    required String offerId,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('offerId', isEqualTo: offerId)
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return OfferNotificationModel.fromJson(data);
    }).toList();
  }

  /// Marks a notification as read
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update({
      'isRead': true,
      'readAt': DateTime.now(),
    });
  }

  /// Marks all unread notifications as read for a user
  Future<void> markAllAsRead({required String userId}) async {
    final unreadNotifications =
        await getUserNotifications(userId: userId, unreadOnly: true);

    final batch = _firestore.batch();

    for (final notification in unreadNotifications) {
      batch.update(
        _firestore
            .collection('users')
            .doc(userId)
            .collection('notifications')
            .doc(notification.id),
        {
          'isRead': true,
          'readAt': DateTime.now(),
        },
      );
    }

    await batch.commit();
  }

  /// Deletes a notification
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

  /// Gets the count of unread notifications for a user
  Future<int> getUnreadCount({required String userId}) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Retrieves a specific notification by ID
  Future<OfferNotificationModel?> getNotificationById({
    required String userId,
    required String notificationId,
  }) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    data['id'] = doc.id;
    return OfferNotificationModel.fromJson(data);
  }
}
