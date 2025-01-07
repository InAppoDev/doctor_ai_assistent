import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_icons.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/app_route_config.dart';
import 'package:ecnx_ambient_listening/core/services/get_it/get_it_service.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/audio_progress_bar.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/transcribed_list/transcribed_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TranscribedListPage extends StatelessWidget implements AutoRouteWrapper {
  final String path;
  const TranscribedListPage({super.key, required this.path});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            PlayerProvider()..initData(url: path),
        child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      getIt<AppRouter>().back();
                    },
                    child: SvgPicture.asset(
                      AppIcons.closeIcon,
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(AppColors.accentBlue, BlendMode.srcIn),
                    ),
                  ),
                )
              ]).paddingAll(8),
              const Text(
                'Transcribed',
                style: AppTextStyles.mediumPx20,
              ).paddingOnly(bottom: 24),

              /// transcribed tiles list
              /// The list should be replaced with the actual data model list from the provider
              Expanded(
                child: TranscribedList(
                  list: List.generate(5, (index) => index),
                ).paddingSymmetric(horizontal: 13),
              ),

              /// progress bar
              const AudioProgressBar().paddingOnly(bottom: 24, right: 14, left: 14),
            ],
          ).paddingSymmetric(horizontal: 14, vertical: 8),
        ));
  }
}
