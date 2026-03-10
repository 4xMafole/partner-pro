import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/offer_model.dart';
import '../../data/models/offer_notification_model.dart';
import '../../data/models/offer_revision_model.dart';
import '../../data/repositories/offer_notification_repository.dart';
import '../../data/repositories/offer_repository.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserOffers extends OfferEvent {
  final String requesterId;
  final String? propertyId, buyerId, sellerId, status;
  const LoadUserOffers(
      {required this.requesterId,
      this.propertyId,
      this.buyerId,
      this.sellerId,
      this.status});
  @override
  List<Object?> get props => [requesterId, propertyId, status];
}

class LoadAgentOffers extends OfferEvent {
  final String requesterId;
  final String? status;
  const LoadAgentOffers({required this.requesterId, this.status});
  @override
  List<Object?> get props => [requesterId, status];
}

class CreateOffer extends OfferEvent {
  final Map<String, dynamic> offerData;
  final String requesterId;
  const CreateOffer({required this.offerData, required this.requesterId});
  @override
  List<Object?> get props => [offerData, requesterId];
}

class UpdateOffer extends OfferEvent {
  final Map<String, dynamic> offerData;
  final String requesterId;
  const UpdateOffer({required this.offerData, required this.requesterId});
  @override
  List<Object?> get props => [offerData, requesterId];
}

class CompareOffers extends OfferEvent {
  final Map<String, dynamic> newOffer, oldOffer;
  const CompareOffers({required this.newOffer, required this.oldOffer});
  @override
  List<Object?> get props => [newOffer, oldOffer];
}

class LoadOfferRevisions extends OfferEvent {
  final String offerId;
  final int? limit;
  const LoadOfferRevisions({required this.offerId, this.limit});
  @override
  List<Object?> get props => [offerId, limit];
}

class UpdateOfferDraft extends OfferEvent {
  final Map<String, dynamic> draftData;
  const UpdateOfferDraft({required this.draftData});
  @override
  List<Object?> get props => [draftData];
}

class ClearOfferDraft extends OfferEvent {}

class LoadUserNotifications extends OfferEvent {
  final String userId;
  final bool? unreadOnly;
  final int? limit;
  const LoadUserNotifications({
    required this.userId,
    this.unreadOnly,
    this.limit,
  });
  @override
  List<Object?> get props => [userId, unreadOnly, limit];
}

class MarkNotificationAsRead extends OfferEvent {
  final String userId;
  final String notificationId;
  const MarkNotificationAsRead({
    required this.userId,
    required this.notificationId,
  });
  @override
  List<Object?> get props => [userId, notificationId];
}

class MarkAllNotificationsAsRead extends OfferEvent {
  final String userId;
  const MarkAllNotificationsAsRead({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class DeleteNotification extends OfferEvent {
  final String userId;
  final String notificationId;
  const DeleteNotification({
    required this.userId,
    required this.notificationId,
  });
  @override
  List<Object?> get props => [userId, notificationId];
}

class OfferState extends Equatable {
  final bool isLoading, isSubmitting, hasChanges;
  final String? error, successMessage;
  final List<OfferModel> offers;
  final List<OfferRevisionModel> revisions;
  final List<OfferNotificationModel> notifications;
  final int unreadNotificationCount;
  final Map<String, dynamic> currentDraft;
  final List<String> changedFields;

  const OfferState(
      {this.isLoading = false,
      this.isSubmitting = false,
      this.error,
      this.successMessage,
      this.offers = const [],
      this.revisions = const [],
      this.notifications = const [],
      this.unreadNotificationCount = 0,
      this.currentDraft = const {},
      this.hasChanges = false,
      this.changedFields = const []});

  OfferState copyWith(
      {bool? isLoading,
      bool? isSubmitting,
      String? error,
      String? successMessage,
      List<OfferModel>? offers,
      List<OfferRevisionModel>? revisions,
      List<OfferNotificationModel>? notifications,
      int? unreadNotificationCount,
      Map<String, dynamic>? currentDraft,
      bool? hasChanges,
      List<String>? changedFields}) {
    return OfferState(
        isLoading: isLoading ?? this.isLoading,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        error: error,
        successMessage: successMessage,
        offers: offers ?? this.offers,
        revisions: revisions ?? this.revisions,
        notifications: notifications ?? this.notifications,
        unreadNotificationCount:
            unreadNotificationCount ?? this.unreadNotificationCount,
        currentDraft: currentDraft ?? this.currentDraft,
        hasChanges: hasChanges ?? this.hasChanges,
        changedFields: changedFields ?? this.changedFields);
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSubmitting,
        error,
        successMessage,
        offers,
        revisions,
        notifications,
        unreadNotificationCount,
        currentDraft,
        hasChanges,
        changedFields
      ];
}

@injectable
class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository _repository;
  final OfferNotificationRepository _notificationRepository;

  OfferBloc(this._repository, this._notificationRepository)
      : super(const OfferState()) {
    on<LoadUserOffers>(_onLoadUser);
    on<LoadAgentOffers>(_onLoadAgent);
    on<CreateOffer>(_onCreate);
    on<UpdateOffer>(_onUpdate);
    on<CompareOffers>(_onCompare);
    on<LoadOfferRevisions>(_onLoadRevisions);
    on<UpdateOfferDraft>(_onDraft);
    on<ClearOfferDraft>(_onClear);
    on<LoadUserNotifications>(_onLoadNotifications);
    on<MarkNotificationAsRead>(_onMarkAsRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllAsRead);
    on<DeleteNotification>(_onDeleteNotification);
  }

  Future<void> _onLoadUser(LoadUserOffers e, Emitter<OfferState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getUserOffers(
        requesterId: e.requesterId,
        propertyId: e.propertyId,
        buyerId: e.buyerId,
        sellerId: e.sellerId,
        status: e.status);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (o) => emit(state.copyWith(isLoading: false, offers: o)));
  }

  Future<void> _onLoadAgent(LoadAgentOffers e, Emitter<OfferState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getAgentOffers(
        requesterId: e.requesterId, status: e.status);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (o) => emit(state.copyWith(isLoading: false, offers: o)));
  }

  Future<void> _onCreate(CreateOffer e, Emitter<OfferState> emit) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    final r = await _repository.createOffer(
        offerData: e.offerData, requesterId: e.requesterId);
    r.fold(
        (f) => emit(state.copyWith(isSubmitting: false, error: f.message)),
        (_) => emit(state.copyWith(
            isSubmitting: false,
            successMessage: 'Offer created',
            currentDraft: const {})));
  }

  Future<void> _onUpdate(UpdateOffer e, Emitter<OfferState> emit) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    final r = await _repository.updateOffer(
        offerData: e.offerData, requesterId: e.requesterId);
    r.fold(
        (f) => emit(state.copyWith(isSubmitting: false, error: f.message)),
        (_) => emit(state.copyWith(
            isSubmitting: false, successMessage: 'Offer updated')));
  }

  void _onCompare(CompareOffers e, Emitter<OfferState> emit) {
    final has = _repository.compareOffers(e.newOffer, e.oldOffer);
    final fields = _repository.getChangedFields(e.newOffer, e.oldOffer);
    emit(state.copyWith(hasChanges: has, changedFields: fields));
  }

  Future<void> _onLoadRevisions(
      LoadOfferRevisions e, Emitter<OfferState> emit) async {
    final r =
        await _repository.getOfferRevisions(offerId: e.offerId, limit: e.limit);
    r.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (revisions) => emit(state.copyWith(revisions: revisions)),
    );
  }

  void _onDraft(UpdateOfferDraft e, Emitter<OfferState> emit) {
    emit(state.copyWith(currentDraft: {...state.currentDraft, ...e.draftData}));
  }

  void _onClear(ClearOfferDraft e, Emitter<OfferState> emit) {
    emit(state.copyWith(currentDraft: const {}, hasChanges: false));
  }

  Future<void> _onLoadNotifications(
      LoadUserNotifications e, Emitter<OfferState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _notificationRepository.getUserNotifications(
      userId: e.userId,
      unreadOnly: e.unreadOnly,
      limit: e.limit,
    );
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (notifications) {
        final unreadCount = notifications.where((n) => !n.isRead).length;
        emit(state.copyWith(
          isLoading: false,
          notifications: notifications,
          unreadNotificationCount: unreadCount,
        ));
      },
    );
  }

  Future<void> _onMarkAsRead(
      MarkNotificationAsRead e, Emitter<OfferState> emit) async {
    final result = await _notificationRepository.markAsRead(
      userId: e.userId,
      notificationId: e.notificationId,
    );
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (_) {
        final updatedNotifications = state.notifications.map((n) {
          if (n.id == e.notificationId) {
            return n.copyWith(isRead: true, readAt: DateTime.now());
          }
          return n;
        }).toList();
        final unreadCount = updatedNotifications.where((n) => !n.isRead).length;
        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadNotificationCount: unreadCount,
        ));
      },
    );
  }

  Future<void> _onMarkAllAsRead(
      MarkAllNotificationsAsRead e, Emitter<OfferState> emit) async {
    final result =
        await _notificationRepository.markAllAsRead(userId: e.userId);
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (_) {
        final updatedNotifications = state.notifications.map((n) {
          return n.copyWith(isRead: true, readAt: DateTime.now());
        }).toList();
        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadNotificationCount: 0,
        ));
      },
    );
  }

  Future<void> _onDeleteNotification(
      DeleteNotification e, Emitter<OfferState> emit) async {
    final result = await _notificationRepository.deleteNotification(
      userId: e.userId,
      notificationId: e.notificationId,
    );
    result.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (_) {
        final updatedNotifications =
            state.notifications.where((n) => n.id != e.notificationId).toList();
        final unreadCount = updatedNotifications.where((n) => !n.isRead).length;
        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadNotificationCount: unreadCount,
        ));
      },
    );
  }
}
