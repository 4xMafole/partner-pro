import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/agent_repository.dart';

abstract class AgentEvent extends Equatable {
  const AgentEvent();
  @override
  List<Object?> get props => [];
}

class LoadAgentProfile extends AgentEvent {
  final String? email, userId;
  const LoadAgentProfile({this.email, this.userId});
  @override
  List<Object?> get props => [email, userId];
}

class UpdateAgentProfile extends AgentEvent {
  final Map<String, dynamic> userData;
  const UpdateAgentProfile({required this.userData});
  @override
  List<Object?> get props => [userData];
}

class LoadClients extends AgentEvent {
  final String agentId, requesterId;
  const LoadClients({required this.agentId, required this.requesterId});
  @override
  List<Object?> get props => [agentId, requesterId];
}

class LoadActivityFeed extends AgentEvent {
  final String agentId, requesterId;
  const LoadActivityFeed({required this.agentId, required this.requesterId});
  @override
  List<Object?> get props => [agentId, requesterId];
}

class LoadInvitations extends AgentEvent {
  final String inviterUid;
  const LoadInvitations({required this.inviterUid});
  @override
  List<Object?> get props => [inviterUid];
}

class SendInvitations extends AgentEvent {
  final String inviterUid,
      inviterName,
      inviterFullName,
      signUpUrl,
      shortLink,
      logoUrl,
      requesterId;
  final String? inviterMLS, inviterContact, brokerageName;
  final List<Map<String, dynamic>> invitees;
  const SendInvitations(
      {required this.inviterUid,
      required this.inviterName,
      required this.inviterFullName,
      required this.signUpUrl,
      required this.shortLink,
      required this.logoUrl,
      this.inviterMLS,
      this.inviterContact,
      this.brokerageName,
      required this.invitees,
      required this.requesterId});
  @override
  List<Object?> get props => [inviterUid, invitees];
}

class MergeContacts extends AgentEvent {
  final List<Map<String, dynamic>> apiContacts, firebaseInvitations;
  final String selectedTab;
  const MergeContacts(
      {required this.apiContacts,
      required this.firebaseInvitations,
      required this.selectedTab});
  @override
  List<Object?> get props => [apiContacts, firebaseInvitations, selectedTab];
}

class LoadBuyerInvitations extends AgentEvent {
  final String buyerEmail;
  const LoadBuyerInvitations({required this.buyerEmail});
  @override
  List<Object?> get props => [buyerEmail];
}

class AcceptInvitation extends AgentEvent {
  final String invitationId, agentId, buyerId, agentName, buyerName, buyerEmail;
  const AcceptInvitation(
      {required this.invitationId,
      required this.agentId,
      required this.buyerId,
      required this.agentName,
      required this.buyerName,
      required this.buyerEmail});
  @override
  List<Object?> get props => [invitationId];
}

class DeclineInvitation extends AgentEvent {
  final String invitationId, buyerEmail;
  const DeclineInvitation(
      {required this.invitationId, required this.buyerEmail});
  @override
  List<Object?> get props => [invitationId];
}

class DeleteInvitation extends AgentEvent {
  final String invitationId, inviterUid;
  const DeleteInvitation(
      {required this.invitationId, required this.inviterUid});
  @override
  List<Object?> get props => [invitationId, inviterUid];
}

class LoadClientDetail extends AgentEvent {
  final String agentId, clientId, requesterId;
  const LoadClientDetail(
      {required this.agentId,
      required this.clientId,
      required this.requesterId});
  @override
  List<Object?> get props => [clientId];
}

class UpdateClientNote extends AgentEvent {
  final String agentId, clientId, noteId, updatedNote;
  const UpdateClientNote(
      {required this.agentId,
      required this.clientId,
      required this.noteId,
      required this.updatedNote});
  @override
  List<Object?> get props => [agentId, clientId, noteId, updatedNote];
}

class DeleteClientNote extends AgentEvent {
  final String agentId, clientId, noteId;
  const DeleteClientNote(
      {required this.agentId, required this.clientId, required this.noteId});
  @override
  List<Object?> get props => [agentId, clientId, noteId];
}

class AddClientNote extends AgentEvent {
  final String agentId, clientId, note;
  const AddClientNote(
      {required this.agentId, required this.clientId, required this.note});
  @override
  List<Object?> get props => [agentId, clientId, note];
}

class UpdateClientShowingAutoApprove extends AgentEvent {
  final String agentId, clientId, relationshipId;
  final bool enabled;
  const UpdateClientShowingAutoApprove({
    required this.agentId,
    required this.clientId,
    required this.relationshipId,
    required this.enabled,
  });
  @override
  List<Object?> get props => [agentId, clientId, relationshipId, enabled];
}

class AgentState extends Equatable {
  final bool isLoading, isSending;
  final String? error, successMessage;
  final Map<String, dynamic>? agentProfile, clientDetail, relationship;
  final List<Map<String, dynamic>> clients,
      activities,
      invitations,
      mergedContacts,
      buyerInvitations,
      clientNotes,
      clientActivities,
      suggestedProperties,
      favoriteProperties,
      savedSearches,
      recentlyViewedProperties;

  const AgentState(
      {this.isLoading = false,
      this.isSending = false,
      this.error,
      this.successMessage,
      this.agentProfile,
      this.clientDetail,
      this.relationship,
      this.clients = const [],
      this.activities = const [],
      this.invitations = const [],
      this.mergedContacts = const [],
      this.buyerInvitations = const [],
      this.clientNotes = const [],
      this.clientActivities = const [],
      this.suggestedProperties = const [],
      this.favoriteProperties = const [],
      this.savedSearches = const [],
      this.recentlyViewedProperties = const []});

  AgentState copyWith(
      {bool? isLoading,
      bool? isSending,
      String? error,
      String? successMessage,
      Map<String, dynamic>? agentProfile,
      Map<String, dynamic>? clientDetail,
      Map<String, dynamic>? relationship,
      List<Map<String, dynamic>>? clients,
      List<Map<String, dynamic>>? activities,
      List<Map<String, dynamic>>? invitations,
      List<Map<String, dynamic>>? mergedContacts,
      List<Map<String, dynamic>>? buyerInvitations,
      List<Map<String, dynamic>>? clientNotes,
      List<Map<String, dynamic>>? clientActivities,
      List<Map<String, dynamic>>? suggestedProperties,
      List<Map<String, dynamic>>? favoriteProperties,
      List<Map<String, dynamic>>? savedSearches,
      List<Map<String, dynamic>>? recentlyViewedProperties}) {
    return AgentState(
        isLoading: isLoading ?? this.isLoading,
        isSending: isSending ?? this.isSending,
        error: error,
        successMessage: successMessage,
        agentProfile: agentProfile ?? this.agentProfile,
        clientDetail: clientDetail ?? this.clientDetail,
        relationship: relationship ?? this.relationship,
        clients: clients ?? this.clients,
        activities: activities ?? this.activities,
        invitations: invitations ?? this.invitations,
        mergedContacts: mergedContacts ?? this.mergedContacts,
        buyerInvitations: buyerInvitations ?? this.buyerInvitations,
        clientNotes: clientNotes ?? this.clientNotes,
        clientActivities: clientActivities ?? this.clientActivities,
        suggestedProperties: suggestedProperties ?? this.suggestedProperties,
        favoriteProperties: favoriteProperties ?? this.favoriteProperties,
        savedSearches: savedSearches ?? this.savedSearches,
        recentlyViewedProperties:
            recentlyViewedProperties ?? this.recentlyViewedProperties);
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSending,
        error,
        successMessage,
        agentProfile,
        clientDetail,
        relationship,
        clients,
        activities,
        invitations,
        mergedContacts,
        buyerInvitations,
        clientNotes,
        clientActivities,
        suggestedProperties,
        favoriteProperties,
        savedSearches,
        recentlyViewedProperties
      ];
}

@injectable
class AgentBloc extends Bloc<AgentEvent, AgentState> {
  final AgentRepository _repository;

  AgentBloc(this._repository) : super(const AgentState()) {
    on<LoadAgentProfile>(_onLoadProfile);
    on<UpdateAgentProfile>(_onUpdateProfile);
    on<LoadClients>(_onLoadClients);
    on<LoadActivityFeed>(_onLoadActivity);
    on<LoadInvitations>(_onLoadInvitations);
    on<SendInvitations>(_onSendInvitations);
    on<MergeContacts>(_onMerge);
    on<LoadBuyerInvitations>(_onLoadBuyerInvitations);
    on<AcceptInvitation>(_onAcceptInvitation);
    on<DeclineInvitation>(_onDeclineInvitation);
    on<DeleteInvitation>(_onDeleteInvitation);
    on<LoadClientDetail>(_onLoadClientDetail);
    on<AddClientNote>(_onAddClientNote);
    on<UpdateClientNote>(_onUpdateClientNote);
    on<DeleteClientNote>(_onDeleteClientNote);
    on<UpdateClientShowingAutoApprove>(_onUpdateClientShowingAutoApprove);
  }

  Future<void> _onLoadProfile(
      LoadAgentProfile e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.fetchUserAccount(email: e.email, id: e.userId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (d) => emit(state.copyWith(isLoading: false, agentProfile: d)));
  }

  Future<void> _onUpdateProfile(
      UpdateAgentProfile e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.updateUserAccount(userData: e.userData);
    r.fold(
        (f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (d) => emit(state.copyWith(
            isLoading: false,
            agentProfile: d,
            successMessage: 'Profile updated')));
  }

  Future<void> _onLoadClients(LoadClients e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getAgentClients(
        agentId: e.agentId, requesterId: e.requesterId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (c) => emit(state.copyWith(isLoading: false, clients: c)));
  }

  Future<void> _onLoadActivity(
      LoadActivityFeed e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final cr = await _repository.getAgentClients(
        agentId: e.agentId, requesterId: e.requesterId);
    final ar = await _repository.getClientActivities(
        agentId: e.agentId, requesterId: e.requesterId);
    cr.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (clients) {
        ar.fold(
          (f) => emit(state.copyWith(isLoading: false, error: f.message)),
          (activities) {
            final enriched = _repository.processAndEnrichActivityFeed(
                clients: clients, activities: activities);
            emit(state.copyWith(
                isLoading: false, clients: clients, activities: enriched));
          },
        );
      },
    );
  }

  Future<void> _onLoadInvitations(
      LoadInvitations e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    await emit.forEach<List<Map<String, dynamic>>>(
      _repository.watchInvitations(e.inviterUid),
      onData: (inv) => state.copyWith(isLoading: false, invitations: inv),
      onError: (e, s) => state.copyWith(isLoading: false, error: e.toString()),
    );
  }

  Future<void> _onSendInvitations(
      SendInvitations e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.createBuyerInvitationsWithMessaging(
      inviterUid: e.inviterUid,
      inviterName: e.inviterName,
      inviterFullName: e.inviterFullName,
      signUpUrl: e.signUpUrl,
      shortLink: e.shortLink,
      logoUrl: e.logoUrl,
      inviterMLS: e.inviterMLS,
      inviterContact: e.inviterContact,
      brokerageName: e.brokerageName,
      invitees: e.invitees,
      requesterId: e.requesterId,
    );
    r.fold((f) => emit(state.copyWith(isSending: false, error: f.message)),
        (_) {
      emit(
          state.copyWith(isSending: false, successMessage: 'Invitations sent'));
      add(LoadInvitations(inviterUid: e.inviterUid));
    });
  }

  void _onMerge(MergeContacts e, Emitter<AgentState> emit) {
    final merged = _repository.mergeContactsWithInvitations(
        apiContacts: e.apiContacts,
        firebaseInvitations: e.firebaseInvitations,
        selectedTab: e.selectedTab);
    emit(state.copyWith(mergedContacts: merged));
  }

  Future<void> _onLoadBuyerInvitations(
      LoadBuyerInvitations e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getBuyerInvitations(e.buyerEmail);
    r.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (inv) => emit(state.copyWith(isLoading: false, buyerInvitations: inv)),
    );
  }

  Future<void> _onAcceptInvitation(
      AcceptInvitation e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.acceptInvitation(
      invitationId: e.invitationId,
      agentId: e.agentId,
      buyerId: e.buyerId,
      agentName: e.agentName,
      buyerName: e.buyerName,
    );
    r.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) {
        emit(state.copyWith(
            isLoading: false, successMessage: 'Invitation accepted'));
        add(LoadBuyerInvitations(buyerEmail: e.buyerEmail));
      },
    );
  }

  Future<void> _onDeclineInvitation(
      DeclineInvitation e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.declineInvitation(e.invitationId);
    r.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) {
        emit(state.copyWith(
            isLoading: false, successMessage: 'Invitation declined'));
        add(LoadBuyerInvitations(buyerEmail: e.buyerEmail));
      },
    );
  }

  Future<void> _onDeleteInvitation(
      DeleteInvitation e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.deleteInvitation(e.invitationId);
    r.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) {
        emit(state.copyWith(
            isLoading: false, successMessage: 'Invitation deleted'));
        add(LoadInvitations(inviterUid: e.inviterUid));
      },
    );
  }

  Future<void> _onLoadClientDetail(
      LoadClientDetail e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final profileResult = await _repository.fetchUserAccount(id: e.clientId);
    final notesResult = await _repository.getClientNotes(
        agentId: e.agentId, clientId: e.clientId);
    // Get activities filtered to this client
    final activitiesResult = await _repository.getClientActivities(
        agentId: e.agentId, requesterId: e.requesterId);
    final intelligenceResult = await _repository.getClientPropertyIntelligence(
        clientId: e.clientId, agentId: e.agentId);
    final relationshipResult = await _repository.getRelationship(
        agentId: e.agentId, buyerId: e.clientId);

    profileResult.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (profile) {
        final notes =
            notesResult.fold((_) => <Map<String, dynamic>>[], (n) => n);
        final allActivities =
            activitiesResult.fold((_) => <Map<String, dynamic>>[], (a) => a);
        final intelligence = intelligenceResult.fold(
            (_) => <String, List<Map<String, dynamic>>>{}, (i) => i);
        final relationship =
            relationshipResult.fold((_) => <String, dynamic>{}, (r) => r ?? {});
        final clientActivities =
            allActivities.where((a) => a['user_id'] == e.clientId).toList();
        emit(state.copyWith(
            isLoading: false,
            clientDetail: profile,
            relationship: relationship,
            clientNotes: notes,
            clientActivities: clientActivities,
            suggestedProperties:
                intelligence['suggestedProperties'] ?? const [],
            favoriteProperties: intelligence['favoriteProperties'] ?? const [],
            savedSearches: intelligence['savedSearches'] ?? const [],
            recentlyViewedProperties:
                intelligence['recentlyViewedProperties'] ?? const []));
      },
    );
  }

  Future<void> _onAddClientNote(
      AddClientNote e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.addClientNote(
        agentId: e.agentId, clientId: e.clientId, note: e.note);
    r.fold(
      (f) => emit(state.copyWith(isSending: false, error: f.message)),
      (_) {
        emit(state.copyWith(isSending: false, successMessage: 'Note added'));
        add(LoadClientDetail(
            agentId: e.agentId, clientId: e.clientId, requesterId: e.agentId));
      },
    );
  }

  Future<void> _onUpdateClientNote(
      UpdateClientNote e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.updateClientNote(
        noteId: e.noteId, updatedNote: e.updatedNote);
    r.fold(
      (f) => emit(state.copyWith(isSending: false, error: f.message)),
      (_) {
        emit(state.copyWith(isSending: false, successMessage: 'Note updated'));
        add(LoadClientDetail(
            agentId: e.agentId, clientId: e.clientId, requesterId: e.agentId));
      },
    );
  }

  Future<void> _onDeleteClientNote(
      DeleteClientNote e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.deleteClientNote(noteId: e.noteId);
    r.fold(
      (f) => emit(state.copyWith(isSending: false, error: f.message)),
      (_) {
        emit(state.copyWith(isSending: false, successMessage: 'Note deleted'));
        add(LoadClientDetail(
            agentId: e.agentId, clientId: e.clientId, requesterId: e.agentId));
      },
    );
  }

  Future<void> _onUpdateClientShowingAutoApprove(
      UpdateClientShowingAutoApprove e, Emitter<AgentState> emit) async {
    // Optimistic update
    if (state.relationship != null) {
      final updatedRelationship =
          Map<String, dynamic>.from(state.relationship!);
      // Keep top-level value in sync because UI reads relationship['autoApproveShowings'].
      updatedRelationship['autoApproveShowings'] = e.enabled;
      final prefs = updatedRelationship['preferences'] != null
          ? Map<String, dynamic>.from(updatedRelationship['preferences'] as Map)
          : <String, dynamic>{};
      prefs['autoApproveShowings'] = e.enabled;
      updatedRelationship['preferences'] = prefs;
      emit(state.copyWith(relationship: updatedRelationship));
    }

    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.updateRelationshipPreferences(
      relationshipId: e.relationshipId,
      updates: {'autoApproveShowings': e.enabled},
    );
    r.fold(
      (f) => emit(state.copyWith(isSending: false, error: f.message)),
      (_) {
        emit(state.copyWith(
          isSending: false,
          successMessage:
              e.enabled ? 'Auto-approve enabled' : 'Auto-approve disabled',
        ));
        // We don't need to do a full LoadClientDetail here as we have already optimistically updated the relationship locally.
      },
    );
  }
}
