import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/agent_repository.dart';

abstract class AgentEvent extends Equatable {
  const AgentEvent();
  @override List<Object?> get props => [];
}

class LoadAgentProfile extends AgentEvent {
  final String? email, userId;
  const LoadAgentProfile({this.email, this.userId});
  @override List<Object?> get props => [email, userId];
}

class UpdateAgentProfile extends AgentEvent {
  final Map<String, dynamic> userData;
  const UpdateAgentProfile({required this.userData});
  @override List<Object?> get props => [userData];
}

class LoadClients extends AgentEvent {
  final String agentId, requesterId;
  const LoadClients({required this.agentId, required this.requesterId});
  @override List<Object?> get props => [agentId, requesterId];
}

class LoadActivityFeed extends AgentEvent {
  final String agentId, requesterId;
  const LoadActivityFeed({required this.agentId, required this.requesterId});
  @override List<Object?> get props => [agentId, requesterId];
}

class LoadInvitations extends AgentEvent {
  final String inviterUid;
  const LoadInvitations({required this.inviterUid});
  @override List<Object?> get props => [inviterUid];
}

class SendInvitations extends AgentEvent {
  final String inviterUid, inviterName, inviterFullName, signUpUrl, shortLink, logoUrl, requesterId;
  final String? inviterMLS, inviterContact, brokerageName;
  final List<Map<String, dynamic>> invitees;
  const SendInvitations({required this.inviterUid, required this.inviterName, required this.inviterFullName, required this.signUpUrl, required this.shortLink, required this.logoUrl, this.inviterMLS, this.inviterContact, this.brokerageName, required this.invitees, required this.requesterId});
  @override List<Object?> get props => [inviterUid, invitees];
}

class MergeContacts extends AgentEvent {
  final List<Map<String, dynamic>> apiContacts, firebaseInvitations;
  final String selectedTab;
  const MergeContacts({required this.apiContacts, required this.firebaseInvitations, required this.selectedTab});
  @override List<Object?> get props => [apiContacts, firebaseInvitations, selectedTab];
}

class AgentState extends Equatable {
  final bool isLoading, isSending;
  final String? error, successMessage;
  final Map<String, dynamic>? agentProfile;
  final List<Map<String, dynamic>> clients, activities, invitations, mergedContacts;

  const AgentState({this.isLoading = false, this.isSending = false, this.error, this.successMessage, this.agentProfile, this.clients = const [], this.activities = const [], this.invitations = const [], this.mergedContacts = const []});

  AgentState copyWith({bool? isLoading, bool? isSending, String? error, String? successMessage, Map<String, dynamic>? agentProfile, List<Map<String, dynamic>>? clients, List<Map<String, dynamic>>? activities, List<Map<String, dynamic>>? invitations, List<Map<String, dynamic>>? mergedContacts}) {
    return AgentState(isLoading: isLoading ?? this.isLoading, isSending: isSending ?? this.isSending, error: error, successMessage: successMessage, agentProfile: agentProfile ?? this.agentProfile, clients: clients ?? this.clients, activities: activities ?? this.activities, invitations: invitations ?? this.invitations, mergedContacts: mergedContacts ?? this.mergedContacts);
  }

  @override List<Object?> get props => [isLoading, isSending, error, successMessage, agentProfile, clients, activities, invitations, mergedContacts];
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
  }

  Future<void> _onLoadProfile(LoadAgentProfile e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.fetchUserAccount(email: e.email, id: e.userId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)), (d) => emit(state.copyWith(isLoading: false, agentProfile: d)));
  }

  Future<void> _onUpdateProfile(UpdateAgentProfile e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.updateUserAccount(userData: e.userData);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)), (d) => emit(state.copyWith(isLoading: false, agentProfile: d, successMessage: 'Profile updated')));
  }

  Future<void> _onLoadClients(LoadClients e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getAgentClients(agentId: e.agentId, requesterId: e.requesterId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)), (c) => emit(state.copyWith(isLoading: false, clients: c)));
  }

  Future<void> _onLoadActivity(LoadActivityFeed e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final cr = await _repository.getAgentClients(agentId: e.agentId, requesterId: e.requesterId);
    final ar = await _repository.getClientActivities(agentId: e.agentId, requesterId: e.requesterId);
    cr.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (clients) { ar.fold(
        (f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (activities) {
          final enriched = _repository.processAndEnrichActivityFeed(clients: clients, activities: activities);
          emit(state.copyWith(isLoading: false, clients: clients, activities: enriched));
        },
      ); },
    );
  }

  Future<void> _onLoadInvitations(LoadInvitations e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getInvitations(e.inviterUid);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)), (inv) => emit(state.copyWith(isLoading: false, invitations: inv)));
  }

  Future<void> _onSendInvitations(SendInvitations e, Emitter<AgentState> emit) async {
    emit(state.copyWith(isSending: true, error: null));
    final r = await _repository.createBuyerInvitationsWithMessaging(
      inviterUid: e.inviterUid, inviterName: e.inviterName, inviterFullName: e.inviterFullName,
      signUpUrl: e.signUpUrl, shortLink: e.shortLink, logoUrl: e.logoUrl,
      inviterMLS: e.inviterMLS, inviterContact: e.inviterContact, brokerageName: e.brokerageName,
      invitees: e.invitees, requesterId: e.requesterId,
    );
    r.fold((f) => emit(state.copyWith(isSending: false, error: f.message)), (_) => emit(state.copyWith(isSending: false, successMessage: 'Invitations sent')));
  }

  void _onMerge(MergeContacts e, Emitter<AgentState> emit) {
    final merged = _repository.mergeContactsWithInvitations(apiContacts: e.apiContacts, firebaseInvitations: e.firebaseInvitations, selectedTab: e.selectedTab);
    emit(state.copyWith(mergedContacts: merged));
  }
}