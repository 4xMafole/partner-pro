import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/app_enums.dart';
import '../../data/models/offer_model.dart';
import '../../data/models/offer_notification_model.dart';
import '../../data/models/offer_revision_model.dart';
import '../../data/repositories/offer_notification_repository.dart';
import '../../data/repositories/offer_repository.dart';
import '../../../notifications/data/services/notification_service.dart';

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

class AcceptOffer extends OfferEvent {
  final String offerId;
  final String requesterId;
  final String requesterName;
  const AcceptOffer({
    required this.offerId,
    required this.requesterId,
    required this.requesterName,
  });
  @override
  List<Object?> get props => [offerId, requesterId, requesterName];
}

class DeclineOffer extends OfferEvent {
  final String offerId;
  final String requesterId;
  final String requesterName;
  const DeclineOffer({
    required this.offerId,
    required this.requesterId,
    required this.requesterName,
  });
  @override
  List<Object?> get props => [offerId, requesterId, requesterName];
}

class WithdrawOffer extends OfferEvent {
  final String offerId;
  final String requesterId;
  final String requesterName;
  const WithdrawOffer({
    required this.offerId,
    required this.requesterId,
    required this.requesterName,
  });
  @override
  List<Object?> get props => [offerId, requesterId, requesterName];
}

class RequestRevision extends OfferEvent {
  final String offerId;
  final String requesterId;
  final String requesterName;
  final String revisionNotes;
  const RequestRevision({
    required this.offerId,
    required this.requesterId,
    required this.requesterName,
    required this.revisionNotes,
  });
  @override
  List<Object?> get props =>
      [offerId, requesterId, requesterName, revisionNotes];
}

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
  final String? submittingOfferId;
  final String? submissionAction;
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
      this.submittingOfferId,
      this.submissionAction,
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
      String? submittingOfferId,
      String? submissionAction,
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
        submittingOfferId: submittingOfferId,
        submissionAction: submissionAction,
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
        submittingOfferId,
        submissionAction,
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
  final NotificationService _notificationService;

  OfferBloc(
      this._repository, this._notificationRepository, this._notificationService)
      : super(const OfferState()) {
    on<LoadUserOffers>(_onLoadUser);
    on<LoadAgentOffers>(_onLoadAgent);
    on<CreateOffer>(_onCreate);
    on<UpdateOffer>(_onUpdate);
    on<AcceptOffer>(_onAccept);
    on<DeclineOffer>(_onDecline);
    on<WithdrawOffer>(_onWithdraw);
    on<RequestRevision>(_onRequestRevision);
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
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: null,
      submissionAction: 'create',
    ));
    final r = await _repository.createOffer(
        offerData: e.offerData, requesterId: e.requesterId);
    if (r.isLeft()) {
      final failure =
          r.swap().getOrElse(() => throw StateError('Missing failure'));
      emit(state.copyWith(
        isSubmitting: false,
        error: failure.message,
        submittingOfferId: null,
        submissionAction: null,
      ));
      return;
    }

    final result = r.getOrElse(() => <String, dynamic>{});
    final parties = result['parties'] as Map<String, dynamic>? ??
        e.offerData['parties'] as Map<String, dynamic>? ??
        {};
    final agent = parties['agent'] as Map<String, dynamic>? ?? {};
    final agentId =
        agent['id'] as String? ?? result['agentId'] as String? ?? '';
    final propertyMap = result['property'] as Map<String, dynamic>? ??
        e.offerData['property'] as Map<String, dynamic>? ??
        {};
    final propertyTitle = propertyMap['title'] as String? ??
        propertyMap['propertyName'] as String? ??
        '';
    final offerId =
        result['id'] as String? ?? result['offerID'] as String? ?? '';

    if (agentId.isNotEmpty) {
      try {
        await _notificationService.createNotification(
          userId: agentId,
          title: 'New Offer Submitted',
          body: 'A new offer has been submitted for $propertyTitle.',
          type: 'offer',
          data: {'offerId': offerId},
        );
      } catch (_) {}
    }

    emit(state.copyWith(
      isSubmitting: false,
      successMessage: 'Offer created',
      currentDraft: const {},
      submittingOfferId: null,
      submissionAction: null,
    ));
  }

  Future<void> _onUpdate(UpdateOffer e, Emitter<OfferState> emit) async {
    final offerId =
        (e.offerData['id'] ?? e.offerData['offerID'] ?? '').toString();
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: offerId.isEmpty ? null : offerId,
      submissionAction: 'update',
    ));
    final r = await _repository.updateOffer(
        offerData: e.offerData, requesterId: e.requesterId);
    r.fold(
        (f) => emit(state.copyWith(
            isSubmitting: false,
            error: f.message,
            submittingOfferId: null,
            submissionAction: null)),
        (_) => emit(state.copyWith(
            isSubmitting: false,
            successMessage: 'Offer updated',
            submittingOfferId: null,
            submissionAction: null)));
  }

  Future<void> _onAccept(AcceptOffer e, Emitter<OfferState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: e.offerId,
      submissionAction: 'accept',
    ));

    // Find the offer to get its data
    final offer = state.offers.cast<OfferModel?>().firstWhere(
          (o) => o?.id == e.offerId,
          orElse: () => null,
        );
    if (offer == null) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Offer not found',
        submittingOfferId: null,
        submissionAction: null,
      ));
      return;
    }

    final offerData = offer.toJson();
    offerData['status'] = 'accepted';

    final r = await _repository.updateOffer(
      offerData: offerData,
      requesterId: e.requesterId,
      requestorName: e.requesterName,
      requestorRole: 'agent',
      changeNotes: 'Offer accepted',
    );

    r.fold(
      (f) => emit(state.copyWith(
          isSubmitting: false,
          error: f.message,
          submittingOfferId: null,
          submissionAction: null)),
      (_) {
        // Update the offer in local state
        final updatedOffers = state.offers.map((o) {
          if (o.id == e.offerId) {
            return o.copyWith(status: OfferStatus.accepted);
          }
          return o;
        }).toList();

        // Notify the buyer
        final buyerId =
            offer.buyerId.isNotEmpty ? offer.buyerId : offer.buyer.id;
        if (buyerId.isNotEmpty) {
          _notificationService.createNotification(
            userId: buyerId,
            title: 'Offer Accepted!',
            body: 'Your offer for ${offer.property.title} has been accepted.',
            type: 'offer',
            data: {'offerId': e.offerId},
          );
        }

        emit(state.copyWith(
          isSubmitting: false,
          offers: updatedOffers,
          successMessage: 'Offer accepted',
          submittingOfferId: null,
          submissionAction: null,
        ));
      },
    );
  }

  Future<void> _onDecline(DeclineOffer e, Emitter<OfferState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: e.offerId,
      submissionAction: 'decline',
    ));

    final offer = state.offers.cast<OfferModel?>().firstWhere(
          (o) => o?.id == e.offerId,
          orElse: () => null,
        );
    if (offer == null) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Offer not found',
        submittingOfferId: null,
        submissionAction: null,
      ));
      return;
    }

    final offerData = offer.toJson();
    offerData['status'] = 'declined';

    final r = await _repository.updateOffer(
      offerData: offerData,
      requesterId: e.requesterId,
      requestorName: e.requesterName,
      requestorRole: 'agent',
      changeNotes: 'Offer declined',
    );

    r.fold(
      (f) => emit(state.copyWith(
          isSubmitting: false,
          error: f.message,
          submittingOfferId: null,
          submissionAction: null)),
      (_) {
        final updatedOffers = state.offers.map((o) {
          if (o.id == e.offerId) {
            return o.copyWith(status: OfferStatus.declined);
          }
          return o;
        }).toList();

        final buyerId =
            offer.buyerId.isNotEmpty ? offer.buyerId : offer.buyer.id;
        if (buyerId.isNotEmpty) {
          _notificationService.createNotification(
            userId: buyerId,
            title: 'Offer Declined',
            body: 'Your offer for ${offer.property.title} has been declined.',
            type: 'offer',
            data: {'offerId': e.offerId},
          );
        }

        emit(state.copyWith(
          isSubmitting: false,
          offers: updatedOffers,
          successMessage: 'Offer declined',
          submittingOfferId: null,
          submissionAction: null,
        ));
      },
    );
  }

  Future<void> _onWithdraw(WithdrawOffer e, Emitter<OfferState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: e.offerId,
      submissionAction: 'withdraw',
    ));

    final offer = state.offers.cast<OfferModel?>().firstWhere(
          (o) => o?.id == e.offerId,
          orElse: () => null,
        );
    if (offer == null) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Offer not found',
        submittingOfferId: null,
        submissionAction: null,
      ));
      return;
    }

    final offerData = offer.toJson();
    offerData['status'] = 'declined';

    final r = await _repository.updateOffer(
      offerData: offerData,
      requesterId: e.requesterId,
      requestorName: e.requesterName,
      requestorRole: 'buyer',
      changeNotes: 'Offer withdrawn by buyer',
    );

    r.fold(
      (f) => emit(state.copyWith(
          isSubmitting: false,
          error: f.message,
          submittingOfferId: null,
          submissionAction: null)),
      (_) {
        final updatedOffers = state.offers.map((o) {
          if (o.id == e.offerId) {
            return o.copyWith(status: OfferStatus.declined);
          }
          return o;
        }).toList();

        // Notify the agent about withdrawal
        final agentId = offer.agent.id;
        if (agentId.isNotEmpty) {
          _notificationService.createNotification(
            userId: agentId,
            title: 'Offer Withdrawn',
            body:
                '${e.requesterName} has withdrawn their offer on ${offer.property.title}.',
            type: 'offer',
            data: {'offerId': e.offerId},
          );
        }

        emit(state.copyWith(
          isSubmitting: false,
          offers: updatedOffers,
          successMessage: 'Offer withdrawn',
          submittingOfferId: null,
          submissionAction: null,
        ));
      },
    );
  }

  Future<void> _onRequestRevision(
      RequestRevision e, Emitter<OfferState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      successMessage: null,
      submittingOfferId: e.offerId,
      submissionAction: 'request_revision',
    ));

    final offer = state.offers.cast<OfferModel?>().firstWhere(
          (o) => o?.id == e.offerId,
          orElse: () => null,
        );
    if (offer == null) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'Offer not found',
        submittingOfferId: null,
        submissionAction: null,
      ));
      return;
    }

    // Keep status as pending but record a revision note
    final offerData = offer.toJson();
    final r = await _repository.updateOffer(
      offerData: offerData,
      requesterId: e.requesterId,
      requestorName: e.requesterName,
      requestorRole: 'agent',
      changeNotes: e.revisionNotes,
    );

    r.fold(
      (f) => emit(state.copyWith(
          isSubmitting: false,
          error: f.message,
          submittingOfferId: null,
          submissionAction: null)),
      (_) {
        final buyerId =
            offer.buyerId.isNotEmpty ? offer.buyerId : offer.buyer.id;
        if (buyerId.isNotEmpty) {
          _notificationService.createNotification(
            userId: buyerId,
            title: 'Revision Requested',
            body:
                'A revision has been requested for your offer on ${offer.property.title}. Notes: ${e.revisionNotes}',
            type: 'offer',
            data: {'offerId': e.offerId},
          );
        }

        emit(state.copyWith(
          isSubmitting: false,
          successMessage: 'Revision requested',
          submittingOfferId: null,
          submissionAction: null,
        ));
      },
    );
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
