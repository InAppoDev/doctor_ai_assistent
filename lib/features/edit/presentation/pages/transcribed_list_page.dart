import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/audio_progress_bar.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/transcribed_list/transcribed_list_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscribedListArgs {
  TranscribedListArgs({required this.log});

  final LogModel log;
}

class TranscribedListPage extends StatelessWidget {
  /// You need to add the [id] parameter to the constructor to fetch the transcribed list
  final LogModel log;

  const TranscribedListPage({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PlayerProvider()..initData(url: log.audio),
        builder: (context, _) {
          return Scaffold(
              backgroundColor: AppColors.bg,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: CloseButton(
                          color: AppColors.accentBlue,
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
                        chunks: log.chunks,
                      ).paddingSymmetric(horizontal: 13),
                    ),

                    /// progress bar
                    const AudioProgressBar()
                        .paddingOnly(bottom: 24, right: 14, left: 14),
                  ],
                ).paddingSymmetric(horizontal: 14, vertical: 8),
              ));
        });
  }
}
