/// Unit tests for AgentBloc — Sprint 2.4 features
///
/// Tests buyer invitation, client detail, and client notes flows.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'package:partner_pro/features/agent/presentation/bloc/agent_bloc.dart';
import 'package:partner_pro/features/agent/data/repositories/agent_repository.dart';
import 'package:partner_pro/core/error/failures.dart';

class MockAgentRepository extends Mock implements AgentRepository {}

void main() {
  late AgentBloc bloc;
  late MockAgentRepository mockRepository;

  setUp(() {
    mockRepository = MockAgentRepository();
    bloc = AgentBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  // ═══════════════════════════════════════════════════════════════
  // LoadBuyerInvitations
  // ═══════════════════════════════════════════════════════════════

  group('AgentBloc - LoadBuyerInvitations', () {
    const testEmail = 'buyer@example.com';
    final testInvitations = [
      {'id': 'inv1', 'agentName': 'Agent A', 'status': 'pending'},
      {'id': 'inv2', 'agentName': 'Agent B', 'status': 'pending'},
    ];

    blocTest<AgentBloc, AgentState>(
      'emits [loading, loaded] with buyerInvitations when successful',
      build: () {
        when(() => mockRepository.getBuyerInvitations(testEmail))
            .thenAnswer((_) async => Right(testInvitations));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const LoadBuyerInvitations(buyerEmail: testEmail)),
      expect: () => [
        const AgentState(isLoading: true),
        AgentState(isLoading: false, buyerInvitations: testInvitations),
      ],
      verify: (_) {
        verify(() => mockRepository.getBuyerInvitations(testEmail)).called(1);
      },
    );

    blocTest<AgentBloc, AgentState>(
      'emits [loading, error] when fetching invitations fails',
      build: () {
        when(() => mockRepository.getBuyerInvitations(testEmail)).thenAnswer(
            (_) async =>
                const Left(FirestoreFailure(message: 'Network error')));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const LoadBuyerInvitations(buyerEmail: testEmail)),
      expect: () => [
        const AgentState(isLoading: true),
        const AgentState(isLoading: false, error: 'Network error'),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // AcceptInvitation
  // ═══════════════════════════════════════════════════════════════

  group('AgentBloc - AcceptInvitation', () {
    const event = AcceptInvitation(
      invitationId: 'inv1',
      agentId: 'agent1',
      buyerId: 'buyer1',
      agentName: 'Agent A',
      buyerName: 'Buyer B',
      buyerEmail: 'buyer@example.com',
    );

    blocTest<AgentBloc, AgentState>(
      'emits [loading, success] then re-loads invitations on accept',
      build: () {
        when(() => mockRepository.acceptInvitation(
              invitationId: 'inv1',
              agentId: 'agent1',
              buyerId: 'buyer1',
              agentName: 'Agent A',
              buyerName: 'Buyer B',
            )).thenAnswer((_) async => const Right(null));
        when(() => mockRepository.getBuyerInvitations('buyer@example.com'))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AgentState(isLoading: true),
        const AgentState(
            isLoading: false, successMessage: 'Invitation accepted'),
        // Re-load triggers
        const AgentState(isLoading: true),
        const AgentState(isLoading: false, buyerInvitations: []),
      ],
      verify: (_) {
        verify(() => mockRepository.acceptInvitation(
              invitationId: 'inv1',
              agentId: 'agent1',
              buyerId: 'buyer1',
              agentName: 'Agent A',
              buyerName: 'Buyer B',
            )).called(1);
        verify(() => mockRepository.getBuyerInvitations('buyer@example.com'))
            .called(1);
      },
    );

    blocTest<AgentBloc, AgentState>(
      'emits [loading, error] when accept fails',
      build: () {
        when(() => mockRepository.acceptInvitation(
              invitationId: 'inv1',
              agentId: 'agent1',
              buyerId: 'buyer1',
              agentName: 'Agent A',
              buyerName: 'Buyer B',
            )).thenAnswer((_) async =>
            const Left(FirestoreFailure(message: 'Failed to accept')));
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AgentState(isLoading: true),
        const AgentState(isLoading: false, error: 'Failed to accept'),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // DeclineInvitation
  // ═══════════════════════════════════════════════════════════════

  group('AgentBloc - DeclineInvitation', () {
    const event = DeclineInvitation(
      invitationId: 'inv2',
      buyerEmail: 'buyer@example.com',
    );

    blocTest<AgentBloc, AgentState>(
      'emits [loading, success] then re-loads invitations on decline',
      build: () {
        when(() => mockRepository.declineInvitation('inv2'))
            .thenAnswer((_) async => const Right(null));
        when(() => mockRepository.getBuyerInvitations('buyer@example.com'))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(event),
      expect: () => [
        const AgentState(isLoading: true),
        const AgentState(
            isLoading: false, successMessage: 'Invitation declined'),
        const AgentState(isLoading: true),
        const AgentState(isLoading: false, buyerInvitations: []),
      ],
      verify: (_) {
        verify(() => mockRepository.declineInvitation('inv2')).called(1);
      },
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // LoadClientDetail
  // ═══════════════════════════════════════════════════════════════

  group('AgentBloc - LoadClientDetail', () {
    const agentId = 'agent1';
    const clientId = 'client1';
    final clientProfile = {
      'uid': clientId,
      'email': 'client@example.com',
      'first_name': 'Test',
      'last_name': 'Client'
    };
    final clientNotes = [
      {'note': 'Interested in 3BR', 'createdAt': '2024-01-01'}
    ];
    final allActivities = [
      {'user_id': clientId, 'activityType': 'search', 'query': 'Austin'},
      {'user_id': 'other_client', 'activityType': 'offer', 'amount': 500000},
    ];

    blocTest<AgentBloc, AgentState>(
      'emits [loading, loaded] with client detail, notes, and filtered activities',
      build: () {
        when(() =>
                mockRepository.fetchUserAccount(id: clientId))
            .thenAnswer((_) async => Right(clientProfile));
        when(() => mockRepository.getClientNotes(
                agentId: agentId, clientId: clientId))
            .thenAnswer((_) async => Right(clientNotes));
        when(() => mockRepository.getClientActivities(
                agentId: agentId, requesterId: agentId))
            .thenAnswer((_) async => Right(allActivities));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadClientDetail(
          agentId: agentId, clientId: clientId, requesterId: agentId)),
      expect: () => [
        const AgentState(isLoading: true),
        AgentState(
          isLoading: false,
          clientDetail: clientProfile,
          clientNotes: clientNotes,
          clientActivities: [allActivities[0]], // Only client1's activities
        ),
      ],
    );

    blocTest<AgentBloc, AgentState>(
      'emits [loading, error] when profile fetch fails',
      build: () {
        when(() =>
                mockRepository.fetchUserAccount(id: clientId))
            .thenAnswer((_) async =>
                const Left(ServerFailure(message: 'Not found')));
        when(() => mockRepository.getClientNotes(
                agentId: agentId, clientId: clientId))
            .thenAnswer((_) async => const Right([]));
        when(() => mockRepository.getClientActivities(
                agentId: agentId, requesterId: agentId))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadClientDetail(
          agentId: agentId, clientId: clientId, requesterId: agentId)),
      expect: () => [
        const AgentState(isLoading: true),
        const AgentState(isLoading: false, error: 'Not found'),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // AddClientNote
  // ═══════════════════════════════════════════════════════════════

  group('AgentBloc - AddClientNote', () {
    const agentId = 'agent1';
    const clientId = 'client1';
    const note = 'Follow up about pre-approval';

    blocTest<AgentBloc, AgentState>(
      'emits [sending, success] then reloads client detail on note add',
      build: () {
        when(() => mockRepository.addClientNote(
              agentId: agentId,
              clientId: clientId,
              note: note,
            )).thenAnswer((_) async => const Right(null));
        // After adding note, bloc dispatches LoadClientDetail
        when(() =>
                mockRepository.fetchUserAccount(id: clientId))
            .thenAnswer((_) async => Right({'uid': clientId}));
        when(() => mockRepository.getClientNotes(
                agentId: agentId, clientId: clientId))
            .thenAnswer((_) async => Right([
                  {'note': note, 'createdAt': '2024-01-02'}
                ]));
        when(() => mockRepository.getClientActivities(
                agentId: agentId, requesterId: agentId))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddClientNote(
          agentId: agentId, clientId: clientId, note: note)),
      expect: () => [
        const AgentState(isSending: true),
        const AgentState(isSending: false, successMessage: 'Note added'),
        // Re-load triggers LoadClientDetail
        const AgentState(isLoading: true),
        AgentState(
          isLoading: false,
          clientDetail: {'uid': clientId},
          clientNotes: [
            {'note': note, 'createdAt': '2024-01-02'}
          ],
          clientActivities: const [],
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.addClientNote(
              agentId: agentId,
              clientId: clientId,
              note: note,
            )).called(1);
      },
    );

    blocTest<AgentBloc, AgentState>(
      'emits [sending, error] when adding note fails',
      build: () {
        when(() => mockRepository.addClientNote(
              agentId: agentId,
              clientId: clientId,
              note: note,
            )).thenAnswer((_) async =>
            const Left(FirestoreFailure(message: 'Write failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddClientNote(
          agentId: agentId, clientId: clientId, note: note)),
      expect: () => [
        const AgentState(isSending: true),
        const AgentState(isSending: false, error: 'Write failed'),
      ],
    );
  });
}
