import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_icons.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/widgets/medical_form_dialog_widget.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/record_button.dart';
import 'package:doctor_ai_assistent/features/record/presentation/widgets/recorded_text.dart';
import 'package:doctor_ai_assistent/features/record/provider/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/responsive/responsive_widget.dart';

@RoutePage()
class RecordPage extends StatefulWidget implements AutoRouteWrapper {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecordProvider(),
      child: this,
    );
  }
}

class _RecordPageState extends State<RecordPage> with SingleTickerProviderStateMixin {
  late GifController _gifController;
  final ValueNotifier<int?> selectedFormIndex = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    _gifController.dispose();
    selectedFormIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = context.watch<RecordProvider>();

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, _) {
        recordProvider.dispose();
      },
      child: Scaffold(
          backgroundColor: AppColors.bg,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LogoWidget(
                      onTap: () {},
                    ).paddingOnly(left: Responsive.isDesktop(context) ? 40 : 16),
                  ],
                ),
                Text(
                  '${recordProvider.minutes.toString().padLeft(2, '0')}:${recordProvider.seconds.toString().padLeft(2, '0')}',
                  style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx32,
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: Responsive.isDesktop(context) ? 8 : 6),
                Text(
                  'Recording',
                  style: Responsive.isDesktop(context)
                      ? AppTextStyles.regularPx20.copyWith(color: AppColors.accentGreen)
                      : AppTextStyles.regularPx14.copyWith(color: AppColors.accentGreen),
                ).paddingOnly(bottom: 70),
                recordProvider.status == 1
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Container(
                              color: AppColors.bg.withOpacity(0.8),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: Responsive.isDesktop(context) ? 600 : double.infinity,
                              height: Responsive.isDesktop(context) ? 300 : 200,
                              child: ClipRect(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Gif(
                                    image: const AssetImage("assets/gifs/wave_animation.gif"),
                                    controller: _gifController,
                                    autostart: Autostart.loop,
                                    onFetchCompleted: () {
                                      _gifController.reset();
                                      _gifController.forward();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Divider(
                        color: AppColors.accentBlue,
                        thickness: 3,
                      ).paddingOnly(bottom: Responsive.isDesktop(context) ? 200 : 50),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: RecordButton(
                      height: Responsive.isDesktop(context) ? 88 : 62,
                      width: Responsive.isDesktop(context) ? 88 : 62,
                      padding: Responsive.isDesktop(context) ? 30 : 20,
                      size: Responsive.isDesktop(context) ? 28 : 24,
                      image: recordProvider.status == 1
                          ? AppIcons.pauseIcon
                          : recordProvider.status == 2
                              ? AppIcons.playIcon
                              : null,
                      onPressed: () {
                        if (recordProvider.status == 1) {
                          recordProvider.stopRecording();
                          recordProvider.stopTimer();
                          recordProvider.setHideShowButton(true);
                        } else {
                          recordProvider.startRecording();
                          recordProvider.startTimer();
                          recordProvider.setHideShowButton(false);
                        }
                      }).paddingOnly(bottom: Responsive.isDesktop(context) ? 61 : 35),
                ),
                (recordProvider.showTextField && recordProvider.seconds != 0)
                    ? Row(
                        children: [
                          if (Responsive.isDesktop(context)) Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: ColorCodedTextField(
                              height: Responsive.isDesktop(context) ? 330 : 270,
                            ),
                          ),
                          if (Responsive.isDesktop(context)) Expanded(flex: 1, child: Container()),
                        ],
                      ).paddingOnly(
                        bottom: 8,
                        left: Responsive.isDesktop(context) ? 0 : 16,
                        right: Responsive.isDesktop(context) ? 0 : 16,
                      )
                    : Container(
                        height: Responsive.isDesktop(context) ? 330 : 270,
                      ).paddingOnly(bottom: recordProvider.status == 2 ? 24 : 8),
                if (recordProvider.status == 1)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        recordProvider.toggleTextField();
                      },
                      child: Text(
                        recordProvider.showTextField ? 'Hide text' : 'Show text',
                        style: AppTextStyles.mediumPx16.copyWith(
                            color: AppColors.accentBlue,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.accentBlue),
                      ),
                    ),
                  )
                else if (recordProvider.status == 2)
                  Responsive(
                      desktop: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                            text: 'Fill out a medical form',
                            textColor: AppColors.white,
                            color: AppColors.accentBlue,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MedicalFormDialogWidget(
                                        onCloseClick: () {
                                          Navigator.of(context).pop();
                                        },
                                        onSaveClick: () {
                                          AutoRouter.of(context).pushNamed(MedicalFormRoute.name);
                                        },
                                        medicalForms: const ['Progress Notes', 'H&P form'],
                                        selectedFormIndex: selectedFormIndex);
                                  });
                            },
                          ).paddingOnly(right: 20),
                          PrimaryButton(
                            text: 'Edit text',
                            textColor: AppColors.text,
                            color: Colors.transparent,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onPress: () {
                              AutoRouter.of(context).pushNamed(MedicalFormRoute.name);
                            },
                          ).paddingOnly(right: 20),
                          PrimaryButton(
                            text: 'Save',
                            textColor: AppColors.text,
                            color: Colors.transparent,
                            borderColor: AppColors.accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onPress: () {},
                          ),
                        ],
                      ),
                      mobile: Column(children: [
                        PrimaryButton(
                          text: 'Fill out a medical form',
                          textColor: AppColors.white,
                          color: AppColors.accentBlue,
                          borderColor: AppColors.accentBlue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MedicalFormDialogWidget(
                                      onCloseClick: () {
                                        Navigator.of(context).pop();
                                      },
                                      onSaveClick: () {
                                        AutoRouter.of(context).pushNamed(MedicalFormRoute.name);
                                      },
                                      medicalForms: const ['Progress Notes', 'H&P form'],
                                      selectedFormIndex: selectedFormIndex);
                                });
                          },
                        ).paddingOnly(bottom: 16),
                        PrimaryButton(
                          text: 'Edit text',
                          textColor: AppColors.text,
                          color: Colors.transparent,
                          borderColor: AppColors.accentBlue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: AppTextStyles.regularPx16,
                          onPress: () {
                            AutoRouter.of(context).pushNamed(MedicalFormRoute.name);
                          },
                        ).paddingOnly(bottom: 16),
                        PrimaryButton(
                          text: 'Save',
                          textColor: AppColors.text,
                          color: Colors.transparent,
                          borderColor: AppColors.accentBlue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: AppTextStyles.regularPx16,
                          onPress: () {},
                        )
                      ]).paddingSymmetric(horizontal: 16)),
              ],
            ).paddingSymmetric(vertical: Responsive.isDesktop(context) ? 56 : 24),
          ))),
    );
  }
}
