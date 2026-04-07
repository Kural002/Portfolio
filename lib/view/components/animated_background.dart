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
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Initial particles
    for (int i = 0; i < 20; i++) {
      _particles.add(Particle(
        position: Offset(_random.nextDouble(), _random.nextDouble()),
        size: _random.nextDouble() * 15 + 5,
        speed: _random.nextDouble() * 0.05 + 0.01,
        angle: _random.nextDouble() * 2 * pi,
        opacity: _random.nextDouble() * 0.15 + 0.05,
      ));
    }
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
          painter: ParticlePainter(
            particles: _particles,
            time: _controller.value,
            color: widget.isDark ? AppColors.primary : AppColors.primary.withOpacity(0.3),
          ),
        );
      },
    );
  }
}

class Particle {
  Offset position;
  double size;
  double speed;
  double angle;
  double opacity;

  Particle({
    required this.position,
    required this.size,
    required this.speed,
    required this.angle,
    required this.opacity,
  });

  void update(double time) {
    // Subtle drifting motion
    position = Offset(
      (position.dx + cos(angle) * speed * 0.002) % 1.0,
      (position.dy + sin(angle) * speed * 0.002) % 1.0,
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double time;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.time,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      particle.update(time);

      paint.color = color.withOpacity(particle.opacity);
      
      final realPos = Offset(
        particle.position.dx * size.width,
        particle.position.dy * size.height,
      );

      // Draw soft circles / glow points
      canvas.drawCircle(realPos, particle.size, paint);
      
      // Add a small inner highlight for depth
      paint.color = color.withOpacity(particle.opacity * 0.5);
      canvas.drawCircle(realPos, particle.size * 0.4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
