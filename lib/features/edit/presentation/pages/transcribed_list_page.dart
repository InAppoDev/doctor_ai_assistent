import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/audio_progress_bar.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list/transcribed_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppIcons.closeIcon,
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(AppColors.accentBlue, BlendMode.srcIn),
                    ),
                  ),
                )
              ]
            ).paddingAll(8),
            const Text(
              'Transcribed',
              style: AppTextStyles.mediumPx20,
            ).paddingOnly(bottom: 24),
            Expanded(
              child: TranscribedList(
                list: List.generate(5, (index) => index),
              ).paddingSymmetric(horizontal: 13),
            ),
            // TODO: need to provide the progress bar with the playprovider
            const AudioProgressBar().paddingOnly(bottom: 32),
          ],
        ),
      )
    );
  }
}
