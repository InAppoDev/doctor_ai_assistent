import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TranscribedListPage extends StatelessWidget {
  const TranscribedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.closeIcon,
                    height: 24,
                    width: 24,
                    color: AppColors.accentBlue
                  ),
                )
              ]
            ).paddingAll(8),
            const Text(
              'Transcribed',
              style: AppTextStyles.mediumPx20,
            ).paddingOnly(bottom: 24),
            TranscribedList(
              list: List.generate(5, (index) => index),
            ).paddingSymmetric(horizontal: 13)
          ],
        ),
      )
    );
  }
}
