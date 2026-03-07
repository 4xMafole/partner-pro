// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TexasPDFWidget extends StatefulWidget {
  const TexasPDFWidget({
    super.key,
    this.width,
    this.height,
    required this.sellerName,
    required this.buyerName,
    required this.blockName,
    required this.lotNumber,
    required this.city,
    required this.countyName,
    required this.addressZipCode,
    required this.downPaymentAmount,
    required this.loanAmount,
    required this.totalPrice,
    required this.sellerFirstName,
    required this.sellerSecondName,
    required this.titleCompanyName,
    required this.buyerFirstName,
    required this.buyerSecondName,
    required this.propertyAddress,
    required this.titleCompanyAddress,
    required this.depositeAmount,
    required this.earnestMoney,
    required this.residentialsFees,
    required this.closingDate,
    required this.year,
    required this.creditRequest,
    required this.buyerAddress,
    required this.buyerPhone,
    required this.buyerEmail,
    required this.sellerAddress,
    required this.sellerEmail,
    required this.sellerPhone,
  });

  final double? width;
  final double? height;
  final String sellerName;
  final String buyerName;
  final String blockName;
  final String lotNumber;
  final String city;
  final String countyName;
  final String addressZipCode;
  final String downPaymentAmount;
  final String loanAmount;
  final String totalPrice;
  final String sellerFirstName;
  final String sellerSecondName;
  final String titleCompanyName;
  final String buyerFirstName;
  final String buyerSecondName;
  final String propertyAddress;
  final String titleCompanyAddress;
  final String depositeAmount;
  final String earnestMoney;
  final String residentialsFees;
  final String closingDate;
  final String year;
  final String creditRequest;
  final String buyerAddress;
  final String buyerPhone;
  final String buyerEmail;
  final String sellerAddress;
  final String sellerEmail;
  final String sellerPhone;

  @override
  State<TexasPDFWidget> createState() => _TexasPDFWidgetState();
}

class _TexasPDFWidgetState extends State<TexasPDFWidget> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  // Function to fill form fields in the PDF
  void fillForm() async {
    try {
      final formFields = _pdfViewerController.getFormFields();

      for (int i = 1; i <= 8; i++) {
        // Seller fields
        var sellerFirstNameField = formFields
            .where((formField) => formField.name == 'Seller 1 Initial Page $i');
        var sellerSecondNameField = formFields
            .where((formField) => formField.name == 'Seller 2 Initial Page $i');

        if (sellerFirstNameField.isNotEmpty &&
            widget.sellerFirstName.isNotEmpty) {
          (sellerFirstNameField.first as PdfTextFormField).text =
              widget.sellerFirstName;
        }
        if (sellerSecondNameField.isNotEmpty &&
            widget.sellerSecondName.isNotEmpty) {
          (sellerSecondNameField.first as PdfTextFormField).text =
              widget.sellerSecondName;
        }

        // Buyer fields
        var buyerFirstNameField = formFields
            .where((formField) => formField.name == 'Buyer 1 Initial Page $i');
        var buyerSecondNameField = formFields
            .where((formField) => formField.name == 'Buyer 2 Initial Page $i');

        if (buyerFirstNameField.isNotEmpty &&
            widget.buyerFirstName.isNotEmpty) {
          (buyerFirstNameField.first as PdfTextFormField).text =
              widget.buyerFirstName;
        }
        if (buyerSecondNameField.isNotEmpty &&
            widget.buyerSecondName.isNotEmpty) {
          (buyerSecondNameField.first as PdfTextFormField).text =
              widget.buyerSecondName;
        }
      }

      // Property address fields
      for (int i = 2; i <= 11; i++) {
        var propertyAddressField = formFields.where(
            (formField) => formField.name == 'Address of Property Page $i');
        if (propertyAddressField.isNotEmpty &&
            widget.propertyAddress.isNotEmpty) {
          (propertyAddressField.first as PdfTextFormField).text =
              widget.propertyAddress;
        }
      }

      // Additional fields with checks
      final fieldsToFill = {
        'Buyer Name': widget.buyerName,
        '12A(1)(b) Amount': widget.creditRequest,
        'Year Number 1': widget.year,
        'Date Number 1': widget.closingDate,
        '7H Amount': widget.residentialsFees,
        '5A Amount (Option Fee)': widget.earnestMoney,
        '5A Amount (Earnest Money)': widget.depositeAmount,
        '5A Escrow Agent Address': widget.titleCompanyAddress,
        'Seller Name': widget.sellerName,
        'Block': widget.blockName,
        'Lot': widget.lotNumber,
        'City Name': widget.city,
        'County Name': widget.countyName,
        'Address/ZIP code': widget.addressZipCode,
        'Amount 3(A)': widget.downPaymentAmount,
        'Amount 3B': widget.loanAmount,
        'Amount 3C': widget.totalPrice,
        '5A Escrow Agent': widget.titleCompanyName,
        'Buyer Address 1': widget.buyerAddress,
        'Buyer Phone Number': widget.buyerPhone,
        'Buyer Email/Fax Number 1': widget.buyerEmail,
        'Seller Address 1': widget.sellerAddress,
        'Seller Email/Fax': widget.sellerEmail,
        'Seller Phone Number': widget.sellerPhone,
        'Name of Title Company': widget.titleCompanyName,
      };

      fieldsToFill.forEach((fieldName, fieldValue) {
        if (fieldValue.isNotEmpty) {
          var field =
              formFields.where((formField) => formField.name == fieldName);
          if (field.isNotEmpty) {
            (field.first as PdfTextFormField).text = fieldValue;
          }
        }
      });
    } catch (e) {
      print("Error filling PDF form: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.network(
      'https://firebasestorage.googleapis.com/v0/b/iwriteoffers.appspot.com/o/pdf%2FTX-Contract.pdf?alt=media&token=1c021801-f696-4bfc-ac6c-0127c9c12e68',
      controller: _pdfViewerController,
      onDocumentLoaded: (details) {
        fillForm(); // Fill form when document is loaded
      },
    );
  }
}
