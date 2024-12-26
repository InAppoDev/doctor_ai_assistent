import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/audio_progress_bar.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list/transcribed_list_widget.dart';
import 'package:doctor_ai_assistent/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopTranscribedListWidget extends StatelessWidget {
  const DesktopTranscribedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 1,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.accentBlue,
            boxShadow: [
              BoxShadow(color: AppColors.accentBlue, blurRadius: 2, offset: Offset(-3, 3), spreadRadius: 0),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
            )),
            const SizedBox(height: 32),
            const AudioProgressBar(),
            const SizedBox(height: 32),
          ]),
        ),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }
}
