import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/animated_waves.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/record_button.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/recorded_text.dart';
import 'package:doctor_ai_assistent/features/record/provider/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/responsive/responsive_widget.dart';

@RoutePage()
class RecordPage extends StatelessWidget implements AutoRouteWrapper {
  const RecordPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecordProvider(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = context.watch<RecordProvider>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, _) {
        recordProvider.dispose();
      },
      child: Scaffold(
          backgroundColor: AppColors.bg,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.logo,
                        width: Responsive.isDesktop(context) ? 102 : 63,
                      ).paddingOnly(left: Responsive.isDesktop(context) ? 40 : 16),
                    ],
                  ),
                  Text(
                    '${recordProvider.minutes.toString().padLeft(2, '0')}:${recordProvider.seconds.toString().padLeft(2, '0')}',
                    style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx32,
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: Responsive.isDesktop(context) ? 8 : 6),
                  Text(
                    'Recording',
                    style: Responsive.isDesktop(context)
                        ? AppTextStyles.regularPx20.copyWith(color: AppColors.accentGreen)
                        : AppTextStyles.regularPx14.copyWith(color: AppColors.accentGreen),
                  ).paddingOnly(bottom: 70),
                  recordProvider.status == 1
                      ? Lottie.asset('assets/gifs/wave_animation.json', width: double.infinity, height: Responsive.isDesktop(context) ? 130 : 36,)
                      : const Divider(
                          color: AppColors.accentBlue,
                          thickness: 3,
                        ).paddingOnly(bottom: Responsive.isDesktop(context) ? 200 : 50),
                  RecordButton(
                    height: Responsive.isDesktop(context) ? 88 : 62,
                    width: Responsive.isDesktop(context) ? 88 : 62,
                    padding: Responsive.isDesktop(context) ? 30 : 20,
                    size: Responsive.isDesktop(context) ? 28 : 24,
                    image: recordProvider.status == 1
                        ? AppIcons.pauseIcon
                        : recordProvider.status == 2
                          ? AppIcons.playIcon
                          : null,
                      onPressed: () {
                        if (recordProvider.status == 1) {
                          recordProvider.stopRecording();
                          recordProvider.stopTimer();
                        } else {
                          recordProvider.startRecording();
                          recordProvider.startTimer();
                        }
                      }
                  ).paddingOnly(bottom: Responsive.isDesktop(context) ? 61 : 35),
                  recordProvider.showTextField ? Row(
                    children: [
                      if (Responsive.isDesktop(context))
                        Expanded(
                          flex: 1,
                          child: Container()
                        ),
                      Expanded(
                        flex: 2,
                        child: ColorCodedTextField(
                          height: Responsive.isDesktop(context) ? 330 : 270,
                        ),
                      ),
                      if (Responsive.isDesktop(context))
                        Expanded(
                            flex: 1,
                            child: Container()
                        ),
                    ],
                  ).paddingOnly(
                    bottom: 8,
                    left: Responsive.isDesktop(context) ? 0 : 16,
                    right: Responsive.isDesktop(context) ? 0 : 16,
                  )
                      : Container(height: Responsive.isDesktop(context) ? 330 : 270 ,).paddingOnly(bottom: 8),
                  GestureDetector(
                    onTap: () {
                      recordProvider.toggleTextField();
                    },
                    child: Text(
                      recordProvider.showTextField ? 'Hide text' : 'Show text',
                      style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentBlue, decoration: TextDecoration.underline, decorationColor: AppColors.accentBlue),
                    ),
                  )
              ],
            ).paddingSymmetric(vertical: Responsive.isDesktop(context) ? 56 : 24),
          )
        )
      ),
    );
  }
}
