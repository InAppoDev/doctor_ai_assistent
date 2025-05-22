import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/datetime_extension.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/user_model/user_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class PatientInformationWidget extends StatelessWidget {
  final AppointmentModel? patientInformation;
  final UserModel? user;

  const PatientInformationWidget({
    super.key,
    required this.patientInformation,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleAndSubtitle(
              title: 'Patient Name:',
              subtitle: (patientInformation?.firstName ?? '') +
                  (patientInformation?.lastName ?? ''))
          .paddingOnly(bottom: 12),
      TitleAndSubtitle(
        title: 'Age:',
        subtitle: patientInformation?.birth.getFormattedBirth() ?? '',
      ).paddingOnly(bottom: 12),
      TitleAndSubtitle(
        title: 'DOB:',
        subtitle:
            '${patientInformation?.birth.toShortNameOfMonthAndDay()}, ${patientInformation?.birth.year}',
      ).paddingOnly(bottom: 12),
      TitleAndSubtitle(
        title: 'Medical Record Number:',
        subtitle: patientInformation?.record ?? '',
      ).paddingOnly(bottom: 12),
      TitleAndSubtitle(
        title: 'Date of admission:',
        subtitle:
            '${patientInformation?.when.toNameOfMonthAndDay()}, ${patientInformation?.when.toUSAhourString()}',
      ).paddingOnly(bottom: 12),
      TitleAndSubtitle(
        title: 'Admitting Physician:',
        subtitle: user != null
            ? '${user!.firstName} ${user!.lastName}'
            : patientInformation?.physician ?? '',
      ),
    ]);
  }
}

class TitleAndSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleAndSubtitle(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
                  style: AppTextStyles.mediumPx16
                      .copyWith(color: AppColors.accentBlue))
              .paddingOnly(bottom: 6),
          Text(subtitle, style: AppTextStyles.mediumPx16)
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
                  style: AppTextStyles.mediumPx16
                      .copyWith(color: AppColors.accentBlue))
              .paddingOnly(bottom: 6),
          Text(subtitle, style: AppTextStyles.mediumPx16)
        ],
      ),
    );
  }
}
