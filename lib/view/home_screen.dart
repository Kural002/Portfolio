import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/about_section.dart';
import 'package:portfolio/view/certifications_section.dart';
import 'package:portfolio/view/projects_section.dart';
import 'package:portfolio/widgets/custom_nav_bar.dart';
import 'package:portfolio/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final certificationsKey = GlobalKey();
  final achievementsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Portfolio',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
              CustomNavBar(
            // onAboutTap: () => _scrollTo(aboutKey),
            onProjectsTap: () => _scrollTo(projectsKey),
            // onCertificationsTap: () => _scrollTo(certificationsKey),
          ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: const Header(),
                  ),
                ),
              ),
            ),
            Text(
              "Projects",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 10000),
                    child: ProjectsSection(
                      key: projectsKey,
                      projects: [],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }