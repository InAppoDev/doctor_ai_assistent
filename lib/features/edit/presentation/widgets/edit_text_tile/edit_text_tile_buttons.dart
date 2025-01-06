import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditTextTileButtons extends StatelessWidget {
  final Function() onCopyClick;
  final Function()? onTranslateClick;
  final Function()? onPlayClick;

  const EditTextTileButtons({
    super.key,
    required this.onCopyClick,
    this.onTranslateClick,
    this.onPlayClick,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Row(children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onCopyClick, 
              child: SvgPicture.asset(
                AppIcons.copyIcon,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn),
              ),
            ),
          ).paddingOnly(right: onTranslateClick != null ? 16 : 0),
          if (onTranslateClick != null)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTranslateClick,
                child: SvgPicture.asset(AppIcons.translateIcon,
                        height: 24, width: 24, colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn))
                    .paddingOnly(right: 16),
              ),
            ),
          if (onPlayClick != null)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onPlayClick,
                child: SvgPicture.asset(AppIcons.playIcon,
                    height: 24, width: 24, colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn)),
              ),
            )
        ]),
        desktop: Column(children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onCopyClick, 
              child: SvgPicture.asset(
                AppIcons.copyIcon,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn),
              ),
            ),
          ).paddingOnly(bottom: 16),
          if (onTranslateClick != null)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTranslateClick,
                child: SvgPicture.asset(AppIcons.translateIcon,
                        height: 24, width: 24, colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn))
              ),
            ).paddingOnly(bottom: 16),
          if (onPlayClick != null)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onPlayClick,
                child: SvgPicture.asset(AppIcons.playIcon,
                    height: 24, width: 24, colorFilter: const ColorFilter.mode(AppColors.disabled, BlendMode.srcIn)),
              ),
            )
        ]));
  }
}
