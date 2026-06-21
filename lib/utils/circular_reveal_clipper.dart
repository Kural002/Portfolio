import 'dart:math';
import 'package:flutter/material.dart';

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  CircularRevealClipper({
    required this.fraction,
    required this.center,
  });

  @override
  Path getClip(Size size) {
    final double maxRadius = _maxRadius(size, center);
    final double radius = maxRadius * fraction;

    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  double _maxRadius(Size size, Offset center) {
    final double dx1 = center.dx;
    final double dx2 = size.width - center.dx;
    final double dy1 = center.dy;
    final double dy2 = size.height - center.dy;

    final double d1 = sqrt(dx1 * dx1 + dy1 * dy1);
    final double d2 = sqrt(dx2 * dx2 + dy1 * dy1);
    final double d3 = sqrt(dx1 * dx1 + dy2 * dy2);
    final double d4 = sqrt(dx2 * dx2 + dy2 * dy2);

    return max(max(d1, d2), max(d3, d4));
  }

  @override
  bool shouldReclip(covariant CircularRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.center != center;
  }
}
