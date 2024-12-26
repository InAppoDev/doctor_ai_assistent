import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ExportAsTextButton extends StatelessWidget {
  final Function() onPressed;

  const ExportAsTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          'Export as',
          style: AppTextStyles.mediumPx16.copyWith(
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }
}
