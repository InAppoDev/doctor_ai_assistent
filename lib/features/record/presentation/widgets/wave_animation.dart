import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedWave extends StatefulWidget {
  const AnimatedWave({super.key});

  @override
  State createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<AnimatedWave> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_controller.value, Responsive.isDesktop(context) ? 60 : 30, Responsive.isDesktop(context) ? 50 : 20),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final double waveHeight1;
  final double waveHeight2;

  WavePainter(this.animationValue, this.waveHeight1, this.waveHeight2);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint smallPaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final Paint bluePaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Path whiteWavePath = Path();
    final Path blueWavePath = Path();

    double waveLength = size.width / 1.5;

    for (double x = 0; x <= size.width; x++) {
      double y1 = waveHeight1 * sin((2 * pi * (x / waveLength) + animationValue * 2 * pi)) + size.height / 2;
      double y2 = waveHeight2 * sin((2 * pi * (x / waveLength) - animationValue * 2 * pi)) + size.height / 2;

      if (x == 0) {
        whiteWavePath.moveTo(x, y1);
        blueWavePath.moveTo(x, y2);
      } else {
        whiteWavePath.lineTo(x, y1);
        blueWavePath.lineTo(x, y2);
      }
    }

    canvas.drawPath(whiteWavePath, smallPaint);
    canvas.drawPath(blueWavePath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
