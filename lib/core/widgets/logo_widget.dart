import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  final Function() onTap;

  const LogoWidget({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(AppIcons.logo, height: Responsive.isDesktop(context) ? 44 : 23, width: Responsive.isDesktop(context) ? 102 : 64)
    );
  }
}
