import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/utils/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final bool isDark;
  const AnimatedBackground({super.key, required this.isDark});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<AuroraBlob> _blobs = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    // Generate 3 organic floating aurora blobs (Amber, Champagne, Rich Gold)
    _blobs.add(AuroraBlob(
      color: const Color(0xFFE2B659), // Amber Gold
      position: const Offset(0.2, 0.3),
      radius: 300.0,
      speed: 0.03,
      angle: 0.0,
    ));
    _blobs.add(AuroraBlob(
      color: const Color(0xFFC5A880), // Champagne Sand
      position: const Offset(0.8, 0.2),
      radius: 350.0,
      speed: 0.02,
      angle: pi / 2,
    ));
    _blobs.add(AuroraBlob(
      color: const Color(0xFFD97706), // Rich Amber Accent
      position: const Offset(0.5, 0.7),
      radius: 320.0,
      speed: 0.025,
      angle: pi,
    ));
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
          size: Size.infinite,
          painter: AuroraPainter(
            blobs: _blobs,
            time: _controller.value,
            isDark: widget.isDark,
          ),
        );
      },
    );
  }
}

class AuroraBlob {
  final Color color;
  Offset position;
  final double radius;
  final double speed;
  double angle;

  AuroraBlob({
    required this.color,
    required this.position,
    required this.radius,
    required this.speed,
    required this.angle,
  });

  void update() {
    // Drifting motion in circles
    angle = (angle + speed * 0.01) % (2 * pi);
    position = Offset(
      position.dx + cos(angle) * 0.001,
      position.dy + sin(angle) * 0.001,
    );
  }
}

class AuroraPainter extends CustomPainter {
  final List<AuroraBlob> blobs;
  final double time;
  final bool isDark;

  AuroraPainter({
    required this.blobs,
    required this.time,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var blob in blobs) {
      blob.update();

      final realPos = Offset(
        blob.position.dx * size.width,
        blob.position.dy * size.height,
      );

      final rect = Rect.fromCircle(center: realPos, radius: blob.radius);
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [
            blob.color.withOpacity(isDark ? 0.12 : 0.09),
            blob.color.withOpacity(0.0),
          ],
        ).createShader(rect);

      canvas.drawCircle(realPos, blob.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
