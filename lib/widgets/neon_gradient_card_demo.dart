import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class NeonGradientCardDemo extends StatelessWidget {
  final String skills;

  const NeonGradientCardDemo({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: NeonCard(
          intensity: 0.0, // No background glow
          glowSpread: 0.0, // No glow spread
          showGlow: true, // Keep border
          child: Center(
            child: GradientText(
              text: skills,
              fontSize: 44,
              gradientColors: const [
                Color.fromARGB(255, 255, 41, 117),
                Color.fromARGB(255, 255, 41, 117),
                Color.fromARGB(255, 9, 221, 222),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NeonCard extends StatefulWidget {
  final Widget child;
  final double intensity;
  final double glowSpread;
  final bool showGlow;

  const NeonCard({
    super.key,
    required this.child,
    this.intensity = 0.3,
    this.glowSpread = 2.0,
    this.showGlow = true,
  });

  @override
  _NeonCardState createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
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
          painter: GlowRectanglePainter(
            progress: _controller.value,
            intensity: widget.intensity,
            glowSpread: widget.glowSpread,
            showGlow: widget.showGlow,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class GlowRectanglePainter extends CustomPainter {
  final double progress;
  final double intensity;
  final double glowSpread;
  final bool showGlow;

  GlowRectanglePainter({
    required this.progress,
    required this.intensity,
    required this.glowSpread,
    required this.showGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

    // Draw background fill
    final blackPaint = Paint()..color = Colors.black;
    canvas.drawRRect(rrect, blackPaint);

    // Only draw neon border (no background glow)
    if (showGlow) {
      const firstColor = Color(0xFFFF00AA);
      const secondColor = Color(0xFF00FFF1);

      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..shader = LinearGradient(
          colors: [
            Color.lerp(firstColor, secondColor, progress)!,
            Color.lerp(secondColor, firstColor, progress)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect);

      canvas.drawRRect(rrect, glowPaint);
    }
  }

  @override
  bool shouldRepaint(GlowRectanglePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.showGlow != showGlow;
}

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Color> gradientColors;

  const GradientText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          stops: const [0.0, 0.3, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          height: 1,
          letterSpacing: -1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
