import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/email_sms_service.dart';
import '../../../../core/services/firestore_datasource.dart';
import '../../../../core/utils/email_generators.dart';
import '../datasources/agent_remote_datasource.dart';

@lazySingleton
class AgentRepository {
  final UserAccountRemoteDataSource _remote;
  final FirestoreDataSource _firestore;
  final EmailSmsService _emailSms;

  AgentRepository(this._remote, this._firestore, this._emailSms);

  Future<Either<Failure, Map<String, dynamic>>> fetchUserAccount({String? email, String? id}) async {
    try {
      return Right(await _remote.fetchUserAccount(email: email, id: id));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createUserAccount({required Map<String, dynamic> userData}) async {
    try {
      return Right(await _remote.createUserAccount(userData: userData));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateUserAccount({required Map<String, dynamic> userData}) async {
    try {
      return Right(await _remote.updateUserAccount(userData: userData));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getAgentClients({
    required String agentId, required String requesterId,
  }) async {
    try {
      return Right(await _remote.getAgentClients(agentId: agentId, requesterId: requesterId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getClientActivities({
    required String agentId, required String requesterId,
  }) async {
    try {
      return Right(await _remote.getClientActivities(agentId: agentId, requesterId: requesterId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // -- Invitations --

  Future<Either<Failure, void>> createBuyerInvitations({
    required String inviterUid, required String inviterName,
    required List<Map<String, dynamic>> invitees,
  }) async {
    try {
      await _firestore.createInvitations(inviterUid: inviterUid, inviterName: inviterName, invitees: invitees);
      return const Right(null);
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> createBuyerInvitationsWithMessaging({
    required String inviterUid, required String inviterName,
    required String inviterFullName, required String signUpUrl,
    required String shortLink, required String logoUrl,
    String? inviterMLS, String? inviterContact, String? brokerageName,
    required List<Map<String, dynamic>> invitees, required String requesterId,
  }) async {
    try {
      final futures = <Future>[];
      for (final invitee in invitees) {
        final firstName = (invitee['name'] as String?)?.split(' ').first ?? '';
        final email = invitee['email'] as String? ?? '';
        final phone = invitee['phone'] as String? ?? '';

        if (email.isNotEmpty) {
          final html = EmailGenerators.buyerInvitationEmail(
            inviterFullName: inviterFullName,
            signUpUrl: signUpUrl,
            logoUrl: logoUrl,
            inviterMLS: inviterMLS,
            inviterContact: inviterContact,
            brokerageName: brokerageName,
            inviteeFirstName: firstName,
          );
          futures.add(_emailSms.sendEmail(
            to: email, subject: 'You\'re Invited to PartnerPro!',
            body: html, cc: email, requesterId: requesterId,
          ).timeout(const Duration(seconds: 25)));
        }

        if (phone.isNotEmpty) {
          final sms = EmailGenerators.invitationSms(
            firstName: firstName, shortLink: shortLink,
            agentName: inviterFullName, isBuyer: true,
          );
          futures.add(_emailSms.sendSms(
            recipient: phone, content: sms,
            sender: inviterFullName, requesterId: requesterId,
          ).timeout(const Duration(seconds: 25)));
        }
      }

      await Future.wait(futures);
      await _firestore.createInvitations(inviterUid: inviterUid, inviterName: inviterName, invitees: invitees);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Stream<List<Map<String, dynamic>>> watchInvitations(String inviterUid) =>
      _firestore.watchInvitations(inviterUid);

  Future<Either<Failure, List<Map<String, dynamic>>>> getInvitations(String inviterUid) async {
    try {
      return Right(await _firestore.getInvitations(inviterUid));
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  Stream<List<Map<String, dynamic>>> watchRelationships({required String userId, required bool isAgent}) =>
      _firestore.watchRelationships(userId: userId, isAgent: isAgent);

  // -- Buyer-side Invitations --

  Future<Either<Failure, List<Map<String, dynamic>>>> getBuyerInvitations(String email) async {
    try {
      return Right(await _firestore.getInvitationsForBuyer(email));
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> acceptInvitation({
    required String invitationId,
    required String agentId,
    required String buyerId,
    required String agentName,
    required String buyerName,
  }) async {
    try {
      await _firestore.updateInvitationStatus(invitationId: invitationId, status: 'accepted');
      await _firestore.createRelationship(
        agentId: agentId, buyerId: buyerId, agentName: agentName, buyerName: buyerName,
      );
      return const Right(null);
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> declineInvitation(String invitationId) async {
    try {
      await _firestore.updateInvitationStatus(invitationId: invitationId, status: 'declined');
      return const Right(null);
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  // -- Client Notes --

  Future<Either<Failure, void>> addClientNote({
    required String agentId,
    required String clientId,
    required String note,
  }) async {
    try {
      await _firestore.addClientNote(agentId: agentId, clientId: clientId, note: note);
      return const Right(null);
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getClientNotes({
    required String agentId,
    required String clientId,
  }) async {
    try {
      return Right(await _firestore.getClientNotes(agentId: agentId, clientId: clientId));
    } catch (e) {
      return Left(FirestoreFailure(message: e.toString()));
    }
  }

  // -- Business Logic: Merge contacts --

  List<Map<String, dynamic>> mergeContactsWithInvitations({
    required List<Map<String, dynamic>> apiContacts,
    required List<Map<String, dynamic>> firebaseInvitations,
    required String selectedTab,
  }) {
    if (selectedTab == 'CRM') {
      final invByEmail = <String, Map<String, dynamic>>{};
      for (final inv in firebaseInvitations) {
        final email = (inv['inviteeEmail'] as String?)?.toLowerCase() ?? '';
        if (email.isNotEmpty) invByEmail[email] = inv;
      }
      return apiContacts.map((c) {
        final email = (c['email'] as String?)?.toLowerCase() ?? '';
        final inv = invByEmail[email];
        return { ...c, if (inv != null) 'invitationStatus': inv['status'], if (inv != null) 'invitationId': inv['id'] };
      }).toList();
    } else {
      final apiEmails = apiContacts.map((c) => (c['email'] as String?)?.toLowerCase() ?? '').toSet();
      return firebaseInvitations
          .where((inv) {
            final email = (inv['inviteeEmail'] as String?)?.toLowerCase() ?? '';
            final status = inv['status'] as String? ?? '';
            return !apiEmails.contains(email) && (status == 'accepted' || status == 'pending');
          })
          .map((inv) => {'name': inv['inviteeName'], 'email': inv['inviteeEmail'], 'phone': inv['inviteePhoneNumber'], 'status': inv['status'], 'invitationId': inv['id']})
          .toList();
    }
  }

  // -- Business Logic: Activity feed enrichment --

  List<Map<String, dynamic>> processAndEnrichActivityFeed({
    required List<Map<String, dynamic>> clients,
    required List<Map<String, dynamic>> activities,
  }) {
    final nameMap = <String, String>{};
    final photoMap = <String, String>{};
    for (final c in clients) {
      final id = c['clientID']?.toString() ?? '';
      nameMap[id] = c['fullName']?.toString() ?? '';
      photoMap[id] = c['photoUrl']?.toString() ?? '';
    }

    final enriched = activities.map((a) {
      final uid = a['user_id']?.toString() ?? '';
      return { ...a, 'memberName': nameMap[uid] ?? 'Unknown', 'memberPhoto': photoMap[uid] ?? '', 'activityType': a['search'] != null ? 'search' : 'other' };
    }).toList();

    enriched.sort((a, b) => (b['created_at']?.toString() ?? '').compareTo(a['created_at']?.toString() ?? ''));
    return enriched;
  }
}