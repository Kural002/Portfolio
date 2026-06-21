import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/utils/circular_reveal_clipper.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:portfolio/view/components/custom_cursor.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;

  late AnimationController _revealController;
  bool _isRevealing = false;
  bool _revealFromDark = true;
  bool? _wasDark;

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
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
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
    _revealController.dispose();
    super.dispose();
  }

  void _triggerThemeReveal(bool wasDark, bool isDark) {
    if (mounted) {
      setState(() {
        _revealFromDark = wasDark;
        _isRevealing = true;
      });
      _revealController.forward(from: 0.0).then((_) {
        if (mounted) {
          setState(() {
            _isRevealing = false;
          });
        }
      });
    }
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
    final isWeb = MediaQuery.of(context).size.width > 900;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);

    if (_wasDark != null && _wasDark != isDark) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerThemeReveal(_wasDark!, isDark);
      });
    }
    _wasDark = isDark;

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
      body: MouseRegion(
        cursor: (isWeb && Provider.of<CursorProvider>(context).showCursor) 
            ? SystemMouseCursors.none 
            : MouseCursor.defer,
        onHover: (event) {
          if (isWeb) {
            cursorProvider.updatePosition(event.position);
          }
        },
        onExit: (event) {
          if (isWeb) {
            cursorProvider.hideCursor();
          }
        },
        child: Stack(
          children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [AppColors.darkBg, const Color(0xFF07080F)]
                    : [AppColors.lightBg, const Color(0xFFEBE6DD)],
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
          // Theme Circular Reveal Wipe Overlay
          if (_isRevealing)
          // Theme Circular Reveal Wipe Overlay
          if (_isRevealing)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _revealController,
                builder: (context, child) {
                  return ClipPath(
                    clipper: CircularRevealClipper(
                      fraction: 1.0 - _revealController.value,
                      center: Offset(MediaQuery.of(context).size.width - 80, 50),
                    ),
                    child: Container(
                      color: _revealFromDark ? AppColors.darkBg : AppColors.lightBg,
                    ),
                  );
                },
              ),
            ),

          // Custom cursor overlay layer (only on desktop/web screens)
          if (isWeb) const CustomCursor(),
        ],
      ),
    ),
  );
  }
}
