import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PickedFileInfo {
  final String fileName;
  final int fileSize;
  final String base64Content;
  final Uint8List? bytes;

  const PickedFileInfo({
    required this.fileName,
    required this.fileSize,
    required this.base64Content,
    this.bytes,
  });
}

class UploadedFileInfo {
  final String fileName;
  final String downloadUrl;
  final int fileSize;

  const UploadedFileInfo({
    required this.fileName,
    required this.downloadUrl,
    required this.fileSize,
  });
}

@lazySingleton
class FileService {
  final FirebaseStorage _storage;

  FileService() : _storage = FirebaseStorage.instance;

  /// Pick a single PDF file from device.
  /// Returns [PickedFileInfo] with base64 content or null if cancelled.
  Future<PickedFileInfo?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return null;
    final file = result.files.first;

    Uint8List? bytes;
    if (kIsWeb) {
      bytes = file.bytes;
    } else if (file.path != null) {
      bytes = await File(file.path!).readAsBytes();
    }

    if (bytes == null) return null;

    return PickedFileInfo(
      fileName: file.name,
      fileSize: bytes.length,
      base64Content: base64Encode(bytes),
      bytes: bytes,
    );
  }

  /// Pick any file type from device.
  Future<PickedFileInfo?> pickFile({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
      withData: true,
    );

    if (result == null || result.files.isEmpty) return null;
    final file = result.files.first;

    Uint8List? bytes;
    if (kIsWeb) {
      bytes = file.bytes;
    } else if (file.path != null) {
      bytes = await File(file.path!).readAsBytes();
    }

    if (bytes == null) return null;

    return PickedFileInfo(
      fileName: file.name,
      fileSize: bytes.length,
      base64Content: base64Encode(bytes),
      bytes: bytes,
    );
  }

  /// Upload a file (from base64 or bytes) to Firebase Storage.
  /// [directory] is the subfolder under users/{userId}/
  Future<UploadedFileInfo> uploadFile({
    required String userId,
    required String directory,
    required String fileName,
    String? base64Content,
    Uint8List? bytes,
  }) async {
    final data = bytes ?? base64Decode(base64Content!);
    final ref = _storage.ref('users/$userId/$directory/$fileName');

    await ref.putData(
      data,
      SettableMetadata(contentType: _mimeType(fileName)),
    );

    final url = await ref.getDownloadURL();

    return UploadedFileInfo(
      fileName: fileName,
      downloadUrl: url,
      fileSize: data.length,
    );
  }

  /// Fetch a remote image URL and save to temp directory.
  /// Returns the local file path.
  Future<String> fetchImageAsFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch image: ${response.statusCode}');
    }

    final dir = await getTemporaryDirectory();
    final fileName =
        'img_${DateTime.now().millisecondsSinceEpoch}.${_extensionFromUrl(imageUrl)}';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  /// Delete a file from Firebase Storage by its download URL.
  Future<void> deleteFile(String downloadUrl) async {
    final ref = _storage.refFromURL(downloadUrl);
    await ref.delete();
  }

  /// Validate proof-of-funds documents: must be within 90 days.
  Future<List<ValidatedFile>> getValidProofOfFunds(
    List<String> fileUrls,
  ) async {
    final results = <ValidatedFile>[];

    for (final url in fileUrls) {
      final ref = _storage.refFromURL(url);
      final metadata = await ref.getMetadata();
      final createdAt = metadata.timeCreated;

      if (createdAt == null) continue;

      final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
      final isValid = daysSinceCreation <= 90;

      final data = await ref.getData(104857600);

      results.add(ValidatedFile(
        name: metadata.name,
        url: url,
        createdDate: createdAt.toIso8601String(),
        base64Content: data != null ? base64Encode(data) : '',
        isValid: isValid,
        daysOld: daysSinceCreation,
      ));
    }

    return results;
  }

  String _mimeType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      default:
        return 'application/octet-stream';
    }
  }

  String _extensionFromUrl(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    if (path.contains('.')) return path.split('.').last.split('?').first;
    return 'jpg';
  }
}

class ValidatedFile {
  final String name;
  final String url;
  final String createdDate;
  final String base64Content;
  final bool isValid;
  final int daysOld;

  const ValidatedFile({
    required this.name,
    required this.url,
    required this.createdDate,
    required this.base64Content,
    required this.isValid,
    required this.daysOld,
  });
}
