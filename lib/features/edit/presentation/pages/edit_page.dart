import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_icons.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/pages/transcribed_list_page.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/desktop_transcribed_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_texts_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_state.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/pages/medical_form_page.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_form_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditPageArgs {
  const EditPageArgs({
    required this.appointmentId,
    required this.log,
  });

  final int appointmentId;
  final LogModel log;
}

class EditPage extends StatelessWidget {
  final EditPageArgs args;

  const EditPage({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlayerProvider()..initData(url: args.log.audio),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => EditState(log: args.log),
        ),
      ],
      builder: (context, _) {
        return Consumer2<EditState, PlayerProvider>(
            builder: (context, editState, playerProvider, child) {
          return Scaffold(
              backgroundColor: AppColors.bg,
              body: SafeArea(
                child: editState.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment:
                                        Responsive.isDesktop(context)
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          LogoWidget(onTap: () {}).paddingOnly(
                                              top: Responsive.isDesktop(context)
                                                  ? 16
                                                  : 8)
                                        ],
                                      ).paddingOnly(
                                          bottom: Responsive.isDesktop(context)
                                              ? 40
                                              : 26),
                                      Responsive(
                                        desktop: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Edit the text',
                                              style: AppTextStyles.mediumPx32,
                                            ),
                                          ],
                                        ),
                                        mobile: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  HomeRoute().go(context);
                                                },
                                                child: const Icon(
                                                    Icons.arrow_back,
                                                    color: AppColors.accentBlue,
                                                    size: 24),
                                              ),
                                            ),
                                            const Text(
                                              'Edit the text',
                                              style: AppTextStyles.mediumPx24,
                                            ),
                                            Container()
                                          ],
                                        ),
                                      ).paddingOnly(
                                          bottom: Responsive.isDesktop(context)
                                              ? 40
                                              : 24),

                                      /// transcribed list button for navigation to transcribed list
                                      if (Responsive.isMobile(context) &&
                                          editState.fetchedLog != null)
                                        PrimaryButton(
                                          onPress: () {
                                            TranscribedListRoute(
                                              TranscribedListArgs(
                                                  log: editState.fetchedLog!),
                                            ).push(context);
                                          },
                                          color: AppColors.accentGreen,
                                          textColor: AppColors.white,
                                          text: 'Transcribed',
                                          borderColor: AppColors.accentGreen,
                                        ).paddingOnly(bottom: 24),

                                      EditTextsListWidget(
                                        chunks: editState.unitedSpeakerChunks,
                                      ).paddingOnly(
                                          bottom: Responsive.isDesktop(context)
                                              ? 40
                                              : 24),

                                      /// responsive buttons section
                                      Responsive(
                                          desktop: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              PrimaryButton(
                                                text: 'Fill out a medical form',
                                                textColor: AppColors.white,
                                                color: AppColors.accentBlue,
                                                borderColor:
                                                    AppColors.accentBlue,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                onPress: () async {
                                                  final ValueNotifier<int?>
                                                      selectedFormIndex =
                                                      ValueNotifier(0);
                                                  await context
                                                      .read<EditState>()
                                                      .saveEditedChunks();
                                                  if (context.mounted) {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return MedicalFormDialogWidget(
                                                              onCloseClick: () {
                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop();
                                                              },
                                                              onSaveClick: () {
                                                                if (editState
                                                                        .fetchedLog !=
                                                                    null) {
                                                                  MedicalFormRoute(
                                                                    MedicalFormPageArgs(
                                                                        log: editState
                                                                            .fetchedLog!),
                                                                  ).push(
                                                                      context);
                                                                }
                                                              },
                                                              medicalForms: const [
                                                                'Progress Notes',
                                                                'H&P form'
                                                              ],
                                                              selectedFormIndex:
                                                                  selectedFormIndex);
                                                        }).then((_) {
                                                      selectedFormIndex
                                                          .dispose();
                                                    });
                                                  }
                                                },
                                              ).paddingOnly(right: 20),
                                              PrimaryButton(
                                                text: 'Save',
                                                textColor: AppColors.text,
                                                color: Colors.transparent,
                                                borderColor:
                                                    AppColors.accentBlue,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                onPress: () async {
                                                  await context
                                                      .read<EditState>()
                                                      .saveEditedChunks();
                                                  if (context.mounted) {
                                                    const HomeRoute()
                                                        .go(context);
                                                  }
                                                },
                                              )
                                            ],
                                          ).paddingOnly(bottom: 32),
                                          mobile: Column(
                                            children: [
                                              PrimaryButton(
                                                text: 'Fill out a medical form',
                                                textColor: AppColors.white,
                                                color: AppColors.accentBlue,
                                                borderColor:
                                                    AppColors.accentBlue,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                textStyle: AppTextStyles
                                                    .regularPx16
                                                    .copyWith(
                                                        color: AppColors.white),
                                                onPress: () async {
                                                  final ValueNotifier<int?>
                                                      selectedFormIndex =
                                                      ValueNotifier(0);
                                                  await context
                                                      .read<EditState>()
                                                      .saveEditedChunks();
                                                  if (context.mounted) {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return MedicalFormDialogWidget(
                                                              onCloseClick: () {
                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop();
                                                              },
                                                              onSaveClick: () {
                                                                if (editState
                                                                        .fetchedLog !=
                                                                    null) {
                                                                  MedicalFormRoute(
                                                                    MedicalFormPageArgs(
                                                                        log: editState
                                                                            .fetchedLog!),
                                                                  ).push(
                                                                      context);
                                                                }
                                                              },
                                                              medicalForms: const [
                                                                'Progress Notes',
                                                                'H&P form'
                                                              ],
                                                              selectedFormIndex:
                                                                  selectedFormIndex);
                                                        }).then((_) {
                                                      selectedFormIndex
                                                          .dispose();
                                                    });
                                                  }
                                                },
                                              ).paddingOnly(bottom: 16),
                                              PrimaryButton(
                                                text: 'Save',
                                                textColor: AppColors.text,
                                                color: Colors.transparent,
                                                borderColor:
                                                    AppColors.accentBlue,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                textStyle:
                                                    AppTextStyles.regularPx16,
                                                onPress: () async {
                                                  await context
                                                      .read<EditState>()
                                                      .saveEditedChunks();
                                                  if (context.mounted) {
                                                    HomeRoute().go(context);
                                                  }
                                                },
                                              ).paddingOnly(bottom: 24),
                                            ],
                                          )),

                                      /// export as buttons
                                      Responsive(
                                        desktop: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .read<EditState>()
                                                    .exportAsPDF();
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.transparent)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Export as as document',
                                                    style: AppTextStyles
                                                        .mediumPx16
                                                        .copyWith(
                                                      color: AppColors.text,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ).paddingOnly(right: 18),
                                                  SvgPicture.asset(
                                                    AppIcons.pdfIcon,
                                                  ),
                                                ],
                                              ),
                                            ).paddingOnly(right: 20),
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .read<EditState>()
                                                    .exportAsCSV();
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Export as as document',
                                                    style: AppTextStyles
                                                        .mediumPx16
                                                        .copyWith(
                                                      color: AppColors.text,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ).paddingOnly(right: 18),
                                                  SvgPicture.asset(
                                                    AppIcons.csvIcon,
                                                  ),
                                                ],
                                              ),
                                            ).paddingOnly(right: 20),
                                          ],
                                        ),
                                        mobile: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .read<EditState>()
                                                    .exportAsPDF();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Export as document',
                                                    style: AppTextStyles
                                                        .mediumPx16
                                                        .copyWith(
                                                      color: AppColors.text,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ).paddingOnly(right: 18),
                                                  SvgPicture.asset(
                                                    AppIcons.pdfIcon,
                                                  ),
                                                ],
                                              ),
                                            ).paddingOnly(bottom: 16),
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .read<EditState>()
                                                    .exportAsCSV();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Export as document',
                                                    style: AppTextStyles
                                                        .mediumPx16
                                                        .copyWith(
                                                      color: AppColors.text,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ).paddingOnly(right: 18),
                                                  SvgPicture.asset(
                                                      AppIcons.csvIcon),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]).paddingAll(
                                    Responsive.isDesktop(context) ? 40 : 16),
                              ),
                            ),
                          ),

                          /// desktop transcribed list
                          if (Responsive.isDesktop(context) &&
                              editState.fetchedLog != null)
                            Expanded(
                                flex: 1,
                                child: DesktopTranscribedListWidget(
                                  log: editState.fetchedLog!,
                                ))
                        ],
                      ),
              ));
        });
      },
    );
  }
}
