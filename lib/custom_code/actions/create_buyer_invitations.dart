// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

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
