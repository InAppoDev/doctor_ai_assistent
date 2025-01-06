import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final String? hintText;
  final String? extraText;
  final Widget? suffixIcon;
  final Future<void> Function()? filterNavigator;
  final Function()? onTap;
  final Function()? onTapSuffixIcon;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool? prefixIcon;
  final TextInputAction? textInputAction;
  final Function()? onSaved;
  final BuildContext context;
  final Color? fillColor;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final bool loseFocusOnTapOutside;
  final String? label;
  final TextStyle? labelStyle;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFieldWidget(
      {super.key,
      required this.controller,
      this.onChanged,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.hintText,
      this.extraText,
      this.filterNavigator,
      this.onTap,
      this.readOnly,
      this.prefixIcon = false,
      this.textInputAction,
      this.onSaved,
      required this.context,
      this.onTapSuffixIcon,
      this.suffixIcon,
      this.fillColor,
      this.borderRadius,
      this.keyboardType,
      this.validator,
      this.hintStyle,
      this.loseFocusOnTapOutside = false,
      this.label,
      this.labelStyle,
      this.obscureText,
      this.inputFormatters = const []
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(label!, style: labelStyle ?? AppTextStyles.regularPx16)
                  .paddingOnly(bottom: Responsive.isDesktop(context) ? 12 : 8),
            ],
          ),
        TextFormField(
          controller: controller,
          autocorrect: false,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          maxLines: 1,
          onTap: onTap,
          onTapOutside: loseFocusOnTapOutside
              ? (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          onSaved: (newValue) {
            print(newValue);
          },
          readOnly: readOnly ?? false,
          style: Responsive.isDesktop(context) ? AppTextStyles.regularPx14 : AppTextStyles.regularPx16,
          textInputAction: textInputAction ?? TextInputAction.done,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Error';
                }
                return null;
              },
          onEditingComplete: onSaved,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 16 : 12,
            ),
            fillColor: fillColor,
            enabledBorder: getBorder(enabledBorderColor ?? AppColors.text),
            disabledBorder: getBorder(enabledBorderColor ?? AppColors.text),
            focusedBorder: getBorder(focusedBorderColor ?? AppColors.accentBlue),
            errorBorder: getBorder(AppColors.error),
            hintText: extraText != null ? ("$hintText$extraText") : hintText ?? '',
            hintStyle: hintStyle ?? AppTextStyles.regularPx14.copyWith(color: AppColors.disabled),
            prefixIcon: prefixIcon == true ? buildPrefixIcon() : null,
            // prefixIconConstraints: const BoxConstraints(maxWidth: 45, maxHeight: 25),
            suffixIcon: suffixIcon != null ? buildSuffixIcon(context) : null,
            suffixIconConstraints: const BoxConstraints(maxWidth: 45, maxHeight: 40),
          ),
        ),
      ],
    );
  }

  Widget buildSuffixIcon(BuildContext context) {
    return suffixIcon ?? Container();
  }

  Widget buildPrefixIcon() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/icons/search.png',
        color: AppColors.disabled,
        width: 24.w,
      ),
    );
  }

  OutlineInputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      borderSide: BorderSide(color: color),
    );
  }
}
