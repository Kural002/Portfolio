import 'package:flutter/material.dart';
import 'package:portfolio/utils/glassy_drawer.dart';
import 'package:portfolio/view/about_section.dart';
import 'package:portfolio/view/certifications_section.dart';
import 'package:portfolio/view/education_section.dart';
import 'package:portfolio/view/experience_section.dart';
import 'package:portfolio/view/footer_section.dart';
import 'package:portfolio/view/header_section.dart';
import 'package:portfolio/view/projects_section.dart';
import 'package:portfolio/view/skills_section.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificationsKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final isDark = themeProvider.isDarkMode;
    final gradientColors = isDark
        ? [Colors.black, const Color(0xFF1a1a1a)]
        : [Colors.white, const Color(0xFFe6e6e6)];

    return Scaffold(
      drawer: GlassyDrawer(
        themeProvider: themeProvider,
        scrollToSection: _scrollToSection,
        aboutKey: aboutKey,
        experienceKey: experienceKey,
        skillsKey: skillsKey,
        projectsKey: projectsKey,
        educationKey: educationKey,
        certificationsKey: certificationsKey,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(scrollToSection: _scrollToSection),
              Container(key: aboutKey, child: const AboutSection()),
              Container(key: experienceKey, child: const ExperienceSection()),
              Container(key: projectsKey, child: const ProjectsSection()),
              Container(key: skillsKey, child: const SkillsSection()),
              Container(key: educationKey, child: const EducationSection()),
              Container(
                  key: certificationsKey, child: const CertificationsSection()),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
