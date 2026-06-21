import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/audio_helper.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCaseStudy extends StatelessWidget {
  final String title;
  final String url;
  final bool isDark;

  const ProjectCaseStudy({
    super.key,
    required this.title,
    required this.url,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 900;

    // Detailed case study content based on project
    final String architecture;
    final String designChoices;
    final List<String> achievements;
    final String category;
    final List<String> tech;

    if (title.contains("Weather")) {
      category = "MOBILE & WEB APPLICATION";
      tech = ["Flutter", "OpenWeather API", "Provider", "SharedPrefs"];
      architecture = "Built using the MVVM architecture patterns with Provider for state management. Features complete separation between view layouts, local caching models, and remote JSON serialization handlers. Calls are optimized to cache response payloads locally to prevent redundant network requests and reduce data transfer costs.";
      designChoices = "Adopts a fluid glassmorphism design language with dynamic backdrop color gradients that transition color palettes to match the current condition of the searched city (e.g. warm gold for clear sun, deep obsidian indigo for rain, muted bronze for mist).";
      achievements = [
        "Implemented city search history cached locally using Shared Preferences.",
        "Optimized network requests by caching API payloads, reducing server round-trips by 40%.",
        "Designed and painted custom canvas wave indicators matching current wind speeds.",
        "Achieved 100% responsive resizing layout scaling perfectly from mobile view up to desktop browser targets."
      ];
    } else if (title.contains("Expense")) {
      category = "FINANCE & WEALTH APP";
      tech = ["Flutter", "Firebase", "Provider", "FlChart"];
      architecture = "Constructed using clean layer boundaries between localized Provider state caches and remote Firestore instances. Employs offline-first synchronization models that buffer user transaction records in local SQLite database caches during offline periods, executing atomic batch updates once Internet connectivity is restored.";
      designChoices = "Adopts a sophisticated dark-mode glassmorphic interface inspired by modern fintech layouts. Color hierarchies rely on deep charcoal panels contrasted against sharp emerald gains and amber alerts, creating a highly premium investment feel.";
      achievements = [
        "Architected an offline-first transaction ledger syncing automatically without data collisions.",
        "Developed interactive, hardware-accelerated financial analytics charts using custom graphics pipelines.",
        "Implemented real-time CSV/PDF expense report exporter modules.",
        "Reduced Firestore database reads by 60% via client-side transaction caching algorithms."
      ];
    } else if (title.contains("Pokedex")) {
      category = "API & DATA VISUALIZATION APP";
      tech = ["Flutter", "REST API", "Animations", "Hive"];
      architecture = "Leverages high-speed paginated query systems to load hundreds of detailed data entities without UI stuttering. Incorporates a layered repository pattern that coordinates HTTP fetching, raw JSON parsing threads, and quick-access local Hive cache lookups.";
      designChoices = "Employs an interactive physical console layout with fluid retro game-inspired transitions. The background dynamic accent color swaps seamlessly to match the elemental type (e.g. fire red, grass green, water blue) of the highlighted entity.";
      achievements = [
        "Constructed fluid 60FPS list transitions utilizing custom Hero widget interpolations.",
        "Designed local search engines with fuzzy-matching text queries and instant filtering capabilities.",
        "Engineered background multi-threaded compute isolates for high-speed JSON parsing.",
        "Optimized image rendering using cached network images with custom memory eviction limits."
      ];
    } else if (title.contains("Portfolio")) {
      category = "WEB APPLICATION PORTFOLIO";
      tech = ["Flutter Web", "CSS Glassmorphism", "JS Web Audio", "Provider"];
      architecture = "Designed as a single-page responsive application optimized for high-speed browser rendering. Incorporates clean service injectors for background theme animations, custom mouse cursor listeners, and synthetic JavaScript Audio APIs directly invoked from Dart code elements.";
      designChoices = "Emphasizes luxury editorial design aesthetics using elegant Playfair Display serif headings and Orbit/Space Mono accents. Blends dark obsidian canvas zones with glassmorphic cards and gold particle accents.";
      achievements = [
        "Engineered synthetic audio synthesizers running dynamic oscillators in the web browser context.",
        "Created CustomPainter credentials indicators with hover-bound sweep animations.",
        "Designed vector-based circular theme wipes executing in less than 200ms.",
        "Achieved 100% responsive resizing spanning mobile screens through ultra-wide desktop monitors."
      ];
    } else {
      category = "FITNESS & WELLNESS APP";
      tech = ["Flutter", "HealthKit API", "Provider", "Local Database"];
      architecture = "Designed using Clean Architecture layer separation to isolate domain business rules, exercise repositories, and local database stores. Step count metrics synchronize reactively in background threads utilizing native platform channel listeners (iOS HealthKit and Android Google Fit).";
      designChoices = "Utilizes high-contrast dark neon obsidian surfaces and typography to minimize eye strain during evening runs or dim gym environments. Visual cards feature neon gold outline highlights that pop organically.";
      achievements = [
        "Constructed offline-first database caching layer synchronizing automatically when online.",
        "Engineered background service threads that update steps statistics with minimal battery footprint.",
        "Created custom canvas-drawn exercise rings that fill dynamically matching step completion thresholds.",
        "Integrated custom localized push reminders motivating users for daily workouts."
      ];
    }

    final Color strokeColor = isDark 
        ? AppColors.primary.withOpacity(0.18) 
        : AppColors.primary.withOpacity(0.35);
    final Color backgroundFill = isDark 
        ? const Color(0xFF0C0C0E).withOpacity(0.9) 
        : Colors.white.withOpacity(0.92);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          isWeb ? 60 : 20, 
          30, 
          isWeb ? 60 : 20, 
          isWeb ? 50 : 30
        ),
        decoration: BoxDecoration(
          color: backgroundFill,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(
            top: BorderSide(color: strokeColor, width: 1.5),
            left: BorderSide(color: strokeColor, width: 0.5),
            right: BorderSide(color: strokeColor, width: 0.5),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Drag Handle indicator
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Title and Close Button row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: GoogleFonts.spaceMono(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: isWeb ? 36 : 28,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // circular Close Button
                  _buildCloseButton(context),
                ],
              ),
              const SizedBox(height: 20),

              // Tech stack row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tech.map((t) => _buildTechBadge(t)).toList(),
              ),
              const SizedBox(height: 30),

              // Case study body
              if (isWeb)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("ARCHITECTURE"),
                          const SizedBox(height: 12),
                          _buildBodyText(architecture),
                          const SizedBox(height: 30),
                          _buildSectionTitle("DESIGN STRATEGY"),
                          const SizedBox(height: 12),
                          _buildBodyText(designChoices),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("KEY ACHIEVEMENTS"),
                          const SizedBox(height: 16),
                          ...achievements.map((ach) => _buildBulletRow(ach, isDark)).toList(),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("ARCHITECTURE"),
                    const SizedBox(height: 12),
                    _buildBodyText(architecture),
                    const SizedBox(height: 30),
                    _buildSectionTitle("DESIGN STRATEGY"),
                    const SizedBox(height: 12),
                    _buildBodyText(designChoices),
                    const SizedBox(height: 30),
                    _buildSectionTitle("KEY ACHIEVEMENTS"),
                    const SizedBox(height: 16),
                    ...achievements.map((ach) => _buildBulletRow(ach, isDark)).toList(),
                  ],
                ),
              const SizedBox(height: 40),
              Center(
                child: _buildLiveProjectButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveProjectButton(BuildContext context) {
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) => cursorProvider.setHovering(true),
          onExit: (_) => cursorProvider.setHovering(false),
          child: GestureDetector(
            onTap: () async {
              AudioHelper.playClick();
              final uri = Uri.parse(url);
              if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "EXPLORE LIVE PROJECT",
                    style: GoogleFonts.spaceMono(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.black : Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 16,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) => cursorProvider.setHovering(true),
          onExit: (_) => cursorProvider.setHovering(false),
          child: GestureDetector(
            onTap: () {
              AudioHelper.playClick();
              cursorProvider.setHovering(false);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
                ),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 18,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTechBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.spaceMono(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.spaceMono(
            fontSize: 11,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14.5,
        height: 1.7,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
      ),
    );
  }

  Widget _buildBulletRow(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14.0,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
