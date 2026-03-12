// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
// Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Custom action to merge API contacts with Firebase invitations
List<MemberStruct> mergeContactsWithInvitations(
  List<dynamic>? apiContacts,
  List<InvitationsRecord>? firebaseInvitations,
  String selectedTab, // "CRM" or "My Contacts"
) {
  List<MemberStruct> result = [];

  if (apiContacts == null || apiContacts.isEmpty) {
    apiContacts = [];
  }
  // Create a map of email -> invitation for quick lookup
  Map<String, InvitationsRecord> invitationMap = {};
  if (firebaseInvitations != null) {
    for (var invitation in firebaseInvitations) {
      try {
        String? inviteeEmail = invitation.invitations.inviteeEmail;
        if (inviteeEmail.isNotEmpty) {
          invitationMap[inviteeEmail.toLowerCase()] = invitation;
        }
      } catch (e) {
        print('Error processing invitation: $e');
        continue;
      }
    }
  }

  // Create a set of emails from API contacts for quick lookup
  Set<String> apiEmails = {};
  for (var contact in apiContacts) {
    String email = contact['email']?.toString() ?? '';
    if (email.isNotEmpty) {
      apiEmails.add(email.toLowerCase());
    }
  }

  if (selectedTab == "CRM") {
    // Show all API contacts with status from Firebase invitations
    for (var contact in apiContacts) {
      try {
        String email = contact['email']?.toString() ?? '';
        String emailLower = email.toLowerCase();
        String phone = contact['phone']?.toString() ?? '';
        String firstname = contact['firstname']?.toString() ?? '';
        String lastname = contact['lastname']?.toString() ?? '';
        String clientID = contact['id']?.toString() ?? '';
        String agentID = contact['agentID']?.toString() ?? '';

        // Check if this contact has an invitation in Firebase
        InvitationsRecord? invitation = invitationMap[emailLower];
        Status? status;

        if (invitation != null) {
          // Contact has an invitation - add the status from Firebase
          String? statusStr = invitation.invitations.status;
          // Capitalize first letter: "pending" -> "Pending"
          String capitalized =
              statusStr[0].toUpperCase() + statusStr.substring(1).toLowerCase();
          status = statusStringToEnum(capitalized);
        }

        result.add(MemberStruct(
          clientID: clientID,
          agentID: agentID,
          fullName: '$firstname $lastname'.trim(),
          email: email,
          id: clientID,
          phoneNumber: phone,
          status: status,
        ));
      } catch (e) {
        print('Error processing CRM contact: $e');
        continue;
      }
    }
  } else if (selectedTab == "My Contacts") {
    // Show only contacts from Firebase that are NOT in the API (manually added)
    Set<String> addedEmails = {}; // Track added emails to prevent duplicates

    if (firebaseInvitations != null) {
      for (var invitation in firebaseInvitations) {
        try {
          String? inviteeEmail = invitation.invitations.inviteeEmail;
          String? inviteeName = invitation.invitations.inviteeName;
          String? inviteePhone = invitation.invitations.inviteePhoneNumber;
          String? statusStr = invitation.invitations.status;
          String? inviterUid = invitation.invitations.inviterUid;

          if (inviteeEmail.isEmpty) continue;

          String emailLower = inviteeEmail.toLowerCase();

          // Only add if:
          // 1. Email is NOT in API contacts (manually added contact)
          // 2. Status is accepted or pending
          // 3. Not already added (prevent duplicates)
          if (!apiEmails.contains(emailLower) &&
              !addedEmails.contains(emailLower)) {
            addedEmails.add(emailLower);
            String capitalized = statusStr[0].toUpperCase() +
                statusStr.substring(1).toLowerCase();
            result.add(MemberStruct(
              clientID: '', // No client ID for manually added contacts
              agentID: inviterUid ?? '',
              fullName: inviteeName ?? 'Unknown',
              email: inviteeEmail,
              id: '', // No ID from API
              phoneNumber: inviteePhone ?? '',
              status: statusStringToEnum(capitalized),
            ));
          }
        } catch (e) {
          print('Error processing My Contacts invitation: $e');
          continue;
        }
      }
    }
  }

  return result;
}
