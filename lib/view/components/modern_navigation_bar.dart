import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/audio_helper.dart';
import 'package:portfolio/utils/cursor_provider.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 900;
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final Color strokeColor = isDark 
        ? AppColors.primary.withOpacity(0.18) 
        : AppColors.primary.withOpacity(0.35);
    final Color backgroundFill = isDark 
        ? const Color(0xFF0C0C0E).withOpacity(0.6) 
        : Colors.white.withOpacity(0.65);

    if (isWeb) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Floating Logo Island
            _buildGlassContainer(
              isDark: isDark,
              strokeColor: strokeColor,
              backgroundFill: backgroundFill,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "KURALARASU",
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Center: Navigation Links Island
            _buildGlassContainer(
              isDark: isDark,
              strokeColor: strokeColor,
              backgroundFill: backgroundFill,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavLink("01", "About", aboutKey, isDark),
                  const SizedBox(width: 8),
                  _buildNavLink("02", "Experience", experienceKey, isDark),
                  const SizedBox(width: 8),
                  _buildNavLink("03", "Projects", projectsKey, isDark),
                  const SizedBox(width: 8),
                  _buildNavLink("04", "Skills", skillsKey, isDark),
                ],
              ),
            ),
            
            // Right: Actions Island (Theme & Sound Toggle)
            _buildGlassContainer(
              isDark: isDark,
              strokeColor: strokeColor,
              backgroundFill: backgroundFill,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SoundToggle(isDark: isDark),
                  const SizedBox(width: 12),
                  _buildThemeToggle(themeProvider, isDark),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile Layout: Split Logo & compact menu control
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Floating Logo Island
            _buildGlassContainer(
              isDark: isDark,
              strokeColor: strokeColor,
              backgroundFill: backgroundFill,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "KURALARASU",
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Right: Toggle + Menu Badge
            _buildGlassContainer(
              isDark: isDark,
              strokeColor: strokeColor,
              backgroundFill: backgroundFill,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SoundToggle(isDark: isDark),
                  const SizedBox(width: 8),
                  _buildThemeToggle(themeProvider, isDark),
                  const SizedBox(width: 8),
                  Consumer<CursorProvider>(
                    builder: (context, cursorProvider, child) {
                      return MouseRegion(
                        onEnter: (_) => cursorProvider.setHovering(true),
                        onExit: (_) => cursorProvider.setHovering(false),
                        child: IconButton(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                          onPressed: () {
                            AudioHelper.playClick();
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu_rounded,
                            color: isDark ? Colors.white : Colors.black,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildGlassContainer({
    required bool isDark,
    required Color strokeColor,
    required Color backgroundFill,
    required EdgeInsetsGeometry padding,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundFill,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: strokeColor,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.15 : 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String index, String title, GlobalKey key, bool isDark) {
    return _InteractiveNavLink(
      index: index,
      title: title,
      onTap: () => scrollToSection(key),
      isDark: isDark,
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

class _InteractiveNavLink extends StatefulWidget {
  final String index;
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _InteractiveNavLink({
    required this.index,
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
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);

    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        cursorProvider.setHovering(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        cursorProvider.setHovering(false);
      },
      child: InkWell(
        onTap: () {
          AudioHelper.playClick();
          widget.onTap();
        },
        borderRadius: BorderRadius.circular(30),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isHovered 
                ? (widget.isDark 
                    ? Colors.white.withOpacity(0.04) 
                    : Colors.black.withOpacity(0.03))
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Index Prefix (e.g. 01)
              Text(
                widget.index,
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 6),
              // Separator
              Text(
                "//",
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: widget.isDark ? Colors.white24 : Colors.black26,
                ),
              ),
              const SizedBox(width: 6),
              // Text Title
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isHovered 
                      ? (widget.isDark ? Colors.white : Colors.black)
                      : (widget.isDark ? Colors.white60 : Colors.black54),
                  letterSpacing: 2.0,
                ),
                child: Text(widget.title.toUpperCase()),
              ),
              // Tiny animated dot indicator next to it
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: isHovered ? 6 : 0,
                height: 6,
                margin: EdgeInsets.only(left: isHovered ? 6 : 0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.6),
                      blurRadius: 4,
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
