import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

/// Remote data source for document-related MuleSoft API + DocuSeal calls.
@lazySingleton
class DocumentRemoteDataSource {
  final ApiClient _client;

  DocumentRemoteDataSource(this._client);

  static const _docuSealToken = 'DOCUSEAL_TOKEN_REMOVED';

  // -- IWO Documents API --

  /// Get document by ID.
  Future<Map<String, dynamic>> getDocument({
    required String documentId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '${ApiEndpoints.documentsBase}/documents/$documentId',
      headers: {'requester-id': requesterId},
    );
    return response as Map<String, dynamic>;
  }

  /// Get all documents for a user.
  Future<List<Map<String, dynamic>>> getUserDocuments({
    required String userId,
    required String requesterId,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.documentsBase}/documents/user')
        .replace(queryParameters: {'user_id': userId});

    final response = await _client.get(
      uri.toString(),
      headers: {'requester-id': requesterId},
    );
    final List<dynamic> data =
        response is List ? response : (response['documents'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Get documents for a specific property.
  Future<List<Map<String, dynamic>>> getPropertyDocuments({
    required String propertyId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '${ApiEndpoints.documentsBase}/documents/user/$propertyId',
      headers: {'requester-id': requesterId},
    );
    final List<dynamic> data =
        response is List ? response : (response['documents'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Upload a document.
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
    final body = <String, dynamic>{
      'user_id': userId,
      'document_directory': documentDirectory,
      'document_file': documentFile,
      'document_type': documentType,
      'document_name': documentName,
      'document_size': documentSize,
    };
    if (propertyId != null) body['property_id'] = propertyId;
    if (sellerId != null) body['seller_id'] = sellerId;

    final response = await _client.post(
      '${ApiEndpoints.documentsBase}/documents/user',
      headers: {'requester-id': requesterId},
      body: body,
    );
    return response as Map<String, dynamic>;
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
    const authToken =
        'APIFLOW_TOKEN_REMOVED';

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