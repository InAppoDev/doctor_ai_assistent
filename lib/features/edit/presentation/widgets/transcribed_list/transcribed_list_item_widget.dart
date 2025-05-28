import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/avatar_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscribedListItemWidget extends StatelessWidget {
  /// The text and date should be changed to the actual data model
  final ChunkModel chunk;
  final int id;

  final Function() onTap;

  const TranscribedListItemWidget({
    super.key,
    required this.chunk,
    required this.onTap,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Consumer<PlayerProvider>(
          builder: (context, state, _) {
            final time = (chunk.time / 100).toString().substring(0, 4);
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: state.transcribedId == id
                        ? AppColors.accentBlue
                        : Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarWidget(
                    color: getTranscribeColor(int.parse(chunk.speaker)),
                  ).paddingOnly(right: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatTimeString(time),
                          style: AppTextStyles.mediumPx16,
                        ).paddingOnly(bottom: 8),
                        Text(
                          chunk.transcription,
                          style: AppTextStyles.regularPx16,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color getTranscribeColor(int id) {
    switch (id) {
      case 0:
        return AppColors.accentGreen;
      case 1:
        return AppColors.accentBlue;
      case 2:
        return AppColors.accentPink;
    }
    return AppColors.accentGreen;
  }

  String formatTimeString(String time) {
    if (time.contains('.')) {
      time = time.replaceFirst(RegExp(r'0*$'), '');
      time = time.replaceFirst(RegExp(r'\.$'), '');
    }
    return time;
  }
}
