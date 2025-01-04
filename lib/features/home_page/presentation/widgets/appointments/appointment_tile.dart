import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/data/models/appointment_model.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/review_checkbox.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/start_recording_button.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/time_with_icon_widget.dart';
import 'package:flutter/material.dart';

class AppointmentTileWidget extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentTileWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bg,
          border: Border.all(width: 1, color: AppColors.accentBlue)),
      padding: Responsive.isDesktop(context) ? const EdgeInsets.all(16) : const EdgeInsets.all(12),
      child: Row(
          mainAxisAlignment: Responsive.isDesktop(context) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
          crossAxisAlignment: Responsive.isDesktop(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment:
                    Responsive.isDesktop(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeWithIconWidget(time: appointment.time, minutes: appointment.minutes),
                      if (Responsive.isMobile(context)) ...[
                        const SizedBox(height: 24),
                        ReviewCheckboxWidget(isReviewed: appointment.isReviewed)
                      ]
                    ],
                  ),
                  if (Responsive.isDesktop(context)) const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.name,
                          style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx20 : AppTextStyles.mediumPx16),
                      SizedBox(height: Responsive.isDesktop(context) ? 12 : 8),
                      Text(appointment.getFormattedBirthDate(),
                          style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx14 : AppTextStyles.regularPx14),
                      if (Responsive.isMobile(context)) ...[
                        const SizedBox(height: 16),
                        StartRecordingButton(
                            isReviewed: appointment.isReviewed,
                            onPressed: () {
                              AutoRouter.of(context).push(const RecordRoute());
                            }),
                      ]
                  ]),
                ],
              ),
            ),
            if (Responsive.isDesktop(context))
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StartRecordingButton(
                          isReviewed: appointment.isReviewed,
                          onPressed: () {
                            // Start recording
                          })
                      .paddingOnly(bottom: 8),
                  ReviewCheckboxWidget(
                    isReviewed: appointment.isReviewed,
                  )
              ])
          ]),
    );
  }
}
