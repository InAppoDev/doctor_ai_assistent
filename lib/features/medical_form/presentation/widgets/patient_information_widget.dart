import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/datetime_extension.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:flutter/material.dart';

class PatientInformationWidget extends StatelessWidget {
  final PatientInformationModel patientInformation;
  const PatientInformationWidget({super.key, required this.patientInformation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndSubtitle(title: 'Patient Name:', subtitle: patientInformation.name).paddingOnly(bottom: 12),
        TitleAndSubtitle(title: 'Age:', subtitle: patientInformation.age.toString()).paddingOnly(bottom: 12),
        TitleAndSubtitle(title: 'DOB:', subtitle: '${patientInformation.dob.toShortNameOfMonthAndDay()}, ${patientInformation.dob.year}').paddingOnly(bottom: 12),
        TitleAndSubtitle(title: 'Medical Record Number:', subtitle: patientInformation.recordNumber).paddingOnly(bottom: 12),
        TitleAndSubtitle(title: 'Date of admission:', subtitle: '${patientInformation.dateOfAdmission.toNameOfMonthAndDay()}, ${patientInformation.dateOfAdmission.toUSAhourString()}').paddingOnly(bottom: 12),
        TitleAndSubtitle(title: 'Admitting Physician:', subtitle: patientInformation.admittingPhysician),
    ]);
  }
}

class TitleAndSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleAndSubtitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentBlue)
          ).paddingOnly(bottom: 6),
          Text(
            subtitle,
            style: AppTextStyles.mediumPx16
          )
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentBlue)
          ).paddingOnly(bottom: 6),
          Text(
            subtitle,
            style: AppTextStyles.mediumPx16
          )
        ],
      ),
    );
  }
}
