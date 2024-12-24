import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
import 'package:doctor_ai_assistent/core/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class TranscribedListItemWidget extends StatelessWidget {
  final String text;
  final DateTime date;

  const TranscribedListItemWidget({super.key, required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AvatarWidget().paddingOnly(right: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date.toHourAndMinute(),
                      style: AppTextStyles.mediumPx16
                    ),
                    Text(
                      date.toNameOfMonthAndDay(),
                      style: AppTextStyles.regularPx12.copyWith(
                        color: AppColors.disabled
                      )
                    )
                  ]
                ).paddingOnly(bottom: 8),
                Text(
                  text,
                  style: AppTextStyles.regularPx16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis
                )
              ]
            ),
          )
        ],
      )
    );
  }
}
