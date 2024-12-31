import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;

  const CustomTextButton({super.key, required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: AppTextStyles.mediumPx16.copyWith(
            decoration: TextDecoration.underline, 
            color: color,
            decorationColor: color
          ),
        ),
      ),
    );
  }
}
