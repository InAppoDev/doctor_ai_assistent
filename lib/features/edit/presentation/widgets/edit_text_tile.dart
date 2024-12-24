import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/avatar_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class EditTextTile extends StatelessWidget {
  const EditTextTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlue.withOpacity(0.4),
            offset: const Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const AvatarWidget().paddingOnly(right: 12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (Responsive.isMobile(context))
                      const Expanded(
                        flex: 1,
                        child: AvatarWidget(),
                      ).paddingOnly(right: 12),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context) ? 16 : 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.accentBlue,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Doctor',
                          style: AppTextStyles.regularPx16,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 16),
                const TextField(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}