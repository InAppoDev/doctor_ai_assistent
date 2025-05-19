import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditState extends ChangeNotifier {
  late final Network _network;

  EditState() {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _network = Network(prefs);
    // await fetchTranscribedTexts();
    _setUpQuillControllerData();
  }

  final List<LogModel> logs = [];
  bool isLoading = false;

  // Future<void> getLog

  // ---------------------------------------------------------------------------
  // Quill Controllers
  // ---------------------------------------------------------------------------
  /// Quill controllers for the text editors
  /// Note: This is just a dummy data. This should be replaced with the actual data
  final List<QuillController> _quillControllers = [];

  void _setUpQuillControllerData() {
    for (final log in logs) {
      _quillControllers.add(QuillController.basic(
          configurations: QuillControllerConfigurations()));
    }
  }

  List<QuillController> get quillControllers => _quillControllers;

  // ---------------------------------------------------------------------------
  // Transcribed Texts
  // ---------------------------------------------------------------------------

  /// Fetch the Transcribed texts from the API
  /// This method should be replaced with the actual API call
  Future<void> fetchTranscribedTexts() async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedLogs = await _network.getLogs();

      logs.addAll(fetchedLogs);
    } catch (e) {
      debugPrint('Error fetching transcribed texts: $e');
    }
    isLoading = false;
    notifyListeners();
    print('logsssss - $logs');
  }

  /// export the edited text as the PDF file
  Future<void> exportAsPDF() async {
    try {
      // Export the edited text as a PDF file.
      // List<EditedTextModel> editedTexts = [];
      // for (int index = 0; index < _quillControllers.length; index++) {
      //   final editedText = EditedTextModel(
      //     name: transcribedTexts[index].author,
      //     text: _quillControllers[index].document.toPlainText(),
      //   );
      //   editedTexts.add(editedText);
      // }
      // await generateEditedTextPdf(editedTexts, 'Transcribed Text', null);
    } catch (e) {
      debugPrint('Error exporting as PDF: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
