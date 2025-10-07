import 'package:flutter/material.dart';
import 'package:portfolio/view/about_section.dart';
import 'package:portfolio/view/certifications_section.dart';
import 'package:portfolio/view/education_section.dart';
import 'package:portfolio/view/experience_section.dart';
import 'package:portfolio/view/footer_section.dart';
import 'package:portfolio/view/header_section.dart';
import 'package:portfolio/view/projects_section.dart';
import 'package:portfolio/view/skills_section.dart';

class HomeScreem extends StatelessWidget {
  const HomeScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = const [
      HeaderSection(),
      AboutSection(),
      ExperienceSection(),
      ProjectsSection(),
      SkillsSection(),
      EducationSection(),
      CertificationsSection(),
      FooterSection(),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF1a1a1a),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              sections.length,
              (index) => sections[index],
            ),
          ),
        ),
      ),
    );
  }
}
