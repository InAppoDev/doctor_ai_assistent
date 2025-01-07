import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_icons.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/widgets/column_builder_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalFormDialogWidget extends StatelessWidget {
  final Function() onSaveClick;
  final Function() onCloseClick;
  final List<String> medicalForms;
  final ValueNotifier<int?> selectedFormIndex;

  const MedicalFormDialogWidget(
      {super.key,
      required this.onCloseClick,
      required this.onSaveClick,
      required this.medicalForms,
      required this.selectedFormIndex});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bg,
      insetPadding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width * 0.2 : 24),
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
              Responsive(
                mobile: Column(
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
                    ).paddingOnly(bottom: 16),
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
                desktop: Row(
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
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
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
          // return GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 16,
          //     mainAxisSpacing: 8,
          //     childAspectRatio: 3.5,
          //   ),
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: medicalForms.length,
          //   itemBuilder: (context, index) {
          //     return `RadioListTile<int>(
          //       value: index,
          //       groupValue: selectedIndex,
          //       fillColor: WidgetStateProperty.all(AppColors.accentGreen),
          //       onChanged: (value) {
          //         selectedFormIndex.value = value;
          //       },
          //       title: Text(`
          //         medicalForms[index],
          //         style: AppTextStyles.regularPx16,
          //       ),
          //       activeColor: AppColors.accentBlue,
          //     );
          //   },
          // );
          return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  selectedFormIndex.value = 0;
                },
                child: Row(children: [
                  Radio<int>(
                    value: 0,
                    groupValue: selectedIndex,
                    fillColor: WidgetStateProperty.all(AppColors.accentGreen),
                    onChanged: (value) {
                      selectedFormIndex.value = value;
                    },
                  ).paddingOnly(right: 20),
                  Text(
                    medicalForms[0],
                    style: AppTextStyles.regularPx20,
                  ),
                ]).paddingOnly(right: 40),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  selectedFormIndex.value = 1;
                },
                child: Row(children: [
                  Radio<int>(
                    value: 1,
                    groupValue: selectedIndex,
                    fillColor: WidgetStateProperty.all(AppColors.accentGreen),
                    onChanged: (value) {
                      selectedFormIndex.value = value;
                    },
                  ).paddingOnly(right: 20),
                  Text(
                    medicalForms[1],
                    style: AppTextStyles.regularPx20,
                  ),
                ]),
              ),
            ),
          ]
          );
        },
      );
    } else {
      return ValueListenableBuilder<int?>(
        valueListenable: selectedFormIndex,
        builder: (context, selectedIndex, _) {
          return ColumnBuilder(
            itemCount: medicalForms.length,
            mainAxisSize: MainAxisSize.min,
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
    }
  }
}
