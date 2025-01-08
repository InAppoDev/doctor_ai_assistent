import 'package:ecnx_ambient_listening/features/edit/data/models/pdf_models/edited_text_model.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/pdf_page/pdf_edit_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MedicalFormProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Quill Controllers
  // ---------------------------------------------------------------------------
  /// Quill controllers for the text editors
  /// Note: This is just a dummy data. This should be replaced with the actual data
  final List<QuillController> _quillControllers = List.generate(17, (index) => QuillController.basic());

  List<QuillController> get quillControllers => _quillControllers;

  /// Creation of pdf file containing the edited text content
  /// The edited text content is displayed in a Quill rich text editor.
  Future<void> exportAsPDF() async {
    try {
      //  Export the edited text as a PDF file.
      List<EditedTextModel> editedTexts = [];
      for (int index = 0; index < _quillControllers.length; index++) {
        final editedText = EditedTextModel(
          name: _medicalFormModel.medicalHistory[index].title,
          text: _quillControllers[index].document.toPlainText(),
        );
        editedTexts.add(editedText);
      }
      await generateEditedTextPdf(
        editedTexts,
        'Internal Medicine ICU History and Physical',
        _medicalFormModel.patientInformation,
      );

    } catch (e) {
      debugPrint('Error exporting as PDF: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Medical Form Model
  // ---------------------------------------------------------------------------
  final MedicalFormModel _medicalFormModel = MedicalFormModel(
    patientInformation: PatientInformationModel(
      name: 'John Doe',
      age: 44,
      dob: DateTime.now(),
      dateOfAdmission: DateTime.now(),
      recordNumber: '12345',
      admittingPhysician: 'Dr. Smith',
    ),
    medicalHistory: const [
      TitleAndTextModel(
        title: 'History Taken From',
        text: 'Information source:60032',
      ),
      TitleAndTextModel(
        title: 'Chief Complaint/Reason for Visit',
        text: 'Sample what brings you here today/why are you here today',
      ),
      TitleAndTextModel(
        title: 'History of Present Illness',
        text: 'sample Dr. Modibo Usman is a 48 y/o M with a h/o Great Health and Arthritis presenting with complaint of Having cough, runny nose and sore throat for 3 days. Patient c/o cough productive of whitish sputum associated with sore throat, odynophagia, posterior neck pain, generalized weakness and body aches. Neck pain is ~5/10 intensity, non-radiating and triggered by swallowing. No relieving factors. He denies fever or chills, SOB, chest pain or headache. His son had similar symptoms 3 days ago but recovered fully without testing. He is UpToDate with his COVID vaccine but is unsure if he has received the influenza vaccine. Pt reported prior similar symptoms a few months agoI',
      ),
      TitleAndTextModel(
        title: 'Past Medical History',
        text: 'sampleArthritis',
      ),
      TitleAndTextModel(
        title: 'Past Surgical History',
        text: 'sampleAppendectomy',
      ),
      TitleAndTextModel(
        title: 'Allergies',
        text: 'sampleAzithromycin',
      ),
      TitleAndTextModel(
        title: 'Medications',
        text: 'sampleAspirin, Vitamin D',
      ),
      TitleAndTextModel(
        title: 'Family History',
        text: '',
      ),
      TitleAndTextModel(
        title: 'Social History',
        text: '',
      ),
      TitleAndTextModel(
        title: 'Review of Systems: [pre-populated]',
        text: '''Constitutional: Denies fevers, chills, weight gain or weight loss.
HENT: Denies headache, sore throat or changes in hearing.
Eyes: Denies changes in vision or double vision.
Cardiovascular: Denies chest pain or palpitations.
Respiratory: Denies shortness of breath or cough.
GI: Denies abdominal pain, nausea, vomiting, or diarrhea.
GU: Denies dysuria or hematuria.
Neurological: Denies focal loss of strength or loss of sensation.
Musculoskeletal: Denies focal weakness, facial droop, or joint swelling.
Psych: Denies depression and anxiety.
Heme: Denies active bleeding.  Denies ecchymosis.
Endo: Denies polyuria or polydipsia.
''',
      ),
      TitleAndTextModel(
        title: 'Physical Examination: [pre-populated]',
        text: '''
General: Pleasant and cooperative. No acute distress.
HENT: Normocephalic and atraumatic.  Oral mucosa moist, no lesions.  Teeth intact.
Eyes: Anicteric. PERL,EOMI. No conjunctival erythema.
Neck: Supple. Trachea midline. No thyromegaly.No JVD
Lymph Nodes: No cervical or supraclavicular lymphadenopathy.
Pulmonary: Clear to auscultation bilaterally. No wheezing, crackles or rhonchi. No accessory muscle use.
Cardiovascular: Regular rate and rhythm. No murmurs.  No peripheral edema to palpation bilaterally.  Dorsalis pedis pulses intact bilaterally.
GI:  Soft, nontender, nondistended.  Normoactive BS. No palpable HSM 
Musculoskeletal: Normal muscle mass for age. No focal joint swelling.
Neuro:  Alert and oriented x 3. Moves all 4 extremities. No gross focal deficits.
Derm: No rash. No lesions.
Heme: No bleeding.  No ecchymosis.
GU: No Foley catheter. No abnormal discharge.
Psych: Mood and affect appropriate. No depression or anxiety.
        ''',
      ),
      TitleAndTextModel(
        title: 'Diagnostic Studies',
        text: '',
      ),
      TitleAndTextModel(
        title: 'EKG',
        text: '',
      ),
      TitleAndTextModel(
        title: 'Imaging',
        text: '',
      ),
      TitleAndTextModel(
        title: 'Labs',
        text: '''
@LABRCNT(WBC:2,HGB:2,HCT:2,PLT:2,INR:2)@
@LABRCNT(Na:2,K:2,Cl:2,CO2:2,BUN:2,CREA:2,GLU:2,Calcium:2,Mg:2,Phos:2,LACTATE:2,TROPONINI:2)@
@LABRCNT(ALT:2,AST:2,Alkphos:2,Bilitot:2,Albumin:2)@
        ''',
      ),
      TitleAndTextModel(
        title: 'ASSESSMENT/PLAN',
        text: '',
      ),
      TitleAndTextModel(
        title: 'CODE',
        text: '',
      ),
    ]
  );

  MedicalFormModel get medicalFormModel => _medicalFormModel;

  /// Fetch the Medical form from the API
  /// This method should be replaced with the actual API call
  Future<void> fetchTranscribedTexts() async {
    try {
      // Fetch medical form from the API.
    } catch (e) {
      debugPrint('Error fetching transcribed texts: $e');
    }
  }

  @override
  void dispose() {
    for (final controller in _quillControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
