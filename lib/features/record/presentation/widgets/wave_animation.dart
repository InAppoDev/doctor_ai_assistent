import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// `AnimatedWave` is a reusable Flutter widget that animates a wave pattern.
/// It uses an `AnimationController` to drive the animation and passes the
/// animation value to a `CustomPainter` (`WavePainter`) for rendering.
class AnimatedWave extends StatefulWidget {
  const AnimatedWave({super.key});

  @override
  State createState() => _AnimatedWaveState();
}

/// `_AnimatedWaveState` manages the animation lifecycle and builds the `CustomPaint` widget.
/// It creates an `AnimationController` to animate the waves and uses `AnimatedBuilder`
/// to rebuild the widget tree whenever the animation value changes.
class _AnimatedWaveState extends State<AnimatedWave> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// Initializes the animation controller and starts the wave animation.
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Synchronizes animation with the screen's refresh rate.
      duration: const Duration(seconds: 2), // Sets the duration for a complete wave cycle.
    )..repeat(); // Repeats the animation indefinitely.
  }

  /// Disposes of the animation controller to free up resources when the widget is removed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Builds the widget tree. Uses `AnimatedBuilder` to rebuild the `CustomPaint`
  /// widget whenever the animation value changes.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          /// Passes the current animation value and responsive wave heights to the painter.
          painter: WavePainter(
            _controller.value, // Current animation value (0.0 to 1.0).
            Responsive.isDesktop(context) ? 60 : 30, // Larger wave height for desktops.
            Responsive.isDesktop(context) ? 50 : 20, // Smaller wave height for desktops.
          ),
        );
      },
    );
  }
}

/// `WavePainter` is a custom painter responsible for rendering animated sine waves.
/// It draws two wave patterns: one with smaller amplitude and another with larger amplitude.
class WavePainter extends CustomPainter {
  /// Current animation value (ranges from 0.0 to 1.0) used to animate the waves.
  final double animationValue;

  /// Amplitude of the first wave (white wave).
  final double waveHeight1;

  /// Amplitude of the second wave (blue wave).
  final double waveHeight2;

  /// Constructs a `WavePainter` with the given animation value and wave heights.
  const WavePainter(this.animationValue, this.waveHeight1, this.waveHeight2);

  /// Paints the sine waves on the given canvas.
  ///
  /// - `canvas`: The drawing surface.
  /// - `size`: The size of the canvas.
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the smaller white wave.
    final Paint smallPaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Paint for the larger blue wave.
    final Paint bluePaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Paths for the two waves.
    final Path whiteWavePath = Path();
    final Path blueWavePath = Path();

    // Length of a single wave cycle (adjusted for canvas width).
    double waveLength = size.width / 1.5;

    // Iterate over the width of the canvas to compute wave points.
    for (double x = 0; x <= size.width; x++) {
      // Y-coordinate for the white wave (smaller amplitude, positive animation phase).
      double y1 = waveHeight1 * sin((2 * pi * (x / waveLength) + animationValue * 2 * pi)) + size.height / 2;

      // Y-coordinate for the blue wave (larger amplitude, negative animation phase).
      double y2 = waveHeight2 * sin((2 * pi * (x / waveLength) - animationValue * 2 * pi)) + size.height / 2;

      // Move to the starting point for the paths.
      if (x == 0) {
        whiteWavePath.moveTo(x, y1);
        blueWavePath.moveTo(x, y2);
      } else {
        // Add line segments to the paths.
        whiteWavePath.lineTo(x, y1);
        blueWavePath.lineTo(x, y2);
      }
    }

    // Draw the wave paths on the canvas.
    canvas.drawPath(whiteWavePath, smallPaint);
    canvas.drawPath(blueWavePath, bluePaint);
  }

  /// Determines whether the painter should repaint when the animation value changes.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}