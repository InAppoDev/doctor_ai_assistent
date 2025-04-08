import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_text_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/desktop_transcribed_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_form_details_body.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/patient_information_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/search_bar_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/provider/medical_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalFormPage extends StatelessWidget {
  final String path;

  const MedicalFormPage({super.key, this.path = ''});

  @override
  Widget build(BuildContext context) {
    final decodedPath = Uri.decodeComponent(path);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PlayerProvider()..initData(url: decodedPath)),
        ChangeNotifierProvider(create: (_) => MedicalFormProvider()),
      ],
      builder: (context, _) {
        final medicalProvider = context.read<MedicalFormProvider>();
        final playerProvider = context.read<PlayerProvider>();
        final isDesktop = Responsive.isDesktop(context);
        final isMobile = Responsive.isMobile(context);

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
                      child: Padding(
                        padding: EdgeInsets.all(isDesktop ? 40 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onTap: () => context.pop(),
                                    child: const Icon(Icons.arrow_back,
                                        color: AppColors.accentBlue),
                                  ),
                                  const Text('Form for diagnostics',
                                      style: AppTextStyles.mediumPx24),
                                  const SizedBox(width: 24),
                                ],
                              ),
                            SizedBox(height: isDesktop ? 40 : 24),

                            /// Mobile button to view transcribed list
                            if (isMobile)
                              PrimaryButton(
                                onPress: () {
                                  TranscribedListRoute(Uri.encodeComponent(
                                          playerProvider.audioFilePath))
                                      .push(context);
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
                                    controller:
                                        medicalProvider.searchController,
                                    onSearch: medicalProvider.search,
                                    onMicTap: () {},
                                    onClear: medicalProvider.clearSearch,
                                  ).paddingOnly(bottom: isDesktop ? 40 : 24),
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
                                    patientInformation: medicalProvider
                                        .medicalFormModel.patientInformation,
                                  ).paddingOnly(bottom: isDesktop ? 40 : 24),
                                ),
                                if (isDesktop) const Spacer(flex: 4),
                              ],
                            ),

                            /// Medical history list
                            MedicalFormDetailsBody(
                                list: medicalProvider
                                    .medicalFormModel.medicalHistory),

                            /// Submit button
                            SizedBox(height: 32),
                            isDesktop
                                ? Row(
                                    children: [
                                      PrimaryButton(
                                        text: 'Submit',
                                        textColor: AppColors.white,
                                        color: AppColors.accentBlue,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        onPress: () =>
                                            HomeRoute().push(context),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      PrimaryButton(
                                        text: 'Submit',
                                        color: AppColors.accentBlue,
                                        borderColor: AppColors.accentBlue,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        textStyle: AppTextStyles.regularPx16
                                            .copyWith(color: AppColors.white),
                                        onPress: () =>
                                            HomeRoute().push(context),
                                      ).paddingOnly(bottom: 24),
                                    ],
                                  ),

                            /// Export button
                            isDesktop
                                ? Row(
                                    children: [
                                      CustomTextButton(
                                        text: 'Export as',
                                        onPressed: () =>
                                            medicalProvider.exportAsPDF(),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      CustomTextButton(
                                        text: 'Export as',
                                        onPressed: () =>
                                            medicalProvider.exportAsPDF(),
                                      ).paddingOnly(bottom: 16),
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
                  const Expanded(
                      flex: 1, child: DesktopTranscribedListWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}
