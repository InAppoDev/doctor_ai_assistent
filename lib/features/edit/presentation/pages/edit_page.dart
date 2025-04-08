import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_text_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/desktop_transcribed_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_texts_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_state.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_form_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  /// Note: need to add the [id] parameter to the constructor for fetching the text
  final String path;

  const EditPage({super.key, this.path = ''});

  @override
  Widget build(BuildContext context) {
    final decodedPath = Uri.decodeComponent(path);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlayerProvider()..initData(url: decodedPath),
        ),
        ChangeNotifierProvider(
          create: (context) => EditState(),
        ),
      ],
      builder: (context, _) {
        return Scaffold(
            backgroundColor: AppColors.bg,
            body: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: Responsive.isDesktop(context)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LogoWidget(onTap: () {}).paddingOnly(
                                      top: Responsive.isDesktop(context)
                                          ? 16
                                          : 8)
                                ],
                              ).paddingOnly(
                                  bottom:
                                      Responsive.isDesktop(context) ? 40 : 26),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: const Icon(Icons.arrow_back,
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
                                  bottom:
                                      Responsive.isDesktop(context) ? 40 : 24),

                              /// transcribed list button for navigation to transcribed list
                              if (Responsive.isMobile(context))
                                PrimaryButton(
                                  onPress: () {
                                    final audioFilePath = context
                                        .read<PlayerProvider>()
                                        .audioFilePath;
                                    TranscribedListRoute(
                                      Uri.encodeComponent(audioFilePath.isEmpty
                                          ? path
                                          : audioFilePath),
                                    ).push(context);
                                  },
                                  color: AppColors.accentGreen,
                                  textColor: AppColors.white,
                                  text: 'Transcribed',
                                  borderColor: AppColors.accentGreen,
                                ).paddingOnly(bottom: 24),

                              /// editable textfield list
                              EditTextsListWidget(
                                list:
                                    context.read<EditState>().transcribedTexts,
                              ).paddingOnly(
                                  bottom:
                                      Responsive.isDesktop(context) ? 40 : 24),

                              /// responsive buttons section
                              Responsive(
                                  desktop: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      PrimaryButton(
                                        text: 'Fill out a medical form',
                                        textColor: AppColors.white,
                                        color: AppColors.accentBlue,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        onPress: () {
                                          final ValueNotifier<int?>
                                              selectedFormIndex =
                                              ValueNotifier(null);
                                          showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return MedicalFormDialogWidget(
                                                    onCloseClick: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    onSaveClick: () {
                                                      var audioFilePath = context
                                                          .read<
                                                              PlayerProvider>()
                                                          .audioFilePath;
                                                      if (audioFilePath
                                                          .isEmpty) {
                                                        audioFilePath =
                                                            Uri.decodeComponent(
                                                                path);
                                                      }
                                                      MedicalFormRoute(Uri
                                                              .encodeComponent(
                                                                  audioFilePath))
                                                          .push(context);
                                                    },
                                                    medicalForms: const [
                                                      'Progress Notes',
                                                      'H&P form'
                                                    ],
                                                    selectedFormIndex:
                                                        selectedFormIndex);
                                              }).then((_) {
                                            selectedFormIndex.dispose();
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
                                        onPress: () {
                                          const HomeRoute().go(context);
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
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        textStyle: AppTextStyles.regularPx16
                                            .copyWith(color: AppColors.white),
                                        onPress: () {
                                          final ValueNotifier<int?>
                                              selectedFormIndex =
                                              ValueNotifier(null);
                                          showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return MedicalFormDialogWidget(
                                                    onCloseClick: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    onSaveClick: () {
                                                      var audioFilePath = context
                                                          .read<
                                                              PlayerProvider>()
                                                          .audioFilePath;
                                                      if (audioFilePath
                                                          .isEmpty) {
                                                        audioFilePath =
                                                            Uri.decodeComponent(
                                                                path);
                                                      }
                                                      MedicalFormRoute(Uri
                                                              .encodeComponent(
                                                                  audioFilePath))
                                                          .push(context);
                                                    },
                                                    medicalForms: const [
                                                      'Progress Notes',
                                                      'H&P form'
                                                    ],
                                                    selectedFormIndex:
                                                        selectedFormIndex);
                                              }).then((_) {
                                            selectedFormIndex.dispose();
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
                                        onPress: () {
                                          const HomeRoute().go(context);
                                        },
                                      ).paddingOnly(bottom: 24),
                                    ],
                                  )),

                              /// export as buttons
                              Responsive(
                                  desktop: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextButton(
                                          text: 'Export as',
                                          onPressed: () async {
                                            await context
                                                .read<EditState>()
                                                .exportAsPDF();
                                          }).paddingOnly(right: 20),
                                    ],
                                  ),
                                  mobile: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextButton(
                                        text: 'Export as',
                                        onPressed: () async {
                                          await context
                                              .read<EditState>()
                                              .exportAsPDF();
                                        },
                                      ).paddingOnly(bottom: 16),
                                    ],
                                  )),
                            ]).paddingAll(
                            Responsive.isDesktop(context) ? 40 : 16),
                      ),
                    ),
                  ),

                  /// desktop transcribed list
                  if (Responsive.isDesktop(context))
                    const Expanded(
                        flex: 1, child: DesktopTranscribedListWidget())
                ],
              ),
            ));
      },
    );
  }
}
