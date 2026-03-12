import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/notification_model.dart';
import '../../data/services/notification_service.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class StartListening extends NotificationEvent {
  final String userId;
  const StartListening(this.userId);
  @override
  List<Object?> get props => [userId];
}

class StopListening extends NotificationEvent {}

class MarkAsRead extends NotificationEvent {
  final String userId;
  final String notificationId;
  const MarkAsRead(this.userId, this.notificationId);
  @override
  List<Object?> get props => [userId, notificationId];
}

class MarkAllAsRead extends NotificationEvent {
  final String userId;
  const MarkAllAsRead(this.userId);
  @override
  List<Object?> get props => [userId];
}

class DeleteNotification extends NotificationEvent {
  final String userId;
  final String notificationId;
  const DeleteNotification(this.userId, this.notificationId);
  @override
  List<Object?> get props => [userId, notificationId];
}

class _NotificationsUpdated extends NotificationEvent {
  final List<NotificationModel> notifications;
  const _NotificationsUpdated(this.notifications);
  @override
  List<Object?> get props => [notifications];
}

class ClearLatestNotification extends NotificationEvent {}

class NotificationState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<NotificationModel> notifications;
  final int unreadCount;
  final String? fcmToken;

  /// Set when a new unread notification arrives (cleared after display).
  final NotificationModel? latestNotification;

  const NotificationState(
      {this.isLoading = false,
      this.error,
      this.notifications = const [],
      this.unreadCount = 0,
      this.fcmToken,
      this.latestNotification});

  NotificationState copyWith(
      {bool? isLoading,
      String? error,
      List<NotificationModel>? notifications,
      int? unreadCount,
      String? fcmToken,
      NotificationModel? latestNotification,
      bool clearLatest = false}) {
    return NotificationState(
        isLoading: isLoading ?? this.isLoading,
        error: error,
        notifications: notifications ?? this.notifications,
        unreadCount: unreadCount ?? this.unreadCount,
        fcmToken: fcmToken ?? this.fcmToken,
        latestNotification: clearLatest
            ? null
            : (latestNotification ?? this.latestNotification));
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        notifications,
        unreadCount,
        fcmToken,
        latestNotification
      ];
}

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService _service;
  StreamSubscription<List<NotificationModel>>? _sub;
  Set<String> _knownIds = {};
  bool _isFirstLoad = true;

  NotificationBloc(this._service) : super(const NotificationState()) {
    on<StartListening>(_onStart);
    on<StopListening>(_onStop);
    on<MarkAsRead>(_onMarkRead);
    on<MarkAllAsRead>(_onMarkAllRead);
    on<DeleteNotification>(_onDelete);
    on<_NotificationsUpdated>(_onUpdated);
    on<ClearLatestNotification>(
        (_, emit) => emit(state.copyWith(clearLatest: true)));
  }

  Future<void> _onStart(
      StartListening e, Emitter<NotificationState> emit) async {
    emit(state.copyWith(isLoading: true));
    _isFirstLoad = true;
    _knownIds = {};
    final token = await _service.initializeFCM();
    emit(state.copyWith(fcmToken: token));
    await _sub?.cancel();
    _sub = _service
        .notificationsStream(e.userId)
        .listen((list) => add(_NotificationsUpdated(list)));
  }

  Future<void> _onStop(StopListening e, Emitter<NotificationState> emit) async {
    await _sub?.cancel();
    _sub = null;
  }

  void _onUpdated(_NotificationsUpdated e, Emitter<NotificationState> emit) {
    final sorted = List<NotificationModel>.from(e.notifications)
      ..sort((a, b) {
        if (a.isRead != b.isRead) return a.isRead ? 1 : -1;
        final aTime = a.createdAt ?? DateTime(2000);
        final bTime = b.createdAt ?? DateTime(2000);
        return bTime.compareTo(aTime);
      });
    final unread = sorted.where((n) => !n.isRead).length;

    // Detect newly arrived unread notifications (skip initial load)
    NotificationModel? latest;
    final currentIds = sorted.map((n) => n.id).toSet();
    if (!_isFirstLoad) {
      final newUnread =
          sorted.where((n) => !n.isRead && !_knownIds.contains(n.id));
      if (newUnread.isNotEmpty) {
        latest = newUnread.first;
      }
    }
    _knownIds = currentIds;
    _isFirstLoad = false;

    emit(state.copyWith(
      isLoading: false,
      notifications: sorted,
      unreadCount: unread,
      latestNotification: latest,
      clearLatest: latest == null,
    ));
  }

  Future<void> _onMarkRead(
      MarkAsRead e, Emitter<NotificationState> emit) async {
    await _service.markAsRead(
        userId: e.userId, notificationId: e.notificationId);
  }

  Future<void> _onMarkAllRead(
      MarkAllAsRead e, Emitter<NotificationState> emit) async {
    await _service.markAllAsRead(e.userId);
  }

  Future<void> _onDelete(
      DeleteNotification e, Emitter<NotificationState> emit) async {
    await _service.deleteNotification(
        userId: e.userId, notificationId: e.notificationId);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
