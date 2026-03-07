import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

/// Remote data source for document Firestore operations + DocuSeal/ApiFlow external APIs.
@lazySingleton
class DocumentRemoteDataSource {
  final FirebaseFirestore _firestore;
  final ApiClient _client;

  DocumentRemoteDataSource(this._firestore, this._client);

  static String get _docuSealToken => EnvConfig.docuSealToken;

  // -- Documents (Firestore) --

  /// Get document by ID.
  Future<Map<String, dynamic>> getDocument({
    required String documentId,
    required String requesterId,
  }) async {
    final doc = await _firestore
        .collection(AppConstants.documentsCollection)
        .doc(documentId)
        .get();
    if (!doc.exists) return {};
    return {...doc.data()!, 'id': doc.id};
  }

  /// Get all documents for a user.
  Future<List<Map<String, dynamic>>> getUserDocuments({
    required String userId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.documentsCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Get documents for a specific property.
  Future<List<Map<String, dynamic>>> getPropertyDocuments({
    required String propertyId,
    required String requesterId,
  }) async {
    final snap = await _firestore
        .collection(AppConstants.documentsCollection)
        .where('property_id', isEqualTo: propertyId)
        .orderBy('created_at', descending: true)
        .get();
    return snap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  /// Upload a document (metadata to Firestore).
  Future<Map<String, dynamic>> uploadDocument({
    required String requesterId,
    required String userId,
    required String documentDirectory,
    required String documentFile,
    required String documentType,
    required String documentName,
    required String documentSize,
    String? propertyId,
    String? sellerId,
  }) async {
    final data = <String, dynamic>{
      'user_id': userId,
      'document_directory': documentDirectory,
      'document_file': documentFile,
      'document_type': documentType,
      'document_name': documentName,
      'document_size': documentSize,
      'created_at': FieldValue.serverTimestamp(),
    };
    if (propertyId != null) data['property_id'] = propertyId;
    if (sellerId != null) data['seller_id'] = sellerId;

    final docRef =
        await _firestore.collection(AppConstants.documentsCollection).add(data);
    final snap = await docRef.get();
    return {...snap.data()!, 'id': snap.id};
  }

  // -- DocuSeal E-Signature API --

  Map<String, String> get _docuSealHeaders => {
        'X-Auth-Token': _docuSealToken,
        'Content-Type': 'application/json',
      };

  /// Lists available DocuSeal templates.
  Future<List<Map<String, dynamic>>> getTemplates() async {
    final response = await _client.get(
      '${ApiEndpoints.docuSealBase}/templates',
      headers: _docuSealHeaders,
    );
    final List<dynamic> data = response is List ? response : [];
    return data.cast<Map<String, dynamic>>();
  }

  /// Creates a DocuSeal submission (signing request).
  Future<Map<String, dynamic>> createSubmission({
    required int templateId,
    required List<Map<String, dynamic>> submitters,
  }) async {
    final response = await _client.post(
      '${ApiEndpoints.docuSealBase}/submissions',
      headers: _docuSealHeaders,
      body: {
        'template_id': templateId,
        'submitters': submitters,
      },
    );
    return response as Map<String, dynamic>;
  }

  /// Gets a submission's status and details.
  Future<Map<String, dynamic>> getSubmission(int submissionId) async {
    final response = await _client.get(
      '${ApiEndpoints.docuSealBase}/submissions/$submissionId',
      headers: _docuSealHeaders,
    );
    return response as Map<String, dynamic>;
  }

  /// Updates a submitter (e.g. mark as completed).
  Future<Map<String, dynamic>> updateSubmitter({
    required int submitterId,
    required Map<String, dynamic> data,
  }) async {
    final response = await _client.put(
      '${ApiEndpoints.docuSealBase}/submitters/$submitterId',
      headers: _docuSealHeaders,
      body: data,
    );
    return response as Map<String, dynamic>;
  }

  /// Clones a template for customization.
  Future<Map<String, dynamic>> cloneTemplate(int templateId) async {
    final response = await _client.post(
      '${ApiEndpoints.docuSealBase}/templates/$templateId/clone',
      headers: _docuSealHeaders,
      body: {},
    );
    return response as Map<String, dynamic>;
  }

  // -- PDF Generation --

  /// Generates an offer agreement PDF via ApiFlow.
  Future<Map<String, dynamic>> generatePdf({
    required String sellerName,
    required String buyerName,
    required String address,
    required String purchasePrice,
    required String loanType,
  }) async {
    final authToken = EnvConfig.apiFlowToken;

    final response = await _client.post(
      ApiEndpoints.pdfGeneratorUrl,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: {
        'seller_name': sellerName,
        'buyer_name': buyerName,
        'address': address,
        'purchase_price': purchasePrice,
        'loan_type': loanType,
      },
    );
    return response as Map<String, dynamic>;
  }
}
