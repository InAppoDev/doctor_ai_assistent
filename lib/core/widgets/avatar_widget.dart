import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final double iconSize;

  const AvatarWidget({
    super.key, 
    this.color = AppColors.accentBlue, 
    this.height = 32,
    this.width = 32,
    this.borderRadius = 8,
    this.iconSize = 24
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.person,
        color: AppColors.bg,
        size: iconSize,
      ),
    );
  }
}
