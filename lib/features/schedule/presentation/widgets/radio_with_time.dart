import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/time_of_day_extension.dart';
import 'package:flutter/material.dart';

class RadioWithTimeWidget extends StatelessWidget {
  final void Function(TimeOfDay) onPressed;
  final TimeOfDay time;
  final bool isSelected;
  final bool isAvailable;

  const RadioWithTimeWidget({
    super.key,
    required this.onPressed,
    required this.time,
    required this.isSelected,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        isAvailable ? AppColors.accentGreen : AppColors.disabled;

    return MouseRegion(
      cursor: isAvailable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: isAvailable ? () => onPressed(time) : null,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Radio<TimeOfDay>(
                  value: time,
                  groupValue: isSelected ? time : null,
                  fillColor: WidgetStateProperty.all(effectiveColor),
                  onChanged: isAvailable ? (_) => onPressed(time) : null,
                ),
              ),
              Text(
                time.toUsaTime(),
                style: AppTextStyles.regularPx20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
