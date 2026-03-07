import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/notification_model.dart';
import '../../data/services/notification_service.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override List<Object?> get props => [];
}

class StartListening extends NotificationEvent {
  final String userId;
  const StartListening(this.userId);
  @override List<Object?> get props => [userId];
}

class StopListening extends NotificationEvent {}

class MarkAsRead extends NotificationEvent {
  final String notificationId;
  const MarkAsRead(this.notificationId);
  @override List<Object?> get props => [notificationId];
}

class MarkAllAsRead extends NotificationEvent {
  final String userId;
  const MarkAllAsRead(this.userId);
  @override List<Object?> get props => [userId];
}

class DeleteNotification extends NotificationEvent {
  final String notificationId;
  const DeleteNotification(this.notificationId);
  @override List<Object?> get props => [notificationId];
}

class _NotificationsUpdated extends NotificationEvent {
  final List<NotificationModel> notifications;
  const _NotificationsUpdated(this.notifications);
  @override List<Object?> get props => [notifications];
}

class NotificationState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<NotificationModel> notifications;
  final int unreadCount;
  final String? fcmToken;

  const NotificationState({this.isLoading = false, this.error, this.notifications = const [], this.unreadCount = 0, this.fcmToken});

  NotificationState copyWith({bool? isLoading, String? error, List<NotificationModel>? notifications, int? unreadCount, String? fcmToken}) {
    return NotificationState(isLoading: isLoading ?? this.isLoading, error: error, notifications: notifications ?? this.notifications, unreadCount: unreadCount ?? this.unreadCount, fcmToken: fcmToken ?? this.fcmToken);
  }

  @override List<Object?> get props => [isLoading, error, notifications, unreadCount, fcmToken];
}

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService _service;
  StreamSubscription<List<NotificationModel>>? _sub;

  NotificationBloc(this._service) : super(const NotificationState()) {
    on<StartListening>(_onStart);
    on<StopListening>(_onStop);
    on<MarkAsRead>(_onMarkRead);
    on<MarkAllAsRead>(_onMarkAllRead);
    on<DeleteNotification>(_onDelete);
    on<_NotificationsUpdated>(_onUpdated);
  }

  Future<void> _onStart(StartListening e, Emitter<NotificationState> emit) async {
    emit(state.copyWith(isLoading: true));
    final token = await _service.initializeFCM();
    emit(state.copyWith(fcmToken: token));
    await _sub?.cancel();
    _sub = _service.notificationsStream(e.userId).listen((list) => add(_NotificationsUpdated(list)));
  }

  Future<void> _onStop(StopListening e, Emitter<NotificationState> emit) async {
    await _sub?.cancel();
    _sub = null;
  }

  void _onUpdated(_NotificationsUpdated e, Emitter<NotificationState> emit) {
    final unread = e.notifications.where((n) => !(n.isRead ?? false)).length;
    emit(state.copyWith(isLoading: false, notifications: e.notifications, unreadCount: unread));
  }

  Future<void> _onMarkRead(MarkAsRead e, Emitter<NotificationState> emit) async {
    await _service.markAsRead(e.notificationId);
  }

  Future<void> _onMarkAllRead(MarkAllAsRead e, Emitter<NotificationState> emit) async {
    await _service.markAllAsRead(e.userId);
  }

  Future<void> _onDelete(DeleteNotification e, Emitter<NotificationState> emit) async {
    await _service.deleteNotification(e.notificationId);
  }

  @override
  Future<void> close() { _sub?.cancel(); return super.close(); }
}