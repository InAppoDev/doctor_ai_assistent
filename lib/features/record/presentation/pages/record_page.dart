import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_icons.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/constants/consts.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/edit_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_form_dialog_widget.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/widgets/record_button.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/widgets/recorded_text.dart';
import 'package:ecnx_ambient_listening/features/record/presentation/widgets/wave_animation.dart';
import 'package:ecnx_ambient_listening/features/record/provider/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/responsive/responsive_widget.dart';

class RecordPageArgs {
  final AppointmentModel appointment;

  const RecordPageArgs({required this.appointment});
}

class RecordPage extends StatefulWidget {
  /// Note: need to add the [id] of the appointment to send the recording to the correct appointment
  final AppointmentModel appointment;

  const RecordPage({super.key, required this.appointment});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final ValueNotifier<int?> selectedFormIndex = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedFormIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => RecordProvider(),
      builder: (context, _) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (result, _) {
            // recordProvider.dispose();
          },
          child: Scaffold(
            backgroundColor: AppColors.bg,
            body: Consumer<RecordProvider>(
              builder: (context, recordProvider, _) {
                return SafeArea(
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
                            ).paddingOnly(
                                left: Responsive.isDesktop(context) ? 40 : 16),
                          ],
                        ),

                        /// record time section
                        Text(
                          '${recordProvider.minutes.toString().padLeft(2, '0')}:${recordProvider.seconds.toString().padLeft(2, '0')}',
                          style: Responsive.isDesktop(context)
                              ? AppTextStyles.mediumPx40
                              : AppTextStyles.mediumPx32,
                          textAlign: TextAlign.center,
                        ).paddingOnly(
                            bottom: Responsive.isDesktop(context) ? 8 : 6),
                        Text(
                          'Recording',
                          style: Responsive.isDesktop(context)
                              ? AppTextStyles.regularPx20
                                  .copyWith(color: AppColors.accentGreen)
                              : AppTextStyles.regularPx14
                                  .copyWith(color: AppColors.accentGreen),
                        ).paddingOnly(bottom: 70),

                        /// sound wave animation section
                        recordProvider.status == 1
                            ? SizedBox(
                                width: double.infinity,
                                height:
                                    Responsive.isDesktop(context) ? 130 : 36,
                                child: const AnimatedWave(),
                              ).paddingOnly(
                                bottom:
                                    Responsive.isDesktop(context) ? 200 : 50)
                            : const Divider(
                                color: AppColors.accentBlue,
                                thickness: 3,
                              ).paddingOnly(
                                bottom:
                                    Responsive.isDesktop(context) ? 200 : 50),

                        /// start/pause button
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
                                      // Currently recording → Pause
                                      recordProvider.stopRecording(); // Pause
                                    } else if (recordProvider.status == 2) {
                                      // Paused → Resume
                                      recordProvider.startRecording(
                                          resume: true);
                                    } else {
                                      // Initial state → Start fresh recording
                                      recordProvider.startRecording(
                                          resume: false);
                                    }
                                  })
                              .paddingOnly(
                                  bottom:
                                      Responsive.isDesktop(context) ? 61 : 35),
                        ),

                        /// recorded text section
                        (recordProvider.showTextField &&
                                recordProvider.seconds != 0)
                            ? Row(
                                children: [
                                  if (Responsive.isDesktop(context))
                                    Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 2,
                                    child: ColorCodedTextField(
                                      recordedText: recordProvider.recordedText,
                                      height: Responsive.isDesktop(context)
                                          ? 330
                                          : 270,
                                    ),
                                  ),
                                  if (Responsive.isDesktop(context))
                                    Expanded(flex: 1, child: Container()),
                                ],
                              ).paddingOnly(
                                bottom: 8,
                                left: Responsive.isDesktop(context) ? 0 : 16,
                                right: Responsive.isDesktop(context) ? 0 : 16,
                              )
                            : Container(
                                height:
                                    Responsive.isDesktop(context) ? 330 : 270,
                              ).paddingOnly(
                                bottom: recordProvider.status == 2 ? 24 : 8),

                        /// hide/show recroded text button
                        if (recordProvider.status == 1)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                recordProvider.toggleTextField();
                              },
                              child: Text(
                                recordProvider.showTextField
                                    ? 'Hide text'
                                    : 'Show text',
                                style: AppTextStyles.mediumPx16.copyWith(
                                    color: AppColors.accentBlue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.accentBlue),
                              ),
                            ),
                          )
                        else if (recordProvider.status == 2 ||
                            recordProvider.status == 3)

                          /// when paused show buttons to navigate to other pages
                          recordProvider.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Responsive(
                                  desktop: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PrimaryButton(
                                        text: 'Fill out a medical form',
                                        textColor: AppColors.white,
                                        color: AppColors.accentBlue,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        onPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return MedicalFormDialogWidget(
                                                    onCloseClick: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onSaveClick: () async {
                                                      await recordProvider
                                                          .saveMedicalForm(
                                                        widget.appointment,
                                                      );
                                                      await recordProvider
                                                          .stopRecording()
                                                          .then((_) {
                                                        recordProvider.close();
                                                        if (context.mounted &&
                                                            recordProvider
                                                                    .log !=
                                                                null) {
                                                          MedicalFormRoute(
                                                            MedicalFormPageArgs(
                                                                log:
                                                                    recordProvider
                                                                        .log!),
                                                          ).push(context);
                                                        }
                                                      });
                                                    },
                                                    medicalForms: medicalForms,
                                                    selectedFormIndex:
                                                        selectedFormIndex);
                                              });
                                        },
                                      ).paddingOnly(right: 20),
                                      PrimaryButton(
                                        text: 'Edit text',
                                        textColor: AppColors.text,
                                        color: Colors.transparent,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        onPress: () async {
                                          await recordProvider.saveMedicalForm(
                                            widget.appointment,
                                          );
                                          await recordProvider
                                              .stopRecording()
                                              .then((_) {
                                            recordProvider.close();
                                            if (context.mounted) {
                                              if (recordProvider.log != null) {
                                                EditRoute(
                                                    $extra: EditPageArgs(
                                                  appointmentId:
                                                      widget.appointment.id,
                                                  log: recordProvider.log!,
                                                )).push(context);
                                              } else {
                                                showToast(
                                                    'Something went wrong');
                                              }
                                            }
                                          });
                                        },
                                      ).paddingOnly(right: 20),
                                      PrimaryButton(
                                        text: 'Save',
                                        textColor: AppColors.text,
                                        color: Colors.transparent,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        onPress: () async {
                                          await recordProvider.saveMedicalForm(
                                            widget.appointment,
                                          );
                                          if (context.mounted) {
                                            HomeRoute().push(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  mobile: Column(children: [
                                    PrimaryButton(
                                      text: 'Fill out a medical form',
                                      textColor: AppColors.white,
                                      color: AppColors.accentBlue,
                                      borderColor: AppColors.accentBlue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      textStyle: AppTextStyles.regularPx16
                                          .copyWith(color: AppColors.white),
                                      onPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return MedicalFormDialogWidget(
                                              onCloseClick: () {
                                                Navigator.of(context).pop();
                                              },
                                              onSaveClick: () async {
                                                await recordProvider
                                                    .saveMedicalForm(
                                                  widget.appointment,
                                                );
                                                await recordProvider
                                                    .stopRecording()
                                                    .then((_) {
                                                  recordProvider.close();
                                                  if (context.mounted &&
                                                      recordProvider.log !=
                                                          null) {
                                                    MedicalFormRoute(
                                                      MedicalFormPageArgs(
                                                          log: recordProvider
                                                              .log!),
                                                    ).push(context);
                                                  }
                                                });
                                              },
                                              medicalForms: medicalForms,
                                              selectedFormIndex:
                                                  selectedFormIndex,
                                            );
                                          },
                                        );
                                      },
                                    ).paddingOnly(bottom: 16),
                                    PrimaryButton(
                                      text: 'Edit text',
                                      textColor: AppColors.text,
                                      color: Colors.transparent,
                                      borderColor: AppColors.accentBlue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      textStyle: AppTextStyles.regularPx16,
                                      onPress: () async {
                                        await recordProvider.saveMedicalForm(
                                          widget.appointment,
                                        );
                                        await recordProvider
                                            .stopRecording()
                                            .then((_) {
                                          recordProvider.close();
                                          if (context.mounted) {
                                            if (recordProvider.log != null) {
                                              EditRoute(
                                                  $extra: EditPageArgs(
                                                appointmentId:
                                                    widget.appointment.id,
                                                log: recordProvider.log!,
                                              )).push(context);
                                            } else {
                                              showToast('Something went wrong');
                                            }
                                          }
                                        });
                                      },
                                    ).paddingOnly(bottom: 16),
                                    PrimaryButton(
                                      text: 'Save',
                                      textColor: AppColors.text,
                                      color: Colors.transparent,
                                      borderColor: AppColors.accentBlue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      textStyle: AppTextStyles.regularPx16,
                                      onPress: () async {
                                        await recordProvider.saveMedicalForm(
                                          widget.appointment,
                                        );
                                        if (context.mounted) {
                                          HomeRoute().push(context);
                                        }
                                      },
                                    )
                                  ]).paddingSymmetric(horizontal: 16)),
                      ],
                    ).paddingSymmetric(
                        vertical: Responsive.isDesktop(context) ? 56 : 24),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
