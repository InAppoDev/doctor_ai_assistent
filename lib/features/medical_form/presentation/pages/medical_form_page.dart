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
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_form_details_body.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/patient_information_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/search_bar_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/provider/medical_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MedicalFormPageArgs {
  final LogModel log;
  final int selectedFormIndex;

  const MedicalFormPageArgs({
    required this.log,
    required this.selectedFormIndex,
  });
}

class MedicalFormPage extends StatefulWidget {
  final LogModel log;
  final int selectedFormIndex;

  const MedicalFormPage({
    super.key,
    required this.log,
    required this.selectedFormIndex,
  });

  @override
  State<MedicalFormPage> createState() => _MedicalFormPageState();
}

class _MedicalFormPageState extends State<MedicalFormPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) => PlayerProvider()..initData(url: widget.log.audio)),
        ChangeNotifierProvider(
            create: (_) => MedicalFormProvider(
                  appointmentId: widget.log.appointment,
                  selectedFormIndex: widget.selectedFormIndex,
                )..init()),
      ],
      builder: (context, _) {
        final medicalProvider = context.read<MedicalFormProvider>();
        final isDesktop = Responsive.isDesktop(context);
        final isMobile = Responsive.isMobile(context);

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SafeArea(
            child: Consumer<MedicalFormProvider>(
              builder: (context, medicalState, _) {
                return medicalState.isLoading
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
                                child: Padding(
                                  padding: EdgeInsets.all(isDesktop ? 40 : 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LogoWidget(onTap: () {})
                                          .paddingOnly(top: isDesktop ? 16 : 8),
                                      SizedBox(height: isDesktop ? 40 : 26),

                                      /// Header
                                      if (isDesktop)
                                        const Text('Form for diagnostics',
                                            style: AppTextStyles.mediumPx32)
                                      else
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                const HomeRoute()
                                                    .pushReplacement(context);
                                              },
                                              child: const Icon(
                                                  Icons.arrow_back,
                                                  color: AppColors.accentBlue),
                                            ),
                                            const Text('Form for diagnostics',
                                                style:
                                                    AppTextStyles.mediumPx24),
                                            const SizedBox(width: 24),
                                          ],
                                        ),
                                      SizedBox(height: isDesktop ? 40 : 24),

                                      /// Mobile button to view transcribed list
                                      if (isMobile)
                                        PrimaryButton(
                                          onPress: () {
                                            TranscribedListRoute(
                                              TranscribedListArgs(
                                                  log: widget.log),
                                            ).push(context);
                                          },
                                          color: AppColors.accentGreen,
                                          textColor: AppColors.white,
                                          borderColor: AppColors.accentGreen,
                                          text: 'Transcribed Patient Responses',
                                        ).paddingOnly(bottom: 24),

                                      /// Search bar
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 7,
                                            child: SearchBarWidget(
                                              isListening:
                                                  medicalProvider.isListening,
                                              controller: medicalProvider
                                                  .searchController,
                                              onSearch: () {},
                                              onMicTap:
                                                  medicalProvider.onMicTap,
                                              onClear:
                                                  medicalProvider.clearSearch,
                                            ).paddingOnly(
                                                bottom: isDesktop ? 40 : 24),
                                          ),
                                          if (isDesktop) const Spacer(flex: 1),
                                        ],
                                      ),

                                      /// Patient information
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 4,
                                            child: PatientInformationWidget(
                                              user: medicalProvider.user,
                                              patientInformation:
                                                  medicalState.appointment,
                                            ).paddingOnly(
                                                bottom: isDesktop ? 40 : 24),
                                          ),
                                          if (isDesktop) const Spacer(flex: 4),
                                        ],
                                      ),

                                      /// Medical history list
                                      MedicalFormDetailsBody(
                                        searchQuery: medicalProvider
                                            .searchController.text
                                            .trim(),
                                        list: medicalProvider.forms,
                                        onTitleTextChanged:
                                            medicalProvider.updateFormTitleText,
                                        onConclusionChanged: medicalProvider
                                            .updateFormDescriptionText,
                                      ),

                                      // Center(
                                      //   child: IconButton(
                                      //     onPressed: medicalProvider.createForm,
                                      //     icon: Icon(
                                      //       color: AppColors.accentBlue,
                                      //       Icons.add,
                                      //       size: 40,
                                      //     ),
                                      //   ),
                                      // ),

                                      /// Submit button
                                      SizedBox(height: 32),
                                      isDesktop
                                          ? Row(
                                              children: [
                                                PrimaryButton(
                                                  text: 'Submit',
                                                  textColor: AppColors.white,
                                                  color: AppColors.accentBlue,
                                                  borderColor:
                                                      AppColors.accentBlue,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                  onPress: () =>
                                                      HomeRoute().push(context),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                medicalProvider.isSaving
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : PrimaryButton(
                                                        text: 'Submit',
                                                        color: AppColors
                                                            .accentBlue,
                                                        borderColor: AppColors
                                                            .accentBlue,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 12),
                                                        textStyle: AppTextStyles
                                                            .regularPx16
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white),
                                                        onPress: () async {
                                                          await medicalProvider
                                                              .createForm();
                                                          if (context.mounted) {
                                                            HomeRoute()
                                                                .pushReplacement(
                                                                    context);
                                                          }
                                                        },
                                                      ).paddingOnly(bottom: 24),
                                              ],
                                            ),

                                      /// Export button
                                      isDesktop
                                          ? Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    await context
                                                        .read<
                                                            MedicalFormProvider>()
                                                        .exportAsPDF();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors
                                                                  .transparent)),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Export as as document',
                                                        style: AppTextStyles
                                                            .mediumPx16
                                                            .copyWith(
                                                          color: AppColors.text,
                                                          decoration:
                                                              TextDecoration
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
                                                        .read<
                                                            MedicalFormProvider>()
                                                        .exportAsCSV();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors
                                                                  .transparent)),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Export as as document',
                                                        style: AppTextStyles
                                                            .mediumPx16
                                                            .copyWith(
                                                          color: AppColors.text,
                                                          decoration:
                                                              TextDecoration
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
                                            )
                                          : Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    await context
                                                        .read<
                                                            MedicalFormProvider>()
                                                        .exportAsPDF();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Export as document',
                                                        style: AppTextStyles
                                                            .mediumPx16
                                                            .copyWith(
                                                          color: AppColors.text,
                                                          decoration:
                                                              TextDecoration
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
                                                        .read<
                                                            MedicalFormProvider>()
                                                        .exportAsCSV();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Export as document',
                                                        style: AppTextStyles
                                                            .mediumPx16
                                                            .copyWith(
                                                          color: AppColors.text,
                                                          decoration:
                                                              TextDecoration
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// Desktop right side panel
                          if (isDesktop)
                            Expanded(
                              flex: 1,
                              child: DesktopTranscribedListWidget(
                                log: widget.log,
                              ),
                            ),
                        ],
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
