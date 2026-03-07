// Automatic FlutterFlow imports
import '/backend/backend.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future<void> createBuyerInvitations(
  BuildContext context,
  String inviterUid,
  String inviterName,
  List<MemberStruct> inviteeMembers,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final WriteBatch batch = firestore.batch();
  final DateTime now = DateTime.now();

  for (MemberStruct member in inviteeMembers) {
    // 1. Create a clean Data Type object in code.
    final newInvitation = InvitationTypeStruct(
      inviterUid: inviterUid,
      inviterName: inviterName,
      inviteeName: member.fullName,
      inviteeEmail: member.email.toLowerCase().trim(),
      inviteePhoneNumber: member.phoneNumber,
      inviteeType: 'buyer',
      status: 'pending',
      createdAt: now,
    );

    // 2. Get a reference for the new document.
    final docRef = firestore.collection('invitations').doc();

    // 3. Use .toJson() to write the data.
    batch.set(docRef, {'invitations': newInvitation.toMap()});
  }

  // Commit all writes at once.
  await batch.commit();

  // // Optional: Show feedback to the user.
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text('Invitations sent successfully!'),
  //     backgroundColor: Colors.green,
  //   ),
  // );
}
