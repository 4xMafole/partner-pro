// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert'; // For base64 encoding

Future<List<UserFileStruct>?> getValidProofOfFunds(
    ProofOfFundsStruct? proofOfFundsData) async {
  // --- Step 1: Validation (No change) ---
  if (proofOfFundsData == null ||
      proofOfFundsData.createdAt == null ||
      proofOfFundsData.urls.isEmpty) {
    print('Proof of Funds is missing.');
    return null; // Return null for MISSING status
  }

  final DateTime uploadDate = proofOfFundsData.createdAt!;
  final DateTime now = DateTime.now();
  final DateTime ninetyDaysAgo = now.subtract(const Duration(days: 90));

  if (uploadDate.isBefore(ninetyDaysAgo)) {
    print('Proof of Funds has expired.');
    return null; // Return null for EXPIRED status
  }

  // --- Step 2: If valid, fetch metadata AND content for each URL ---
  print('Proof of Funds is valid. Fetching file details...');
  List<UserFileStruct> userFiles = [];
  final FirebaseStorage storage = FirebaseStorage.instance;

  for (String url in proofOfFundsData.urls) {
    try {
      Reference ref = storage.refFromURL(url);

      // Get metadata
      final FullMetadata metadata = await ref.getMetadata();
      final String name = metadata.name;
      final String createdDate = metadata.timeCreated.toString();

      // --- NEW: DOWNLOAD THE FILE CONTENT ---
      // Set a max size to prevent downloading huge files (e.g., 10MB)
      final int maxSize = 10 * 1024 * 1024;
      final bytes = await ref.getData(maxSize);

      // Encode the downloaded bytes to a Base64 string
      final String base64Content = base64Encode(bytes!);
      // ------------------------------------

      userFiles.add(UserFileStruct(
        id: ref.fullPath,
        name: name,
        url: url,
        createdDate: createdDate,
        content: base64Content, // Assign the fetched content
      ));
    } catch (e) {
      print('Error fetching file for URL "$url": $e');
      // If a download fails, we skip this file.
    }
  }

  return userFiles;
}
