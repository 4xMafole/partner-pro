// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OHPDFWidget extends StatefulWidget {
  const OHPDFWidget({
    super.key,
    this.width,
    this.height,
    required this.sellerName,
    required this.buyerName,
    required this.address,
    required this.purchasePrice,
    required this.loanType,
  });

  final double? width;
  final double? height;
  final String sellerName;
  final String buyerName;
  final String address;
  final String purchasePrice;
  final String loanType;

  @override
  State<OHPDFWidget> createState() => _OHPDFWidgetState();
}

class _OHPDFWidgetState extends State<OHPDFWidget> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  void fillForm() {
    final formFields = _pdfViewerController.getFormFields();
    final PdfTextFormField buyerNameField = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'text_1vtsq')
        as PdfTextFormField;
    final PdfTextFormField sellerNameField = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'text_2jdcd')
        as PdfTextFormField;
    final PdfTextFormField purchasePriceField = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'text_10ggtv')
        as PdfTextFormField;
    final PdfCheckboxFormField conventionalFieldCheck = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'checkbox_33imva')
        as PdfCheckboxFormField;
    final PdfCheckboxFormField vaFieldCheck = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'checkbox_34lzjs')
        as PdfCheckboxFormField;
    final PdfCheckboxFormField fhaFieldCheck = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'checkbox_35zhqy')
        as PdfCheckboxFormField;
    final PdfCheckboxFormField othersFieldCheck = formFields.singleWhere(
            (PdfFormField formField) => formField.name == 'checkbox_36rxvn')
        as PdfCheckboxFormField;
    buyerNameField.text = widget.buyerName;
    sellerNameField.text = widget.sellerName;
    purchasePriceField.text = widget.purchasePrice;
    if (widget.loanType == 'conventional') {
      conventionalFieldCheck.isChecked = true;
      vaFieldCheck.isChecked = false;
      fhaFieldCheck.isChecked = false;
      othersFieldCheck.isChecked = false;
    } else if (widget.loanType == 'va') {
      vaFieldCheck.isChecked = true;
      conventionalFieldCheck.isChecked = false;
      fhaFieldCheck.isChecked = false;
      othersFieldCheck.isChecked = false;
    } else if (widget.loanType == 'fha') {
      fhaFieldCheck.isChecked = true;
      vaFieldCheck.isChecked = false;
      conventionalFieldCheck.isChecked = false;
      othersFieldCheck.isChecked = false;
    } else {
      othersFieldCheck.isChecked = true;
      vaFieldCheck.isChecked = false;
      fhaFieldCheck.isChecked = false;
      conventionalFieldCheck.isChecked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfPdfViewer.network(
        'https://firebasestorage.googleapis.com/v0/b/iwriteoffers.appspot.com/o/pdf%2FOH-Contract.pdf?alt=media&token=dfdd03ea-0197-4bc8-993f-c87afd7226ee',
        controller: _pdfViewerController,
        onDocumentLoaded: (details) {
          fillForm();
        },
      ),
    );
  }
}
