import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/export_as_text_button.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/desktop_transcribed_list_widget.dart';
import 'package:doctor_ai_assistent/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayerProvider()..initData(url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
      child: Scaffold(
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
                              'Form for diagnostics', 
                              style: AppTextStyles.mediumPx32,
                            ),
                          ],
                        ),
                        mobile: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {}, 
                                child: const Icon(Icons.arrow_back, color: AppColors.accentBlue, size: 24),
                              ),
                            ),
                            const Text(
                              'Form for diagnostics', 
                              style: AppTextStyles.mediumPx24,
                            ),
                            Container()
                          ],
                        ),
                      ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 24),
                      //TODO: need to add the search bar 
                      if (Responsive.isMobile(context))
                        PrimaryButton(
                          onPress: () {},
                          color: AppColors.accentGreen,
                          textColor: AppColors.white,
                          text: 'Transcribed Patient Responses',
                          borderColor: AppColors.accentGreen,
                        ).paddingOnly(bottom: 24),
                      //TODO: need to add the list of the medical history tiles
                      Responsive(
                        desktop: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PrimaryButton(
                              text: 'Submit',
                              textColor: AppColors.white,
                              color: AppColors.accentBlue,
                              borderColor: AppColors.accentBlue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              onPress: () {},
                            ).paddingOnly(right: 20),
                          ],
                        ).paddingOnly(bottom: 32),
                        mobile: Column(
                          children: [
                            PrimaryButton(
                              text: 'Submit',
                              color: AppColors.accentBlue,
                              borderColor: AppColors.accentBlue,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
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
            if (Responsive.isDesktop(context)) 
              const Expanded(flex: 1 ,child: DesktopTranscribedListWidget())
          ],
        ),
      )),
    );
  }
}
