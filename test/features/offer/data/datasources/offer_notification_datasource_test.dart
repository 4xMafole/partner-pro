import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:partner_pro/features/offer/data/datasources/offer_notification_datasource.dart';
import 'package:partner_pro/features/offer/data/models/offer_notification_model.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late OfferNotificationDataSource datasource;

  const userId = 'user_123';
  const offerId = 'offer_123';

  OfferNotificationModel buildNotification({
    required String recipientUserId,
    required String actorUserId,
    String actorName = 'Test Actor',
    OfferNotificationType type = OfferNotificationType.statusChanged,
    bool isRead = false,
  }) {
    return OfferNotificationModel(
      recipientUserId: recipientUserId,
      actorUserId: actorUserId,
      actorName: actorName,
      type: type,
      offerId: offerId,
      propertyAddress: '123 Main St, Austin, TX',
      title: 'Offer Status Changed',
      message: 'The offer has been moved to pending.',
      createdAt: DateTime(2026, 3, 10, 10),
      isRead: isRead,
    );
  }

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = OfferNotificationDataSource(firestore);
  });

  group('OfferNotificationDataSource', () {
    test('createNotification stores notification with generated id', () async {
      final notification = buildNotification(
        recipientUserId: userId,
        actorUserId: 'actor_123',
      );

      final created = await datasource.createNotification(
        recipientUserId: userId,
        notification: notification,
      );

      expect(created.id, isNotEmpty);
      expect(created.recipientUserId, userId);
      expect(created.offerId, offerId);
    });

    test('getUserNotifications returns notifications', () async {
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_1',
        ),
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_2',
        ),
      );

      final notifications =
          await datasource.getUserNotifications(userId: userId);

      expect(notifications.length, 2);
    });

    test('getUserNotifications filters unread only', () async {
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_1',
          isRead: false,
        ),
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_2',
          isRead: true,
        ),
      );

      final unreadOnly = await datasource.getUserNotifications(
        userId: userId,
        unreadOnly: true,
      );

      expect(unreadOnly.length, 1);
      expect(unreadOnly.first.isRead, false);
    });

    test('getUserNotifications respects limit parameter', () async {
      for (int i = 0; i < 5; i++) {
        await datasource.createNotification(
          recipientUserId: userId,
          notification: buildNotification(
            recipientUserId: userId,
            actorUserId: 'actor_$i',
          ),
        );
      }

      final limited = await datasource.getUserNotifications(
        userId: userId,
        limit: 3,
      );

      expect(limited.length, 3);
    });

    test('deleteNotification removes notification from Firestore', () async {
      final created = await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_123',
        ),
      );

      await datasource.deleteNotification(
        userId: userId,
        notificationId: created.id,
      );

      final deleted = await datasource.getNotificationById(
        userId: userId,
        notificationId: created.id,
      );

      expect(deleted, null);
    });

    test('getUnreadCount returns count of unread notifications', () async {
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_1',
          isRead: false,
        ),
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_2',
          isRead: false,
        ),
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_3',
          isRead: true,
        ),
      );

      final count = await datasource.getUnreadCount(userId: userId);

      expect(count, 2);
    });

    test('getOfferNotifications returns notifications for specific offer',
        () async {
      final offerId1 = 'offer_1';
      final offerId2 = 'offer_2';

      final notif1 = buildNotification(
        recipientUserId: userId,
        actorUserId: 'actor_1',
      ).copyWith(offerId: offerId1);

      final notif2 = buildNotification(
        recipientUserId: userId,
        actorUserId: 'actor_2',
      ).copyWith(offerId: offerId2);

      final notif3 = buildNotification(
        recipientUserId: userId,
        actorUserId: 'actor_3',
      ).copyWith(offerId: offerId1);

      await datasource.createNotification(
        recipientUserId: userId,
        notification: notif1,
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: notif2,
      );
      await datasource.createNotification(
        recipientUserId: userId,
        notification: notif3,
      );

      final offerNotifications = await datasource.getOfferNotifications(
        userId: userId,
        offerId: offerId1,
      );

      expect(offerNotifications.length, 2);
      expect(offerNotifications.every((n) => n.offerId == offerId1), true);
    });

    test('getNotificationById returns correct notification', () async {
      final created = await datasource.createNotification(
        recipientUserId: userId,
        notification: buildNotification(
          recipientUserId: userId,
          actorUserId: 'actor_123',
        ),
      );

      final found = await datasource.getNotificationById(
        userId: userId,
        notificationId: created.id,
      );

      expect(found?.id, created.id);
      expect(found?.recipientUserId, userId);
      expect(found?.offerId, offerId);
    });

    test('getNotificationById returns null for nonexistent notification',
        () async {
      final found = await datasource.getNotificationById(
        userId: userId,
        notificationId: 'nonexistent_123',
      );

      expect(found, null);
    });
  });
}
