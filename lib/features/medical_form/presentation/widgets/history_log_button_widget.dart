import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HistoryLogButtonWidget extends StatelessWidget {
  final Function() onTap;
  const HistoryLogButtonWidget({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'History log',
          style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentBlue, decoration: TextDecoration.underline, decorationColor: AppColors.accentBlue),
        )
      ),
    );
  }
}
