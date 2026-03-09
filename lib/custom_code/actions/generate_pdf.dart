// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/core/network/api_client.dart';
import '/core/services/pdf_service.dart';

Future<PdfAssetStruct> generatePdf(String sellerName, String buyerName,
    String address, String purchasePrice, String loanType) async {
  final pdfService = PdfService(ApiClient());
  final generated = await pdfService.generateOfferPdf(
    sellerName: sellerName,
    buyerName: buyerName,
    address: address,
    purchasePrice: double.tryParse(purchasePrice) ?? 0,
    loanType: loanType,
  );

  return PdfAssetStruct(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    link: generated.url,
    name: 'Generated Offer PDF',
  );
}
