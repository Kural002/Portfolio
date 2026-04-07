import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/utils/glassy_drawer.dart';
import 'package:portfolio/view/about_section.dart';
import 'package:portfolio/view/certifications_section.dart';
import 'package:portfolio/view/components/modern_navigation_bar.dart';
import 'package:portfolio/view/education_section.dart';
import 'package:portfolio/view/experience_section.dart';
import 'package:portfolio/view/footer_section.dart';
import 'package:portfolio/view/header_section.dart';
import 'package:portfolio/view/projects_section.dart';
import 'package:portfolio/view/skills_section.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/view/components/animated_background.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificationsKey = GlobalKey();
  final GlobalKey footerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _scrollProgress = (_scrollController.offset / 
              (_scrollController.position.maxScrollExtent > 0 
                  ? _scrollController.position.maxScrollExtent 
                  : 1))
              .clamp(0.0, 1.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext == null) return;
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final List<Widget> sections = [
      HeaderSection(
        scrollToSection: _scrollToSection,
        onGetInTouch: () => _scrollToSection(footerKey),
      ),
      Container(key: aboutKey, child: const AboutSection()),
      Container(key: experienceKey, child: const ExperienceSection()),
      Container(key: projectsKey, child: const ProjectsSection()),
      Container(key: skillsKey, child: const SkillsSection()),
      Container(key: educationKey, child: const EducationSection()),
      Container(key: certificationsKey, child: const CertificationsSection()),
      FooterSection(key: footerKey),
    ];

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
      body: Stack(
        children: [
          // Background Gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [AppColors.darkBg, const Color(0xFF141E30)]
                    : [AppColors.lightBg, const Color(0xFFECE9E6)],
              ),
            ),
          ),
          
          // Global Animated Particles Background
          Positioned.fill(
            child: AnimatedBackground(isDark: isDark),
          ),

          // Scrollable Content
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100), // Space for nav bar
                  AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 1000),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: sections,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Navigation Bar (Web/Mobile)
          ModernNavigationBar(
            scrollToSection: _scrollToSection,
            aboutKey: aboutKey,
            experienceKey: experienceKey,
            skillsKey: skillsKey,
            projectsKey: projectsKey,
            educationKey: educationKey,
            certificationsKey: certificationsKey,
          ),

          // Scroll Progress Bar (Top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: MediaQuery.of(context).size.width * _scrollProgress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
