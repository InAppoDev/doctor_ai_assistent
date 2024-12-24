import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/export_as_text_button.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/edit_texts_list_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
      child: Row(
        children: [
          Expanded(
                flex: 2,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: Responsive.isDesktop(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LogoWidget(onTap: () {}).paddingOnly(top: Responsive.isDesktop(context) ? 16 : 8)
                      ],
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 26),
                    Responsive(
                      desktop: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Edit the text', 
                            style: AppTextStyles.mediumPx32,
                          ),
                        ],
                      ),
                      mobile: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {}, 
                            child: SvgPicture.asset(
                              AppIcons.closeIcon, 
                              height: 12, 
                              width: 18, 
                              color: AppColors.accentBlue
                            )
                          ),
                          const Text(
                            'Edit the text', 
                            style: AppTextStyles.mediumPx24,
                          ),
                          Container()
                        ],
                      ),
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 24),
                    if (Responsive.isMobile(context))
                      PrimaryButton(
                        onPress: () {},
                        color: AppColors.accentGreen,
                        textColor: AppColors.white,
                        text: 'Transcribed',
                        borderColor: AppColors.accentGreen,
                      ),
                    EditTextsListWidget(list: List.generate(5, (index) => index),).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 24),
                    Responsive(
                      desktop: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PrimaryButton(
                            text: 'Fill out a medical form',
                            textColor: AppColors.white,
                            color: AppColors.accentBlue,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onPress: () {},
                          ).paddingOnly(right: 20),
                          PrimaryButton(
                            text: 'Save',
                            textColor: AppColors.text,
                            color: Colors.transparent,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onPress: () {},
                          )
                        ],
                      ).paddingOnly(bottom: 32),
                      mobile: Column(
                        children: [
                          PrimaryButton(
                            text: 'Fill out a medical form',
                            textColor: AppColors.white,
                            color: AppColors.accentBlue,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
                            onPress: () {},
                          ).paddingOnly(bottom: 16),
                          PrimaryButton(
                            text: 'Save',
                            textColor: AppColors.text,
                            color: Colors.transparent,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: AppTextStyles.regularPx16,
                            onPress: () {},
                          ).paddingOnly(bottom: 24),
                        ],
                      )
                    ),
                    Responsive(
                      desktop: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ExportAsTextButton(onPressed: () {}).paddingOnly(right: 20),
                          ExportAsTextButton(onPressed: () {})
                        ],
                      ), 
                      mobile: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExportAsTextButton(onPressed: () {},).paddingOnly(bottom: 16),
                          ExportAsTextButton(onPressed: () {},)
                        ],
                      )
                    ),
                  ]
                ).paddingAll(Responsive.isDesktop(context) ? 40 : 16),
              ),
            ),
          ),
          if (Responsive.isDesktop(context)) ...[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        width: 1,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.accentBlue,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlue,
                              blurRadius: 2,
                              offset: Offset(-3, 3),
                              spreadRadius: 0
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 56), 
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Transcribed',
                                  style: AppTextStyles.mediumPx20,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Expanded(
                              child: TranscribedList(
                                list: List.generate(5, (index) => index),
                              )
                            ),
                            const SizedBox(height: 56)
                          ]
                        ),
                      ),
                      const SizedBox(width: 40,)
                    ],
                  ),
                
            )
          ]
        ],
      ),
    ));
  }
}
