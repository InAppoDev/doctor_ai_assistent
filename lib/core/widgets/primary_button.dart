import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function onPress;
  final double height;
  final Color? color;
  final String? icon;
  final String? suffixIcon;
  final Color textColor;
  final Color? disabledColor;
  final bool isDisabled;
  final double elevation;
  final Color? iconColor;
  final Color? borderColor;
  final double borderRadius;
  final double? textSize;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry padding;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? iconSize;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.onPress,
    this.text = '',
    this.isLoading = false,
    this.height = 44,
    this.color,
    this.textColor = AppColors.text,
    this.disabledColor,
    this.isDisabled = false,
    this.elevation = 0,
    this.icon,
    this.suffixIcon,
    this.iconColor,
    this.borderColor = Colors.transparent,
    this.borderRadius = 6.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.textSize = 12,
    this.textAlign,
    this.fontWeight,
    this.iconSize = 24.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isDesktop(context) ? 324 : double.infinity,
      height: height,
      child: MaterialButton(
        elevation: elevation,
        highlightElevation: 0,
        onPressed: isDisabled || isLoading ? null : () => onPress(),
        disabledTextColor: disabledColor ?? AppColors.text,
        color: color ?? AppColors.accentBlue,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor!, width: 2),
        ),
        child: buildChild(context),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    if (isLoading) {
      return const SizedBox(height: 25,child: CircularProgressIndicator.adaptive());
    }
    if (suffixIcon != null && icon != null) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Image.asset(
            icon.toString(),
            width: iconSize!,
            color: iconColor,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            textAlign: textAlign,

            style: textStyle ??
                AppTextStyles.regularPx20.copyWith(
                  color: textColor,
                  fontWeight: fontWeight,
                ),
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            suffixIcon.toString(),
            width: iconSize,
            color: iconColor,
          ),
        ],
      );
    }
    if (icon != null) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Image.asset(
            icon.toString(),
            width: iconSize,
            color: iconColor,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            textAlign: textAlign,
            style: textStyle ??
                AppTextStyles.regularPx20.copyWith(
                  color: textColor,
                  fontWeight: fontWeight,
                ),
          )
        ],
      );
    }

    if (suffixIcon != null) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            text,
            textAlign: textAlign,
            style: textStyle ??
                AppTextStyles.regularPx20.copyWith(
                  color:  textColor,
                  fontWeight: fontWeight,
                ),
          ),
          const Expanded(child: SizedBox()),
          Image.asset(
            suffixIcon.toString(),
            width: iconSize,
            color: iconColor,
          ),
        ],
      );
    }

    return Text(
      text,
      textAlign: textAlign,
      style: textStyle ??
          AppTextStyles.regularPx20.copyWith(
            color: textColor,
            fontWeight: fontWeight,
          ),
    );
  }
}