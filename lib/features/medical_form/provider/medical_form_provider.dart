import 'dart:io';

import 'package:csv/csv.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/form_model/form_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/speech_to_text/speech_to_text_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class MedicalFormProvider extends ChangeNotifier {
  MedicalFormProvider(this.appointmentId);
  final int appointmentId;
  final SpeechToTextService _speechService = SpeechToTextService();

  bool isListening = false;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _backendService = Network(prefs);
    await getAppointment();
    await _getForms();

    await _speechService.init();
  }

  late final Network _backendService;
  bool isLoading = false;

  AppointmentModel? appointment;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  Future<void> getAppointment() async {
    isLoading = true;
    notifyListeners();

    appointment = await _backendService.getAppointmentById(appointmentId);
    isLoading = false;
    notifyListeners();
  }

  List<FormModel> forms = [];

  Future<void> createForm() async {
    final form =
        await _backendService.createForm(name: 'History of Present Illness');
    if (form != null) {
      forms.add(form);
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchController.clear();
    notifyListeners();
  }

  Future<void> _getForms() async {
    forms = await _backendService.getForms();
    notifyListeners();
  }

  void updateFormTitleText(int i, String text) {
    forms = forms.map((item) {
      if (forms[i] == item) {
        return item.copyWith(name: text);
      }
      return item;
    }).toList();
    notifyListeners();
  }

  void updateFormDescriptionText(int i, String text) {
    forms = forms.map((item) {
      if (forms[i] == item) {
        return item.copyWith(conclusion: text);
      }
      return item;
    }).toList();
    notifyListeners();
  }

  Future<void> updateForm() async {
    for (final form in forms) {
      await _backendService.updateForm(
        id: form.id,
        name: form.name,
        conclusion: form.conclusion ?? '',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Medical Form Model
  // ---------------------------------------------------------------------------

  /// Fetch the Medical form from the API
  /// This method should be replaced with the actual API call
  Future<void> fetchTranscribedTexts() async {
    try {
      // Fetch medical form from the API.
    } catch (e) {
      debugPrint('Error fetching transcribed texts: $e');
    }
  }

  Future<void> exportAsPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => forms.map((chunk) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(chunk.name,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(chunk.conclusion ?? ''),
              pw.SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  Future<void> exportAsCSV() async {
    List<List<String>> csvData = [
      ['Title', 'Conclusion'],
    ];

    for (var chunk in forms) {
      csvData.add([
        'Speaker ${chunk.name}',
        chunk.conclusion?.replaceAll('\n', ' ') ?? '',
      ]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/transcription_export.csv';
    final file = File(path);

    await file.writeAsString(csvString);

    await SharePlus.instance.share(
      ShareParams(
        text: 'Exported CSV file',
        files: [XFile(path)],
      ),
    );
  }

  void onMicTap() async {
    if (isListening) {
      _speechService.stopListening();
      isListening = false;
      notifyListeners();
      return;
    }

    isListening = true;
    notifyListeners();

    await _speechService.startListening((SpeechRecognitionResult result) {
      final recognizedText = result.recognizedWords;

      _searchController.text +=
          (recognizedText.isNotEmpty ? ' $recognizedText' : '');

      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );

      notifyListeners();
    });
  }

  /// clear the found search terms
  /// This method should be called when the search term is cleared

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
