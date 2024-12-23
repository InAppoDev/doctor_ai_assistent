import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list_widget.dart';
import 'package:doctor_ai_assistent/features/record/presentation/pages/record_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: Responsive.isDesktop(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LogoWidget(onTap: () {}).paddingOnly(top: Responsive.isDesktop(context) ? 16 : 8)
                  ],
                ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 26),
                Responsive(
                  desktop: const Text(
                    'Edit the text', 
                    style: AppTextStyles.mediumPx32
                  ),
                  mobile: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {}, 
                        child: SvgPicture.asset(
                          AppIcons.closeIcon, 
                          height: 12, 
                          width: 18, 
                          color: AppColors.accentBlue
                        )
                      ),
                      const Text(
                        'Edit the text', 
                        style: AppTextStyles.mediumPx24
                      ),
                      Container()
                    ],
                  ),
                ),
                if (Responsive.isMobile(context))
                  PrimaryButton(
                    onPress: () {},
                    color: AppColors.accentGreen,
                    textColor: AppColors.white,
                    text: 'Transcribed',
                    borderColor: AppColors.accentGreen,
                  )
                
              ]
            ).paddingAll(Responsive.isDesktop(context) ? 40 : 16),
          ),
          if (Responsive.isDesktop(context)) ...[
            const VerticalDivider(
              width: 1,
              color: AppColors.accentBlue,
            ),
            Expanded(
              flex: 1,
              child: TranscribedList(
                list: List.generate(5, (index) => index),
              )
            )
          ]
        ],
      ),
    ));
  }
}
