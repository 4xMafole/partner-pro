// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:internet_file/internet_file.dart';

import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<FFUploadedFile> fillTransaction00472(
    String txPath, String name01, String name02) async {
  // Step 1: Load the PDF document from the FFUploadedFile
  final PdfDocument document =
      PdfDocument(inputBytes: await InternetFile.get(txPath));

  // Access the form in the PDF
  PdfForm form = document.form;

  form.setDefaultAppearance(false);

  await printWeb('Number of form fields is ${form.fields.count}');

  // Fill text field (example: Buyer Name)
  PdfTextBoxField buyerNameField = form.fields[0] as PdfTextBoxField;
  buyerNameField.text = name01;

  // Fill text field (example: Buyer Name)
  PdfTextBoxField sellerNameField = form.fields[1] as PdfTextBoxField;
  sellerNameField.text = name02;

  // // Step 2: Get the first page where the fields need to be filled
  // final PdfPage page = document.pages[0];
  // final PdfGraphics graphics = page.graphics;

  // // Step 3: Set up font and brush for drawing text
  // final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  // final PdfBrush brush = PdfBrushes.black;

  // // Step 4: Draw text at the specified coordinates for each field
  // graphics.drawString('John Doe', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 120, 300, 20)); // Buyer Name
  // graphics.drawString('Jane Doe', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 160, 300, 20)); // Seller Name
  // graphics.drawString('123 Example St, City, TX', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 200, 300, 20)); // Property Address
  // graphics.drawString('500,000 USD', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 240, 300, 20)); // Sales Price
  // graphics.drawString('50,000 USD', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 280, 300, 20)); // Earnest Money
  // graphics.drawString('December 31, 2024', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 320, 300, 20)); // Closing Date
  // graphics.drawString('ABC Escrow Agent', font,
  //     brush: brush,
  //     bounds: const Rect.fromLTWH(100, 360, 300, 20)); // Escrow Agent

  // Step 5: Save the modified document to bytes
  List<int> updatedBytes = await document.save();

  // Step 6: Dispose of the document to free resources
  document.dispose();

  // Step 7: Return the updated PDF as an FFUploadedFile
  return FFUploadedFile(
      bytes: Uint8List.fromList(updatedBytes), name: 'filled_TX-00472.pdf');
}
