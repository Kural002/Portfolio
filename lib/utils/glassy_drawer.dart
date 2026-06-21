import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/audio_helper.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GlassyDrawer extends StatelessWidget {
  final ThemeProvider themeProvider;
  final void Function(GlobalKey) scrollToSection;

  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey educationKey;
  final GlobalKey certificationsKey;

  const GlassyDrawer({
    super.key,
    required this.themeProvider,
    required this.scrollToSection,
    required this.aboutKey,
    required this.experienceKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.educationKey,
    required this.certificationsKey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;

    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF0C0C0E) : const Color(0xFFFAF8F5)).withOpacity(0.9),
            border: Border(
              right: BorderSide(
                color: isDark 
                    ? AppColors.primary.withOpacity(0.18) 
                    : AppColors.primary.withOpacity(0.35),
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildHeader(context, isDark),
                    const SizedBox(height: 10),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        "NAVIGATION",
                        style: GoogleFonts.spaceMono(
                          color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    _buildDrawerItem(context, "01", "About", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(aboutKey);
                    }),
                    _buildDrawerItem(context, "02", "Experience", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(experienceKey);
                    }),
                    _buildDrawerItem(context, "03", "Projects", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(projectsKey);
                    }),
                    _buildDrawerItem(context, "04", "Skills", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(skillsKey);
                    }),
                    _buildDrawerItem(context, "05", "Education", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(educationKey);
                    }),
                    _buildDrawerItem(context, "06", "Certifications", isDark, () {
                      Navigator.pop(context);
                      scrollToSection(certificationsKey);
                    }),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                      child: Divider(
                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.06),
                        thickness: 1,
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        "LIVE WEB APPS",
                        style: GoogleFonts.spaceMono(
                          color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    _buildExternalDrawerItem(
                      context, 
                      Icons.cloud_outlined, 
                      "Live Weather App", 
                      isDark, 
                      () => _launch(AppUrls.weatherAppDeployed)
                    ),
                    _buildExternalDrawerItem(
                      context, 
                      FontAwesomeIcons.heartPulse, 
                      "BetterME App", 
                      isDark, 
                      () => _launch(AppUrls.BetterMEAPK)
                    ),
                  ],
                ),
              ),
              
              // Theme & Sound Toggle Panel
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SETTINGS",
                      style: GoogleFonts.spaceMono(
                        color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SoundToggle(isDark: isDark),
                        const SizedBox(width: 16),
                        _buildThemeToggle(themeProvider, isDark),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "KURALARASU",
                  style: GoogleFonts.playfairDisplay(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
                TextSpan(
                  text: ".",
                  style: GoogleFonts.playfairDisplay(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Full-Stack Flutter Developer",
            style: GoogleFonts.inter(
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, String index, String title, bool isDark, VoidCallback onTap) {
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) => cursorProvider.setHovering(true),
          onExit: (_) => cursorProvider.setHovering(false),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            leading: Text(
              index,
              style: GoogleFonts.spaceMono(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Row(
              children: [
                Text(
                  "//",
                  style: GoogleFonts.spaceMono(
                    color: isDark ? Colors.white24 : Colors.black26,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            onTap: () {
              AudioHelper.playClick();
              cursorProvider.setHovering(false);
              onTap();
            },
            hoverColor: AppColors.primary.withOpacity(0.05),
          ),
        );
      },
    );
  }

  Widget _buildExternalDrawerItem(
      BuildContext context, IconData icon, String title, bool isDark, VoidCallback onTap) {
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) => cursorProvider.setHovering(true),
          onExit: (_) => cursorProvider.setHovering(false),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            leading: Icon(
              icon, 
              color: AppColors.primary, 
              size: 15,
            ),
            title: Text(
              title,
              style: GoogleFonts.inter(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.arrow_outward_rounded,
              color: isDark ? Colors.white24 : Colors.black26,
              size: 14,
            ),
            onTap: () {
              AudioHelper.playClick();
              cursorProvider.setHovering(false);
              onTap();
            },
            hoverColor: AppColors.primary.withOpacity(0.05),
          ),
        );
      },
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider, bool isDark) {
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => cursorProvider.setHovering(true),
          onExit: (_) => cursorProvider.setHovering(false),
          child: GestureDetector(
            onTap: () {
              AudioHelper.playClick();
              themeProvider.toggleTheme();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 54,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark 
                    ? const Color(0xFF1E1E22) 
                    : const Color(0xFFE2E2E9),
                border: Border.all(
                  color: isDark 
                      ? Colors.white.withOpacity(0.08) 
                      : Colors.black.withOpacity(0.06),
                  width: 1.0,
                ),
              ),
              child: Stack(
                children: [
                  // Slide background dot
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    alignment: isDark 
                        ? Alignment.centerRight 
                        : Alignment.centerLeft,
                    child: Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Sun icon on the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.light_mode_rounded,
                        size: 11,
                        color: isDark ? Colors.white38 : Colors.white,
                      ),
                    ),
                  ),
                  // Moon icon on the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.dark_mode_rounded,
                        size: 11,
                        color: isDark ? Colors.white : Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SoundToggle extends StatefulWidget {
  final bool isDark;
  const _SoundToggle({required this.isDark});

  @override
  State<_SoundToggle> createState() => _SoundToggleState();
}

class _SoundToggleState extends State<_SoundToggle> {
  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);
    final isSound = AudioHelper.isSoundEnabled;

    return MouseRegion(
      onEnter: (_) => cursorProvider.setHovering(true),
      onExit: (_) => cursorProvider.setHovering(false),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          setState(() {
            AudioHelper.isSoundEnabled = !AudioHelper.isSoundEnabled;
          });
          AudioHelper.playClick();
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isSound ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            key: ValueKey<bool>(isSound),
            color: widget.isDark 
                ? (isSound ? AppColors.primary : Colors.white30) 
                : (isSound ? AppColors.primary : Colors.black26),
            size: 18,
          ),
        ),
      ),
    );
  }
}
