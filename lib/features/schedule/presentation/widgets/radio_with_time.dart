import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/time_of_day_extension.dart';
import 'package:flutter/material.dart';

class RadioWithTimeWidget extends StatelessWidget {
  final Function(TimeOfDay) onPressed;
  final TimeOfDay time;
  final bool isSelected;
  final bool isAvailable;
  const RadioWithTimeWidget({super.key, required this.onPressed, required this.time, required this.isSelected, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onPressed(time);
        },
        child: Row(children: [
          if (!isAvailable)
            Container(
              width: 18,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.disabled),
                shape: BoxShape.circle,
              ),
            ).paddingOnly(right: 20),
          if (isAvailable)
            Radio<TimeOfDay>(
              value: time,
              groupValue: isSelected ? time : null, 
              fillColor: WidgetStateProperty.all(AppColors.accentGreen),
              onChanged: (value) {
                onPressed(time);
              },
            ).paddingOnly(right: 20),
          Text(
            time.toUsaTime(),
            style: AppTextStyles.regularPx20,
          ),
        ]).paddingOnly(right: 40),
      ),
    );
  }
}
