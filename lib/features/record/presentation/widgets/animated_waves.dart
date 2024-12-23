import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedWaves extends StatefulWidget {
  final double waveHeight;
  final Color waveColor;

  const AnimatedWaves({
    super.key,
    required this.waveHeight,
    required this.waveColor,
  });

  @override
  State createState() => _AnimatedWavesState();
}

class _AnimatedWavesState extends State<AnimatedWaves>
    with SingleTickerProviderStateMixin {
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
          painter: WavePainter(
            waveHeight: widget.waveHeight,
            waveColor: widget.waveColor,
            animationValue: _controller.value,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double waveHeight;
  final Color waveColor;
  final double animationValue;

  WavePainter({
    required this.waveHeight,
    required this.waveColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    for (double i = 0; i <= size.width; i++) {
      final y = waveHeight *
          sin((i / size.width * 2 * pi) + animationValue * 2 * pi) +
          size.height / 2;
      if (i == 0) {
        path.moveTo(i, y);
      } else {
        path.lineTo(i, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
