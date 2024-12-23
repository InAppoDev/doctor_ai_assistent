import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/widgets/avatar_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditTextTile extends StatelessWidget {
  const EditTextTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlue,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 0
          )
        ]
      ),
      child: Row(
        children: [
          if (Responsive.isDesktop(context)) const AvatarWidget(),
          Column(
            children: [
              Row(
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      flex: 1,
                      child: AvatarWidget(),
                    ),
                  const Expanded(flex: 2, child: TextField()),
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(AppIcons.copyIcon, height: 24, width: 24,)
                      ),
                    ),
                ]
              ).paddingOnly(bottom: 16),
              const TextField()
            ],
          )
        ]
      ),
    );
  }
}