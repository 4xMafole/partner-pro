import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

/// Validates proof of funds documents (90-day expiry) and returns Base64-encoded content.
///
/// Returns null if:
/// - proofOfFundsData is null/empty
/// - All documents are older than 90 days
/// Returns list of valid documents with Base64-encoded content.
Future<List<Map<String, dynamic>>?> getValidProofOfFunds({
  required DateTime? createdAt,
  required List<String> urls,
}) async {
  if (urls.isEmpty) return null;

  // Check 90-day expiry
  if (createdAt != null) {
    final daysSinceUpload = DateTime.now().difference(createdAt).inDays;
    if (daysSinceUpload > 90) return null;
  }

  final results = <Map<String, dynamic>>[];

  for (final url in urls) {
    if (url.isEmpty) continue;

    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      final metadata = await ref.getMetadata();

      // Download content (max 10MB)
      const maxSize = 10 * 1024 * 1024;
      final Uint8List? data = await ref.getData(maxSize);
      if (data == null) continue;

      results.add({
        'id': ref.fullPath,
        'name': metadata.name ?? ref.name,
        'url': url,
        'createdDate': metadata.timeCreated?.toIso8601String() ?? '',
        'content': base64Encode(data),
      });
    } catch (_) {
      // Skip invalid files
      continue;
    }
  }

  return results.isEmpty ? null : results;
}

/// Marks all notifications in a list as read (client-side mapping).
/// Returns the updated list with isRead = true.
List<Map<String, dynamic>> markReadAllNotifications(
    List<Map<String, dynamic>> notifications) {
  return notifications.map((n) => {...n, 'is_read': true}).toList();
}
