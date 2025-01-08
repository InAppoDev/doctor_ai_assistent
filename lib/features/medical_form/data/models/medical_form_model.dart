class MedicalFormModel {
  final PatientInformationModel patientInformation;
  final List<TitleAndTextModel> medicalHistory;

  const MedicalFormModel({
    required this.patientInformation,
    required this.medicalHistory,
  });
}

/// Patient Information Model
/// Note: This is a hardcoded model class that is used to store the data of the medical form.
class PatientInformationModel {
  final String name;
  final int age;
  final DateTime dob;
  final String recordNumber;
  final DateTime dateOfAdmission;
  final String admittingPhysician;

  const PatientInformationModel({
    required this.name,
    required this.age,
    required this.dob,
    required this.recordNumber,
    required this.dateOfAdmission,
    required this.admittingPhysician,
  });
}

/// Note: This is a hardcoded model class that is used to store the data of the medical form.
class TitleAndTextModel {
  final String title;
  final String text;

  const TitleAndTextModel({required this.title, required this.text});
}
