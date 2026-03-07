// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class AppState extends ChangeNotifier {
  String _pdfLink = '';

  String get PDFLink => _pdfLink;

  set PDFLink(String link) {
    _pdfLink = link;
    notifyListeners();
  }
}

class CAPDFWidget extends StatefulWidget {
  const CAPDFWidget({
    super.key,
    this.width,
    this.height,
    required this.sellerName,
    required this.buyerName,
    required this.address,
    required this.purchasePrice,
    required this.loanType,
    required this.offerDate,
    required this.agentBrokerLicense,
    required this.agentFirmName,
    required this.agentBrokerName,
    required this.sellerBrokerFirmName,
    required this.sellerAgentName,
    required this.buyerBrokerFirmName,
    required this.buyersAgentName,
    required this.city,
    required this.county,
    required this.zipCode,
    required this.propertyId,
    required this.closeDate,
    required this.expirationDate,
    required this.depositPercent,
    required this.depositAmount,
    required this.loanPercent,
    required this.loanAmount,
    required this.initBuyer1,
    required this.initBuyer2,
    required this.initSeller1,
    required this.initSeller2,
    required this.secondBuyerName,
    required this.buyerPhone,
    required this.zip,
    required this.state,
    required this.sellerBrokerFirm,
    required this.secondSellerName,
    required this.sellerPhone,
    required this.sellerEmail,
    required this.propertySellerComission,
    required this.buyerBrokerName,
    required this.sellerBrokerName,
    required this.signatureImageUrl,
    required this.onFilledPdfReady,
  });

  final double? width;
  final double? height;
  final String sellerName;
  final String buyerName;
  final String address;
  final String purchasePrice;
  final String loanType;
  final String offerDate;
  final String agentBrokerLicense;
  final String agentFirmName;
  final String agentBrokerName;
  final String sellerAgentName;
  final String buyerBrokerFirmName;
  final String buyersAgentName;
  final String city;
  final String county;
  final String zipCode;
  final String propertyId;
  final String sellerBrokerFirmName;
  final String closeDate;
  final String expirationDate;
  final String depositPercent;
  final String depositAmount;
  final String loanPercent;
  final String loanAmount;
  final String initBuyer1;
  final String initBuyer2;
  final String initSeller1;
  final String initSeller2;
  final String secondBuyerName;
  final String buyerPhone;
  final String zip;
  final String state;
  final String sellerBrokerFirm;
  final String secondSellerName;
  final String sellerPhone;
  final String sellerEmail;
  final String propertySellerComission;
  final String buyerBrokerName;
  final String sellerBrokerName;
  final String signatureImageUrl;
  final Future Function(FFUploadedFile? pdf) onFilledPdfReady;

  bool get isVA => loanType.toLowerCase() == 'va';
  bool get isFHA => loanType.toLowerCase() == 'fha';
  bool get isConventional => loanType.toLowerCase() == 'conventional';
  bool get isOther => loanType.toLowerCase() == 'other';

  @override
  State<CAPDFWidget> createState() => _CAPDFWidgetState();
}

class _CAPDFWidgetState extends State<CAPDFWidget> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  Future<void> uploadFilledPdf() async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/${DateTime.now().toIso8601String()}.pdf';
      final pdfBytes = await _pdfViewerController.saveDocument();
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('filled_pdfs/${DateTime.now().toIso8601String()}.pdf');
      await storageRef.putFile(file);
      String downloadURL = await storageRef.getDownloadURL();
      context.read<AppState>().PDFLink = downloadURL;

      print('File uploaded to Firebase Storage. URL: $downloadURL');
    } catch (e) {
      print('Error on uploaded PDF в Firebase Storage: $e');
    }
  }

  void fillForm(PdfDocument pdfDocument) async {
    try {
      final formFields = await _pdfViewerController.getFormFields();

      if (formFields == null || formFields.isEmpty) {
        print("Error: formFields is null or empty");
        return;
      }

      final textFieldsToFill = {
        'buyer_name': widget.buyerName,
        'seller_name': widget.sellerName,
        'agent_broker_license': widget.agentBrokerLicense,
        'offer_date': widget.offerDate,
        'purchase_price': widget.purchasePrice,
        'property_address': widget.address,
        'agent_firm_name': widget.agentFirmName,
        'agent_broker_name': widget.agentBrokerName,
        'seller_agent_name': widget.sellerAgentName,
        'buyer_broker_firm_name': widget.buyerBrokerFirmName,
        'buyers_agent_name': widget.buyersAgentName,
        'city': widget.city,
        'county': widget.county,
        'zip_code': widget.zipCode,
        'property_id': widget.propertyId,
        'seller_broker_firm_name': widget.sellerBrokerFirmName,
        'close_date': widget.closeDate,
        'expiration_date': widget.expirationDate,
        'deposit_percent': widget.depositPercent,
        'deposit_amount': widget.depositAmount,
        'loan_percent': widget.loanPercent,
        'loan_amount': widget.loanAmount,
        'init_buyer_1': widget.initBuyer1,
        'init_buyer_2': widget.initBuyer2,
        'init_seller_1': widget.initSeller1,
        'init_seller_2': widget.initSeller2,
        'second_buyer_name': widget.secondBuyerName,
        'buyer_phone': widget.buyerPhone,
        'zip': widget.zip,
        'state': widget.state,
        'seller_broker_firm': widget.sellerBrokerFirm,
        'second_seller_name': widget.secondSellerName,
        'seller_phone': widget.sellerPhone,
        'seller_email': widget.sellerEmail,
        'property_seller_comission': widget.propertySellerComission,
        'buyer_broker_name': widget.buyerBrokerName,
        'seller_broker_name': widget.sellerBrokerName,
      };

      textFieldsToFill.forEach((fieldName, fieldValue) {
        if (fieldValue != null && fieldValue.isNotEmpty) {
          final matchingFields = formFields
              .where((formField) => formField.name == fieldName)
              .toList();

          if (matchingFields.isNotEmpty &&
              matchingFields.first is PdfTextFormField) {
            final textField = matchingFields.first as PdfTextFormField;
            textField.text = fieldValue;
          } else {
            print("Field '$fieldName' not found or is not a PdfTextFormField");
          }
        }
      });

      // Signature URL replacement logic
      if (widget.signatureImageUrl != null &&
          widget.signatureImageUrl.isNotEmpty) {
        await drawSignatureImage(pdfDocument, widget.signatureImageUrl);
      } else {
        print("No signature image URL provided");
      }

      // Handling checkbox fields
      final checkBoxFields = {
        'isConventional': formFields
            .whereType<PdfCheckboxFormField?>()
            .firstWhere((formField) => formField?.name == 'isConventional',
                orElse: () => null),
        'isVA': formFields.whereType<PdfCheckboxFormField?>().firstWhere(
            (formField) => formField?.name == 'isVA',
            orElse: () => null),
        'isFHA': formFields.whereType<PdfCheckboxFormField?>().firstWhere(
            (formField) => formField?.name == 'isFHA',
            orElse: () => null),
        'isOthers': formFields.whereType<PdfCheckboxFormField?>().firstWhere(
            (formField) => formField?.name == 'isOthers',
            orElse: () => null),
      };

      // Uncheck all checkboxes first
      checkBoxFields.values.forEach((field) {
        if (field != null) {
          field.isChecked = false;
        }
      });

      // Check the appropriate checkbox based on widget values
      if (widget.isConventional) {
        checkBoxFields['isConventional']?.isChecked = true;
      } else if (widget.isVA) {
        checkBoxFields['isVA']?.isChecked = true;
      } else if (widget.isFHA) {
        checkBoxFields['isFHA']?.isChecked = true;
      } else {
        checkBoxFields['isOthers']?.isChecked = true;
      }
    } catch (e, stackTrace) {
      print("Error while filling form: $e");
      print(stackTrace);
    }
  }

  Future<void> drawSignatureImage(
      PdfDocument pdfDocument, String signatureUrl) async {
    try {
      // Download the signature image bytes
      final response = await http.get(Uri.parse(signatureUrl));

      if (response.statusCode == 200) {
        final signatureBytes = response.bodyBytes;

        // Create an image object from the signature bytes
        final image = PdfBitmap(signatureBytes);

        // Create a new page for the signature
        final page = pdfDocument.pages.add();

        // Define the bounds for the new signature field (top-right corner)
        final double margin = 20.0; // Adjust margin as needed
        final Rect bounds = Rect.fromLTWH(
          page.size.width - 150 - margin, // 150 is the width of the signature
          margin, // Positioning from the top
          150, // Width of the signature field
          50, // Height of the signature field
        );

        page.graphics
            .drawImage(image, Rect.fromLTWH(0, 0, bounds.width, bounds.height));
        print('Signature image added to the new page.');
      } else {
        print(
            'Error downloading signature image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error drawing new signature field: $e");
    }
  }

  // Function to get and print all form fields
  Future<void> getFormFields() async {
    try {
      // Get the list of form fields in the PDF
      final formFields = await _pdfViewerController.getFormFields();

      // Print the names of all fields
      formFields.forEach((field) {
        print('Field name: ${field.name}');
      });
    } catch (e) {
      print("Error fetching form fields: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pdfViewerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfPdfViewer.network(
        //The commented url gives cors origin bug
        // 'https://firebasestorage.googleapis.com/v0/b/iwriteoffers.appspot.com/o/pdf%2FCA_Contract_IWO.pdf?alt=media&token=b6f4480d-b0cc-4b43-9b71-2b29aa17fe65',
        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/iwriteoffers-4r87nm/assets/abg8i6hics9l/CA_Contract_IWO.pdf',
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.single,
        onDocumentLoaded: (details) async {
          await Future.delayed(Duration(seconds: 1));
          fillForm(details.document);
          getFormFields();
          details.document.form.flattenAllFields();

          final bytes = await details.document.save();
          details.document.dispose();
          final data = FFUploadedFile(
              name: 'addendum.pdf', bytes: Uint8List.fromList(bytes));
          widget.onFilledPdfReady(data);
        },
      ),
    );
  }
}
