import 'package:ecnx_ambient_listening/features/edit/data/models/pdf_models/edited_text_model.dart';
import 'package:ecnx_ambient_listening/features/edit/data/models/transcribed_text_model.dart';
import 'package:ecnx_ambient_listening/core/services/export_as_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditState extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Quill Controllers
  // ---------------------------------------------------------------------------
  /// Quill controllers for the text editors
  /// Note: This is just a dummy data. This should be replaced with the actual data
  final List<QuillController> _quillControllers = [
    QuillController.basic(),
    QuillController.basic(),
  ];

  List<QuillController> get quillControllers => _quillControllers;

  // ---------------------------------------------------------------------------
  // Transcribed Texts
  // ---------------------------------------------------------------------------
  final List<TranscribedTextModel> _transcribedTexts = [
    TranscribedTextModel(author: 'Doctor 1', text: 'Hello, how are you?'),
    TranscribedTextModel(author: 'Patient 1', text: 'I am fine')
  ];

  List<TranscribedTextModel> get transcribedTexts => _transcribedTexts;

  /// Fetch the Transcribed texts from the API
  /// This method should be replaced with the actual API call
  Future<void> fetchTranscribedTexts() async {
    try {
      // Fetch transcribed texts from the API.
    } catch (e) {
      debugPrint('Error fetching transcribed texts: $e');
    }
  }

  /// export the edited text as the PDF file
  Future<void> exportAsPDF() async {
    try {
      // Export the edited text as a PDF file.
      List<EditedTextModel> editedTexts = [];
      for (int index = 0; index < _quillControllers.length; index++) {
        final editedText = EditedTextModel(
          name: transcribedTexts[index].author,
          text: _quillControllers[index].document.toPlainText(),
        );
        editedTexts.add(editedText);
      }
      await generateEditedTextPdf(
        editedTexts,
        'Transcribed Text',
        null
      );
    } catch (e) {
      debugPrint('Error exporting as PDF: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
