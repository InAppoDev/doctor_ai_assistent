import 'dart:io';

import 'package:csv/csv.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/form_model/form_model.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:ecnx_ambient_listening/core/network/network.dart';
import 'package:ecnx_ambient_listening/core/speech_to_text/speech_to_text_service.dart';
import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class MedicalFormProvider extends ChangeNotifier {
  MedicalFormProvider({
    required this.appointmentId,
    required this.selectedFormIndex,
  });
  final int appointmentId;
  final int selectedFormIndex;
  final SpeechToTextService _speechService = SpeechToTextService();

  bool isListening = false;
  bool isSaving = false;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    _backendService = Network(prefs);
    await getAppointment();
    await _getForms();
    await _getUser();
    await _speechService.init();
    _fillForms();
    isLoading = false;
    notifyListeners();
  }

  late final Network _backendService;
  bool isLoading = false;

  AppointmentModel? appointment;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  Future<void> getAppointment() async {
    try {
      appointment = await _backendService.getAppointmentById(appointmentId);
    } catch (e) {
      showToast('Failed to load appointment');
      debugPrint('Error in getAppointment: $e');
    }
  }

  UserModel? user;

  Future<void> _getUser() async {
    try {
      user = await _backendService.getUserData();
      notifyListeners();
    } catch (e) {
      showToast('Something went wrong');
    }
  }

  void _fillForms() {
    if (user == null) return;
    int maxExistingId = forms.isEmpty
        ? 0
        : forms.map((f) => f.id).reduce((a, b) => a > b ? a : b);
    int idCounter = maxExistingId + 1;

    final newForms = selectedFormIndex == 0
        ? [
            'Name/Age/DOB',
            'Date of admission',
            'Med. Record Number',
            'General',
            'Pulmonary',
            'Cardiovascular',
            'Musculoskeletal',
            'Neuro',
            'Derm',
            'Heme',
            'GU',
            'Psych',
          ].map((name) {
            return FormModel(
              id: idCounter++,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: name,
              user: user!.id,
              conclusion: _defaultConclusion(name),
            );
          }).toList()
        : [
            {
              'name': 'Chief Complaint/Reason for Visit',
              'conclusion': 'Cronic Headache',
            },
            {
              'name': 'History of Present Illness',
              'conclusion':
                  'Dr. Modibo Usman is a 48 y/o M with a h/o Great Health and Arthritis presenting with complaint of Having cough, runny nose and sore throat for 3 days. Patient c/o cough productive of whitish sputum associated with sore throat, odynophagia, posterior neck pain, generalized weakness and body aches. Neck pain is ~5/10 intensity, non-radiating and triggered by swallowing. No relieving factors. He denies fever or chills, SOB, chest pain or headache. His son had similar symptoms 3 days ago but recovered fully without testing. He is UpToDate with his COVID vaccine but is unsure if he has received the influenza vaccine. Pt reported prior similar symptoms a few months ago.'
            },
            {
              'name': 'Past Medical History',
              'conclusion': 'Hepatitis C from 2020',
            },
            {
              'name': 'Past Surgical History',
              'conclusion': 'NO',
            },
            {
              'name': 'Allergies',
              'conclusion': 'Azithromycin',
            },
            {
              'name': 'Medications',
              'conclusion': 'Aspirin, Vitamin D',
            },
            {
              'name': 'Physical Examination',
              'conclusion':
                  'General: Pleasant and cooperative. No acute distress. \nHENT: Normocephalic...'
            },
            {
              'name': 'Cardiovascular',
              'conclusion':
                  'Regular rate and rhythm. No murmurs. No peripheral edema...'
            },
            {
              'name': 'Diagnostic Studies',
              'conclusion': 'WBC:2, HGB:2, HCT:2, PLT:2, INR:2...'
            },
          ].map((entry) {
            return FormModel(
              id: idCounter++,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: entry['name']!,
              conclusion: entry['conclusion'],
              user: user!.id,
            );
          }).toList();

    forms = newForms;
    notifyListeners();
  }

  String? _defaultConclusion(String name) {
    switch (name) {
      case 'General':
        return 'Pleasant and cooperative. No acute distress.';
      case 'Pulmonary':
        return 'Clear to auscultation bilaterally. No accessory muscle use.';
      case 'Cardiovascular':
        return 'Regular rate and rhythm. No murmurs.  No peripheral edema to palpation bilaterally.  Dorsalis pedis pulses intact bilaterally.';
      case 'Musculoskeletal':
        return 'Normal muscle mass for age. No focal joint swelling.';
      case 'Neuro':
        return 'Alert and oriented x 3. Moves all 4 extremities. No gross focal deficits.';
      case 'Derm':
        return 'No rash. No lesions.';
      case 'Heme':
        return 'No bleeding.  No ecchymosis.';
      case 'GU':
        return 'No Foley catheter. No abnormal discharge.';
      case 'Psych':
        return 'Mood and affect appropriate. No depression or anxiety.';
      case 'History of Present Illness':
        return 'Dr. Modibo Usman is a 48 y/o M with a h/o Great Health and Arthritis presenting with complaint of having cough, runny nose and sore throat for 3 days. '
            'Patient c/o cough productive of whitish sputum associated with sore throat, odynophagia, posterior neck pain, generalized weakness and body aches. '
            'Neck pain is ~5/10 intensity, non-radiating and triggered by swallowing. No relieving factors. '
            'He denies fever or chills, SOB, chest pain or headache. His son had similar symptoms 3 days ago but recovered fully without testing. '
            'He is UpToDate with his COVID vaccine but is unsure if he has received the influenza vaccine. Pt reported prior similar symptoms a few months ago.';
      case 'Past Medical History':
        return 'Hepatitis C from 2020';
      case 'Past Surgical History':
        return 'NO';
      case 'Allergies':
        return 'Azithromycin';
      case 'Medications':
        return 'Aspirin, Vitamin D';
      case 'Physical Examination':
        return 'General: Pleasant and cooperative. No acute distress. \n'
            'HENT: Normocephalic and atraumatic. Oral mucosa moist, no lesions. Teeth intact. \n'
            'Eyes: Anicteric. PERL,EOMI. No conjunctival erythema. \n'
            'Neck: Supple. Trachea midline. No thyromegaly. No JVD. \n'
            'Lymph Nodes: No cervical or supraclavicular lymphadenopathy. \n'
            'Pulmonary: Clear to auscultation bilaterally. No wheezing, crackles or rhonchi. No accessory muscle use.';
      case 'Diagnostic Studies':
        return 'WBC:2, HGB:2, HCT:2, PLT:2, INR:2\n'
            'K:2, Cl:2, CO2:2, BUN:2, CREA:2, GLU:2, Calcium:2, Mg:2, Phos:2, LACTATE:2, TROPONINI:2';
      default:
        return null;
    }
  }

  List<FormModel> forms = [];

  // Future<void> createForm() async {
  //   try {
  //     final form =
  //         await _backendService.createForm(name: 'History of Present Illness');
  //     if (form != null) {
  //       forms.add(form);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     showToast('Something went wrong');
  //   }
  // }

  void clearSearch() {
    _searchController.clear();
    notifyListeners();
  }

  Future<void> _getForms() async {
    try {
      forms = await _backendService.getForms();
      notifyListeners();
    } catch (e) {
      showToast('Failed to load forms');
      debugPrint('Error in _getForms: $e');
    }
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

  Future<void> createForm() async {
    isSaving = true;
    notifyListeners();
    try {
      for (final form in forms) {
        await _backendService.createForm(
          name: form.name,
          conclusion: form.conclusion,
        );
      }
    } catch (e) {
      showToast('Something went wrong');
    }
    isSaving = false;
    notifyListeners();
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
    try {
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
    } catch (e) {
      showToast('Failed to export PDF');
      debugPrint('Error in exportAsPDF: $e');
    }
  }

  Future<void> exportAsCSV() async {
    try {
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
    } catch (e) {
      showToast('Failed to export CSV');
      debugPrint('Error in exportAsCSV: $e');
    }
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

    try {
      await _speechService.startListening((SpeechRecognitionResult result) {
        final recognizedText = result.recognizedWords;

        _searchController.text +=
            (recognizedText.isNotEmpty ? ' $recognizedText' : '');

        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );

        notifyListeners();
      });
    } catch (e) {
      showToast('Microphone error');
      debugPrint('Error in onMicTap: $e');
      isListening = false;
      notifyListeners();
    }
  }

  /// clear the found search terms
  /// This method should be called when the search term is cleared

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
