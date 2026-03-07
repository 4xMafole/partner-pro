import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../config/env_config.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';

class GeneratedPdf {
  final String url;
  final String base64Content;

  const GeneratedPdf({required this.url, required this.base64Content});
}

@lazySingleton
class PdfService {
  final ApiClient _client;

  PdfService(this._client);

  static String get _apiFlowToken => EnvConfig.apiFlowToken;

  /// Generate an offer PDF via ApiFlow.
  Future<GeneratedPdf> generateOfferPdf({
    required String sellerName,
    required String buyerName,
    required String address,
    required double purchasePrice,
    required String loanType,
  }) async {
    final response = await _client.post(
      ApiEndpoints.pdfGeneratorUrl,
      headers: {
        'Authorization': 'Bearer $_apiFlowToken',
        'Content-Type': 'application/json',
      },
      body: {
        'sellerName': sellerName,
        'buyerName': buyerName,
        'address': address,
        'purchasePrice': purchasePrice,
        'loanType': loanType,
      },
    );

    final data =
        response is Map<String, dynamic> ? response : <String, dynamic>{};
    return GeneratedPdf(
      url: data['url'] as String? ?? '',
      base64Content: data['content'] as String? ?? '',
    );
  }

  /// Decode PDF from base64 to bytes.
  List<int> decodePdfBytes(String base64Content) {
    return base64Decode(base64Content);
  }
}
