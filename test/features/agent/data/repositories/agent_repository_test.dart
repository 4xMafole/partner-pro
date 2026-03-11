/// Unit tests for AgentRepository — Sprint 2.4 buyer invitation & CRM methods
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:partner_pro/features/agent/data/repositories/agent_repository.dart';
import 'package:partner_pro/features/agent/data/datasources/agent_remote_datasource.dart';
import 'package:partner_pro/core/services/firestore_datasource.dart';
import 'package:partner_pro/core/services/email_sms_service.dart';
import 'package:partner_pro/core/error/failures.dart';

class MockUserAccountRemoteDataSource extends Mock
    implements UserAccountRemoteDataSource {}

class MockFirestoreDataSource extends Mock implements FirestoreDataSource {}

class MockEmailSmsService extends Mock implements EmailSmsService {}

void main() {
  late AgentRepository repository;
  late MockUserAccountRemoteDataSource mockRemote;
  late MockFirestoreDataSource mockFirestore;
  late MockEmailSmsService mockEmailSms;

  setUp(() {
    mockRemote = MockUserAccountRemoteDataSource();
    mockFirestore = MockFirestoreDataSource();
    mockEmailSms = MockEmailSmsService();
    repository = AgentRepository(mockRemote, mockFirestore, mockEmailSms);
  });

  // ═══════════════════════════════════════════════════════════════
  // getBuyerInvitations
  // ═══════════════════════════════════════════════════════════════

  group('AgentRepository.getBuyerInvitations', () {
    const testEmail = 'buyer@example.com';
    final invitations = [
      {'id': 'inv1', 'agentName': 'Agent A', 'status': 'pending'},
    ];

    test('returns Right with invitations on success', () async {
      when(() => mockFirestore.getInvitationsForBuyer(testEmail))
          .thenAnswer((_) async => invitations);

      final result = await repository.getBuyerInvitations(testEmail);

      expect(result, Right(invitations));
      verify(() => mockFirestore.getInvitationsForBuyer(testEmail)).called(1);
    });

    test('returns Left with FirestoreFailure on exception', () async {
      when(() => mockFirestore.getInvitationsForBuyer(testEmail))
          .thenThrow(Exception('Firestore unavailable'));

      final result = await repository.getBuyerInvitations(testEmail);

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<FirestoreFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // acceptInvitation
  // ═══════════════════════════════════════════════════════════════

  group('AgentRepository.acceptInvitation', () {
    test('updates invitation status and creates relationship', () async {
      when(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv1',
            status: 'accepted',
          )).thenAnswer((_) async {});
      when(() => mockFirestore.createRelationship(
            agentId: 'agent1',
            buyerId: 'buyer1',
            agentName: 'Agent A',
            buyerName: 'Buyer B',
          )).thenAnswer((_) async {});

      final result = await repository.acceptInvitation(
        invitationId: 'inv1',
        agentId: 'agent1',
        buyerId: 'buyer1',
        agentName: 'Agent A',
        buyerName: 'Buyer B',
      );

      expect(result, const Right(null));
      verify(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv1',
            status: 'accepted',
          )).called(1);
      verify(() => mockFirestore.createRelationship(
            agentId: 'agent1',
            buyerId: 'buyer1',
            agentName: 'Agent A',
            buyerName: 'Buyer B',
          )).called(1);
    });

    test('returns Left on exception', () async {
      when(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv1',
            status: 'accepted',
          )).thenThrow(Exception('Write error'));

      final result = await repository.acceptInvitation(
        invitationId: 'inv1',
        agentId: 'agent1',
        buyerId: 'buyer1',
        agentName: 'Agent A',
        buyerName: 'Buyer B',
      );

      expect(result.isLeft(), true);
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // declineInvitation
  // ═══════════════════════════════════════════════════════════════

  group('AgentRepository.declineInvitation', () {
    test('updates invitation status to declined', () async {
      when(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv2',
            status: 'declined',
          )).thenAnswer((_) async {});

      final result = await repository.declineInvitation('inv2');

      expect(result, const Right(null));
      verify(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv2',
            status: 'declined',
          )).called(1);
    });

    test('returns Left on exception', () async {
      when(() => mockFirestore.updateInvitationStatus(
            invitationId: 'inv2',
            status: 'declined',
          )).thenThrow(Exception('Network'));

      final result = await repository.declineInvitation('inv2');

      expect(result.isLeft(), true);
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // addClientNote
  // ═══════════════════════════════════════════════════════════════

  group('AgentRepository.addClientNote', () {
    test('delegates to firestore and returns Right on success', () async {
      when(() => mockFirestore.addClientNote(
            agentId: 'agent1',
            clientId: 'client1',
            note: 'Follow up',
          )).thenAnswer((_) async {});

      final result = await repository.addClientNote(
        agentId: 'agent1',
        clientId: 'client1',
        note: 'Follow up',
      );

      expect(result, const Right(null));
      verify(() => mockFirestore.addClientNote(
            agentId: 'agent1',
            clientId: 'client1',
            note: 'Follow up',
          )).called(1);
    });

    test('returns Left on exception', () async {
      when(() => mockFirestore.addClientNote(
            agentId: 'agent1',
            clientId: 'client1',
            note: 'Follow up',
          )).thenThrow(Exception('Permission denied'));

      final result = await repository.addClientNote(
        agentId: 'agent1',
        clientId: 'client1',
        note: 'Follow up',
      );

      expect(result.isLeft(), true);
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // getClientNotes
  // ═══════════════════════════════════════════════════════════════

  group('AgentRepository.getClientNotes', () {
    final notes = [
      {'note': 'Pre-approved for 500k', 'createdAt': '2024-01-01'},
      {'note': 'Wants 3BR', 'createdAt': '2024-01-02'},
    ];

    test('returns Right with notes on success', () async {
      when(() => mockFirestore.getClientNotes(
            agentId: 'agent1',
            clientId: 'client1',
          )).thenAnswer((_) async => notes);

      final result = await repository.getClientNotes(
        agentId: 'agent1',
        clientId: 'client1',
      );

      expect(result, Right(notes));
    });

    test('returns Left on exception', () async {
      when(() => mockFirestore.getClientNotes(
            agentId: 'agent1',
            clientId: 'client1',
          )).thenThrow(Exception('Read failed'));

      final result = await repository.getClientNotes(
        agentId: 'agent1',
        clientId: 'client1',
      );

      expect(result.isLeft(), true);
    });
  });
}
