import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Text(
        "Hi, I'm a Flutter Developer specializing in building cross-platform apps.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
