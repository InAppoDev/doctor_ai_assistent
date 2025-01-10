import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_icons.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/duration_extensions.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioProgressBar extends StatefulWidget {
  const AudioProgressBar({super.key});

  @override
  State createState() => _AudioProgressBarState();
}

class _AudioProgressBarState extends State<AudioProgressBar> {
  late AudioPlayer _player;
  late PlayerProvider playerProvider;

  @override
  void initState() {
    super.initState();
    playerProvider = context.read<PlayerProvider>();
    _player = playerProvider.player;

    // Listen to position updates
    _player.positionStream.listen((p) {
      playerProvider.setPosition(p);
    });

    // Listen to duration updates
    _player.durationStream.listen((d) {
      playerProvider.setDuration(d ?? Duration.zero);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  
    playerProvider = context.watch<PlayerProvider>();
    return SizedBox(
      width: MediaQuery.of(context).size.width, 
      child: Row(
      children: [
          // Play/Pause Button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              playerProvider.isPlaying ? _player.pause() : _player.play();
              playerProvider.setIsPlaying(!playerProvider.isPlaying);
            },
            child: SvgPicture.asset(
              playerProvider.isPlaying ? AppIcons.pauseIcon : AppIcons.playIcon,
              height: 32,
              width: 32,
              colorFilter: const ColorFilter.mode(AppColors.text, BlendMode.srcIn),
            ),
          ),
          ).paddingOnly(right: 16),

          // Current Position Text
        Text(
          playerProvider.position.toMinuteAndSecond(),
          style: AppTextStyles.regularPx14,
          ).paddingOnly(right: 8),

          // Expanded Slider
          Expanded(
            child: Slider(
              min: 0,
              max: playerProvider.duration.inSeconds.toDouble(),
              value:
                  playerProvider.position.inSeconds.toDouble().clamp(0, playerProvider.duration.inSeconds.toDouble()),
              thumbColor: AppColors.accentBlue,
              activeColor: AppColors.accentBlue,
              onChanged: (value) {
                _player.seek(Duration(seconds: value.toInt()));
              },
            ),
          ),

          // Total Duration Text
        Text(
          playerProvider.duration.toMinuteAndSecond(),
          style: AppTextStyles.regularPx14,
          ).paddingOnly(left: 8),
        ],
      ),
    );
  }

}
