import 'package:ecnx_ambient_listening/core/extensions/datetime_extension.dart';
import 'package:ecnx_ambient_listening/features/edit/data/models/pdf_models/edited_text_model.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Generates a PDF file containing the edited text content.
/// The edited text content is displayed in a Quill rich text editor.
Future<void> generateEditedTextPdf(
  List<EditedTextModel> editedTexts,
  String title,
  PatientInformationModel? patientInformation,
) async {
  final pdf = pw.Document(
    pageMode: PdfPageMode.fullscreen,
  );

  pdf.addPage(
    buildMultiPage(editedTexts, title, patientInformation),
  );

  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

/// Builds a PDF document with multiple pages for displaying the edited text content.
/// Dynamically splits content across multiple pages if needed.
pw.MultiPage buildMultiPage(
  List<EditedTextModel> editedTexts,
  String title,
  PatientInformationModel? patientInformation,
) {
  return pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.all(20),
    build: (context) {
      List<pw.Widget> widgets = [];
      // Add the title.
      widgets.add(pw.Text(title, style: const pw.TextStyle(fontSize: 24)));
      widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(top: 24)));

      // Add patient information, if available.
      if (patientInformation != null) {
        widgets.addAll([
          pw.Text('Patient Name: ${patientInformation.name}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text('Age: ${patientInformation.age}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text('DOB: ${patientInformation.dob.toShortNameOfMonthAndDay()} ${patientInformation.dob.year}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text('Medical Record Number: ${patientInformation.recordNumber}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text('Date of Admission: ${patientInformation.dateOfAdmission.toNameOfMonthAndDay()}, ${patientInformation.dateOfAdmission.toUSAhourString()}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text('Admitting Physician: ${patientInformation.admittingPhysician}'),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 24)),
        ]);
      }

      // Add edited texts.
      for (final editedText in editedTexts) {
        widgets.addAll([
          pw.Text(editedText.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
          pw.Text(editedText.text, style: const pw.TextStyle(fontSize: 16)),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
        ]);
      }

      // Return widgets. `pw.MultiPage` will handle the page breaks automatically.
      return widgets;
    },
  );
}
