import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/record_button.dart';
import 'package:doctor_ai_assistent/features/record/provider/record_provider.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                recordProvider.timerText,
                style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx32,
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: Responsive.isDesktop(context) ? 8 : 6),
              Text(
                'Recording',
                style: Responsive.isDesktop(context) ? AppTextStyles.regularPx20.copyWith(color: AppColors.accentGreen) : AppTextStyles.regularPx14.copyWith(color: AppColors.accentGreen),
              ).paddingOnly(bottom: 70),
              recordProvider.status == 1
                  ? Container()
                  : const Divider(
                color: AppColors.accentBlue,
                thickness: 3,
              ).paddingOnly(
                bottom: Responsive.isDesktop(context) ? 200 : 50
              ),
              RecordButton(
                height: Responsive.isDesktop(context) ? 88 : 62,
                width: Responsive.isDesktop(context) ? 88 : 62,
                padding: Responsive.isDesktop(context) ? 30 : 20,
                size: Responsive.isDesktop(context) ? 28 : 24,
                image: recordProvider.status == 1
                    ? 'assets/icons/stop.png'
                    : recordProvider.status == 2
                      ? 'assets/icons/start.png'
                      : null,
              )
            ],
          )
        )
      ),
    );
  }
}