import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/datetime_extension.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/review_checkbox.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/start_recording_button.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/time_with_icon_widget.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/pages/record_page.dart';
import 'package:flutter/material.dart';

class AppointmentTileWidget extends StatelessWidget {
  final AppointmentModel appointment;
  final LogModel? log;

  const AppointmentTileWidget({
    super.key,
    required this.appointment,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    final isLogNotNull = log != null;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.bg,
        border: Border.all(
          width: 1,
          color: AppColors.accentBlue,
        ),
      ),
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.all(16)
          : const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: Responsive.isDesktop(context)
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: Responsive.isDesktop(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: Responsive.isDesktop(context)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeWithIconWidget(
                        time: appointment.when,
                      ),
                      if (isLogNotNull) ...[
                        SizedBox(
                          height: Responsive.isMobile(context) ? 8 : 12,
                        ),
                        Text(
                          '${log!.duration} min',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: AppColors.disabled,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ).paddingOnly(left: 32, right: 8),
                      ],
                      if (Responsive.isMobile(context)) ...[
                        const SizedBox(height: 24),
                        ReviewCheckboxWidget(isReviewed: isLogNotNull)
                      ]
                    ],
                  ),
                ),
                if (Responsive.isDesktop(context)) const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${appointment.firstName} ${appointment.lastName}',
                        style: Responsive.isDesktop(context)
                            ? AppTextStyles.mediumPx20
                            : AppTextStyles.mediumPx16),
                    SizedBox(height: Responsive.isDesktop(context) ? 12 : 8),
                    Text(appointment.birth.getFormattedBirth(),
                        style: Responsive.isDesktop(context)
                            ? AppTextStyles.mediumPx14
                            : AppTextStyles.regularPx14),
                    if (Responsive.isMobile(context)) ...[
                      const SizedBox(height: 16),
                      StartRecordingButton(
                        isReviewed: isLogNotNull,
                        onPressed: () {
                          RecordRoute(RecordPageArgs(appointment: appointment))
                              .push(context);
                        },
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
          if (Responsive.isDesktop(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StartRecordingButton(
                    isReviewed: isLogNotNull,
                    onPressed: () {
                      RecordRoute(RecordPageArgs(appointment: appointment))
                          .push(context);
                    }).paddingOnly(bottom: 8),
                ReviewCheckboxWidget(
                  isReviewed: isLogNotNull,
                )
              ],
            )
        ],
      ),
    );
  }
}
