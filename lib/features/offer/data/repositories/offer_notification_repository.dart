import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/offer_notification_datasource.dart';
import '../models/offer_notification_model.dart';

/// Repository for offer notification operations with error handling
@lazySingleton
class OfferNotificationRepository {
  final OfferNotificationDataSource _datasource;

  OfferNotificationRepository(this._datasource);

  /// Creates a new notification for a user
  Future<Either<Failure, OfferNotificationModel>> createNotification({
    required String recipientUserId,
    required OfferNotificationModel notification,
  }) async {
    try {
      final result = await _datasource.createNotification(
        recipientUserId: recipientUserId,
        notification: notification,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create notification: $e'));
    }
  }

  /// Retrieves all notifications for a user
  Future<Either<Failure, List<OfferNotificationModel>>> getUserNotifications({
    required String userId,
    bool? unreadOnly,
    int? limit,
  }) async {
    try {
      final notifications = await _datasource.getUserNotifications(
        userId: userId,
        unreadOnly: unreadOnly,
        limit: limit,
      );
      return Right(notifications);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch notifications: $e'));
    }
  }

  /// Streams real-time notifications for a user
  Stream<Either<Failure, List<OfferNotificationModel>>>
      streamUserNotifications({
    required String userId,
    bool? unreadOnly,
    int? limit,
  }) {
    try {
      return _datasource
          .streamUserNotifications(
              userId: userId, unreadOnly: unreadOnly, limit: limit)
          .map((notifications) =>
              Right<Failure, List<OfferNotificationModel>>(notifications))
          .handleError((error) {
        if (error is ServerException) {
          return Left<Failure, List<OfferNotificationModel>>(
            ServerFailure(message: error.message, code: error.statusCode),
          );
        }
        return Left<Failure, List<OfferNotificationModel>>(
          ServerFailure(message: 'Failed to stream notifications: $error'),
        );
      });
    } catch (e) {
      return Stream.value(
        Left(ServerFailure(message: 'Failed to stream notifications: $e')),
      );
    }
  }

  /// Retrieves notifications for a specific offer
  Future<Either<Failure, List<OfferNotificationModel>>> getOfferNotifications({
    required String userId,
    required String offerId,
    int? limit,
  }) async {
    try {
      final notifications = await _datasource.getOfferNotifications(
        userId: userId,
        offerId: offerId,
        limit: limit,
      );
      return Right(notifications);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to fetch offer notifications: $e'));
    }
  }

  /// Marks a notification as read
  Future<Either<Failure, void>> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    try {
      await _datasource.markAsRead(
        userId: userId,
        notificationId: notificationId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to mark notification as read: $e'));
    }
  }

  /// Marks all unread notifications as read for a user
  Future<Either<Failure, void>> markAllAsRead({
    required String userId,
  }) async {
    try {
      await _datasource.markAllAsRead(userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to mark all notifications as read: $e'));
    }
  }

  /// Deletes a notification
  Future<Either<Failure, void>> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    try {
      await _datasource.deleteNotification(
        userId: userId,
        notificationId: notificationId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete notification: $e'));
    }
  }

  /// Gets the count of unread notifications for a user
  Future<Either<Failure, int>> getUnreadCount({
    required String userId,
  }) async {
    try {
      final count = await _datasource.getUnreadCount(userId: userId);
      return Right(count);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch unread count: $e'));
    }
  }

  /// Retrieves a specific notification by ID
  Future<Either<Failure, OfferNotificationModel>> getNotificationById({
    required String userId,
    required String notificationId,
  }) async {
    try {
      final notification = await _datasource.getNotificationById(
        userId: userId,
        notificationId: notificationId,
      );
      if (notification == null) {
        return Left(
            ServerFailure(message: 'Notification not found', code: 404));
      }
      return Right(notification);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch notification: $e'));
    }
  }
}
