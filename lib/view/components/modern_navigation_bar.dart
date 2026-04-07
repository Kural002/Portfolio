import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class ModernNavigationBar extends StatelessWidget {
  final Function(GlobalKey) scrollToSection;
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey educationKey;
  final GlobalKey certificationsKey;

  const ModernNavigationBar({
    super.key,
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
    final isWeb = MediaQuery.of(context).size.width > 800;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 20,
        vertical: 20,
      ),
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: (isDark ? Colors.black : Colors.white).withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo/Name
                Text(
                  "KURALARASU",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 20,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),

                // Nav Links (Web)
                if (isWeb)
                  Row(
                    children: [
                      _buildNavLink("About", aboutKey, isDark),
                      _buildNavLink("Experience", experienceKey, isDark),
                      _buildNavLink("Projects", projectsKey, isDark),
                      _buildNavLink("Skills", skillsKey, isDark),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () => themeProvider.toggleTheme(),
                        icon: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => themeProvider.toggleTheme(),
                        icon: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: Icon(
                          Icons.menu_rounded,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, GlobalKey key, bool isDark) {
    return _InteractiveNavLink(
      title: title,
      onTap: () => scrollToSection(key),
      isDark: isDark,
    );
  }
}

class _InteractiveNavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _InteractiveNavLink({
    required this.title,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_InteractiveNavLink> createState() => _InteractiveNavLinkState();
}

class _InteractiveNavLinkState extends State<_InteractiveNavLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
              color: isHovered 
                  ? AppColors.primary 
                  : (widget.isDark ? Colors.white70 : Colors.black87),
              shadows: isHovered ? [
                Shadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: 10,
                )
              ] : [],
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
