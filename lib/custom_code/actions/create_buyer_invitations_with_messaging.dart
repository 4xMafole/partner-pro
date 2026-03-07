// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:async'; // ADD THIS for TimeoutException

Future<void> createBuyerInvitationsWithMessaging(
  BuildContext context,
  String inviterUid,
  String inviterName,
  String inviterFullName,
  String signUpUrl,
  String shortLink,
  String logoUrl,
  String? inviterMLS,
  String? inviterContact,
  String? brokerageName,
  List<MemberStruct> inviteeMembers,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final WriteBatch batch = firestore.batch();
  final DateTime now = DateTime.now();

  const String apiBaseUrl =
      // 'https://dev-lwo-email-cors.us-w2.cloudhub.io/api/v1';
      'https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1';

  int successCount = 0;
  int failureCount = 0;
  List<String> failedRecipients = [];

  try {
    // Process all invitations in PARALLEL instead of sequential
    final results = await Future.wait(
      inviteeMembers.map((member) async {
        bool emailSent = false;
        bool smsSent = false;

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

        final emailHtml = generateInvitationEmailHtml(
          inviterName,
          signUpUrl,
          'buyer',
          logoUrl,
          inviterFullName,
          inviterMLS,
          inviterContact,
          brokerageName,
          getNamePart(member.fullName, true),
        );

        // Send Email with timeout
        try {
          final emailResponse = await http
              .post(
                Uri.parse('$apiBaseUrl/claude-email'),
                headers: {
                  'Content-Type': 'application/json',
                  'requester-id': inviterUid,
                },
                body: jsonEncode({
                  'from': FFAppState().fromEmail,
                  'to': member.email.toLowerCase().trim(),
                  'cc': member.email.toLowerCase().trim(),
                  'subject':
                      'Use My Application to Make Offers on Properties with Just a Click – You\'re Invited!',
                  'contentType': 'text/html',
                  'body': emailHtml,
                }),
              )
              .timeout(const Duration(seconds: 25));

          if (emailResponse.statusCode == 200) {
            emailSent = true;
            debugPrint('Email sent successfully to ${member.email}');
          } else {
            debugPrint(
                'Failed to send email to ${member.email}: ${emailResponse.statusCode}');
          }
        } on TimeoutException catch (e) {
          debugPrint('Email timeout for ${member.email}: $e');
        } catch (e) {
          debugPrint('Error sending email to ${member.email}: $e');
        }

        // Send SMS with timeout (ADDED TIMEOUT HERE)
        // if (member.phoneNumber.isNotEmpty) {
        //   try {
        //     String firstName = member.fullName;

        //     firstName = firstName.toLowerCase().split('').map((char) {
        //       return char == firstName[0] ? char.toUpperCase() : char;
        //     }).join();

        //     final smsContent = generateInvitationSmsText(
        //       firstName,
        //       shortLink,
        //       inviterName,
        //       'buyer',
        //     );

        //     final smsResponse = await http
        //         .post(
        //           Uri.parse('$apiBaseUrl/claude-sms'),
        //           headers: {
        //             'Content-Type': 'application/json',
        //             'requester-id': inviterUid,
        //           },
        //           body: jsonEncode({
        //             'sender': inviterName,
        //             'recipient': member.phoneNumber,
        //             'content': smsContent,
        //           }),
        //         )
        //         .timeout(const Duration(seconds: 25)); // ADDED TIMEOUT

        //     if (smsResponse.statusCode == 200) {
        //       smsSent = true;
        //       debugPrint('SMS sent successfully to ${member.phoneNumber}');
        //     } else {
        //       debugPrint(
        //           'Failed to send SMS to ${member.phoneNumber}: ${smsResponse.statusCode}');
        //     }
        //   } on TimeoutException catch (e) {
        //     debugPrint('SMS timeout for ${member.phoneNumber}: $e');
        //   } catch (e) {
        //     debugPrint('Error sending SMS to ${member.phoneNumber}: $e');
        //   }
        // }

        // Return result for this member
        bool hasPhoneNumber = member.phoneNumber.isNotEmpty;
        bool atLeastOneDelivered = emailSent || (hasPhoneNumber && smsSent);

        return {
          'success': atLeastOneDelivered,
          'invitation': newInvitation,
          'email': member.email,
        };
      }),
    ); // Future.wait processes all members in PARALLEL

    // Now process results and add to batch
    for (var result in results) {
      if (result['success'] == true) {
        final docRef = firestore.collection('invitations').doc();
        batch.set(docRef, {
          'invitations': (result['invitation'] as InvitationTypeStruct).toMap()
        });
        successCount++;
      } else {
        failureCount++;
        failedRecipients.add(result['email'] as String);
      }
    }

    // Commit only successful invitations
    if (successCount > 0) {
      await batch.commit();
    }

    // Show appropriate feedback
    if (successCount > 0 && failureCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$successCount buyer invitation(s) sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (successCount > 0 && failureCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '$successCount sent successfully, $failureCount failed to reach recipients: ${failedRecipients.join(", ")}'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 5),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All invitations failed to send. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    print('Error in createBuyerInvitationsWithMessaging: $e');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send invitations. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );

    rethrow;
  }
}
