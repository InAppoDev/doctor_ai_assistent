import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HistoryLogModal extends StatelessWidget {
  final String before;
  final String after;
  final Function() onCloseClick;

  const HistoryLogModal({super.key, required this.before, required this.after, required this.onCloseClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bg,
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 40 : 16, vertical: Responsive.isDesktop(context) ? 40 : 24),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'History log Symptop',
                    style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx24 : AppTextStyles.mediumPx20,
                  )
                ]).paddingOnly(bottom: 32),
                Text(
                  '(was modified 2024-11-07, 13:43:33 by User_2)',
                  style: Responsive.isDesktop(context)
                      ? AppTextStyles.mediumPx16.copyWith(color: AppColors.error)
                      : AppTextStyles.mediumPx14.copyWith(color: AppColors.error),
                ).paddingOnly(bottom: Responsive.isDesktop(context) ? 16 : 12),
                Text(after, style: AppTextStyles.regularPx16)
                    .paddingOnly(bottom: Responsive.isDesktop(context) ? 32 : 16),
                Text(
                  'Before the Symptop',
                  style: Responsive.isDesktop(context)
                      ? AppTextStyles.mediumPx16.copyWith(color: AppColors.accentGreen)
                      : AppTextStyles.mediumPx14.copyWith(color: AppColors.accentGreen),
                ).paddingOnly(bottom: Responsive.isDesktop(context) ? 16 : 12),
                Text(before, style: AppTextStyles.regularPx16)
              ]),
              Positioned(
                top: 0,
                right: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onCloseClick,
                    child: SvgPicture.asset(
                      AppIcons.closeIcon,
                      height: Responsive.isDesktop(context) ? 32 : 24,
                      width: Responsive.isDesktop(context) ? 32 : 24,
                      colorFilter: const ColorFilter.mode(AppColors.accentBlue, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
