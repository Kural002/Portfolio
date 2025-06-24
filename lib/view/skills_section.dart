import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Skills",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        // Wrap(
        //   spacing: 8,
        //   children: skills
        //       .map(
        //         (skill) => Chip(
        //           label: Text(skill),
        //         ),
        //       )
        //       .toList(),
        // ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 16,
          children: [
        
          ],
        ),
      ],
    );
  }
}
