import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimeWithIconWidget extends StatelessWidget {
  final DateTime time;
  final double? minutes;

  const TimeWithIconWidget({
    super.key, 
    required this.time,
    this.minutes
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppIcons.alarmIcon,
          height: 24,
          width: 24,
        ).paddingOnly(right: 8, top: 2),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              time.toUSAtimeString(),
              style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx20 : AppTextStyles.mediumPx16,
            ),
            if (minutes != null) ...[
              SizedBox(height: Responsive.isDesktop(context) ? 12 : 8),
              Text(
                '${minutes!.toInt().toString()} min',
                style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx14.copyWith(color: AppColors.disabled) : AppTextStyles.regularPx14.copyWith(color: AppColors.disabled),
                textAlign: TextAlign.start,
              )
            ]
          ],
        )
    ]);
  }
}
