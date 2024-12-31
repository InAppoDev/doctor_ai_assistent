import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/column_builder_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalFormDialogWidget extends StatelessWidget {
  final Function() onSaveClick;
  final Function() onCloseClick;
  final List<String> medicalForms;
  final ValueNotifier<int?> selectedFormIndex;

  const MedicalFormDialogWidget({
    super.key,
    required this.onCloseClick,
    required this.onSaveClick,
    required this.medicalForms,
    required this.selectedFormIndex
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bg,
      insetPadding: Responsive.isDesktop(context) 
        ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2) 
        : const EdgeInsets.symmetric(horizontal: 24),
      child: Responsive(
        mobile: _buildDialogContent(context, isDesktop: false),
        desktop: _buildDialogContent(context, isDesktop: true),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context, {required bool isDesktop}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose a medical form',
                style: AppTextStyles.mediumPx20,
              ).paddingOnly(bottom: 24),
              _buildFormOptions(isDesktop: isDesktop),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onPress: () {
                      onSaveClick();
                    },
                    color: AppColors.accentBlue,
                    textColor: AppColors.white,
                    text: 'Save',
                    textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
                    borderColor: AppColors.accentBlue,
                  ).paddingOnly(right: 16),
                  PrimaryButton(
                    onPress: () {
                      onCloseClick();
                    },
                    color: Colors.transparent,
                    textColor: AppColors.text,
                    text: 'Cancel',
                    textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.text),
                    borderColor: AppColors.accentBlue,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onCloseClick,
              child: SvgPicture.asset(
                AppIcons.closeIcon,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(AppColors.accentBlue, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormOptions({required bool isDesktop}) {
    if (isDesktop) {
      return ValueListenableBuilder<int?>(
        valueListenable: selectedFormIndex,
        builder: (context, selectedIndex, _) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16, 
              mainAxisSpacing: 8, 
              childAspectRatio: 3.5, 
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: medicalForms.length,
            itemBuilder: (context, index) {
              return RadioListTile<int>(
                value: index,
                groupValue: selectedIndex,
                fillColor: WidgetStateProperty.all(AppColors.accentGreen),
                onChanged: (value) {
                  selectedFormIndex.value = value;
                },
                title: Text(
                  medicalForms[index],
                  style: AppTextStyles.regularPx16,
                ),
                activeColor: AppColors.accentBlue,
              );
            },
          );
        },
      );
    } else {
      return ValueListenableBuilder<int?>(
        valueListenable: selectedFormIndex,
        builder: (context, selectedIndex, _) {
          return ColumnBuilder(
            itemCount: medicalForms.length,
            itemBuilder: (context, index) {
              return RadioListTile<int>(
                value: index,
                groupValue: selectedIndex,
                onChanged: (value) {
                  selectedFormIndex.value = value;
                },
                title: Text(
                  medicalForms[index],
                  style: AppTextStyles.regularPx16,
                ),
                activeColor: AppColors.accentBlue,
              );
            },
          );
        },
      );
    }
  }
}
