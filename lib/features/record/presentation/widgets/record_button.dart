import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordButton extends StatelessWidget {

  final double height;
  final double width;
  final double padding;
  final String? image;
  final double size;

  const RecordButton({super.key, required this.height, required this.width, this.image, required this.padding, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: AppColors.accentGreen,
        shadows: [
          BoxShadow(
            color: AppColors.accentGreen,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 0),
          )
        ]
      ),
      padding: EdgeInsets.all(padding),
      child: Center(
        child: image != null ? SvgPicture.asset(image!, height: size, width: size,) : Icon(Icons.circle, color: AppColors.bg, size: size,),
      ),
    );
  }
}