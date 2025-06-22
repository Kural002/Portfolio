import 'package:flutter/material.dart';
import 'package:portfolio/model/project_model.dart';
import 'package:portfolio/widgets/neon_gradient_card_demo.dart';

class ProjectsSection extends StatelessWidget {
  final List<ProjectModel> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 16,
          children: [
            NeonGradientCardDemo(skills: 'Epension Tracker'),
            NeonGradientCardDemo(skills: 'Pokedex'),
            NeonGradientCardDemo(skills: 'Portfolio Flutter Website'),
            NeonGradientCardDemo(skills: 'Weather App'),
          ],
        ),
      ],
    );
  }
}
