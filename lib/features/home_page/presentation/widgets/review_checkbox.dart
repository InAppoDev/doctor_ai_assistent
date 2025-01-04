import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReviewCheckboxWidget extends StatelessWidget {
  final bool isReviewed;
  const ReviewCheckboxWidget({
    super.key, 
    required this.isReviewed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.accentGreen,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(2),
          child: Icon(
            isReviewed ? Icons.check : null,
            color: AppColors.accentGreen,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        const Text('Review', style: AppTextStyles.mediumPx16),
      ],
    );
  }
}
