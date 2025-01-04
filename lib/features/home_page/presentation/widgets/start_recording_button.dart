import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class StartRecordingButton extends StatelessWidget {
  final bool isReviewed;
  final Function()? onPressed;
  const StartRecordingButton({
    super.key,
    required this.isReviewed,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!isReviewed) {
            onPressed?.call();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: isReviewed ? AppColors.disabled : AppColors.accentBlue, width: 1),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.bg
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.mic,
                color: isReviewed ? AppColors.disabled : AppColors.accentBlue,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Start Recording',
                style: AppTextStyles.mediumPx16.copyWith(
                  color: isReviewed ? AppColors.disabled : AppColors.accentBlue
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
