import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
import 'package:doctor_ai_assistent/core/widgets/avatar_widget.dart';
import 'package:doctor_ai_assistent/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscribedListItemWidget extends StatelessWidget {
  /// The text and date should be changed to the actual data model
  final String text;
  final DateTime date;
  final int id; 


  final Function() onTap;
  const TranscribedListItemWidget({super.key, required this.text, required this.id, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: context.read<PlayerProvider>().transcribedId == id ? AppColors.accentBlue : AppColors.disabled, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AvatarWidget().paddingOnly(right: 12),
                Expanded(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(date.toHourAndMinute(), style: AppTextStyles.mediumPx16),
                      Text(date.toNameOfMonthAndDay(), style: AppTextStyles.regularPx12.copyWith(color: AppColors.disabled))
                    ]).paddingOnly(bottom: 8),
                    Text(text, style: AppTextStyles.regularPx16, maxLines: 2, overflow: TextOverflow.ellipsis)
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
