import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class SchedulePatientButton extends StatelessWidget {
  final Function()? onPressed;
  const SchedulePatientButton({
    super.key,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color:  AppColors.accentBlue, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bg
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: AppColors.accentGreen,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Schedule a patient',
              style: AppTextStyles.mediumPx16.copyWith(
                color: AppColors.accentBlue
              )
            ),
          ],
        ),
      ),
    );
  }
}
