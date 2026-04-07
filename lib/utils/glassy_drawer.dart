import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
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
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: (isDark ? Colors.black : Colors.white).withOpacity(0.8),
            border: Border(
              right: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
              ),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(context, isDark),
              const SizedBox(height: 20),
              _buildDrawerItem(context, Icons.person_outline, "About", isDark, () {
                Navigator.pop(context);
                scrollToSection(aboutKey);
              }),
              _buildDrawerItem(context, Icons.work_outline, "Experience", isDark, () {
                Navigator.pop(context);
                scrollToSection(experienceKey);
              }),
              _buildDrawerItem(context, Icons.code_rounded, "Skills", isDark, () {
                Navigator.pop(context);
                scrollToSection(skillsKey);
              }),
              _buildDrawerItem(context, Icons.rocket_launch_outlined, "Projects", isDark, () {
                Navigator.pop(context);
                scrollToSection(projectsKey);
              }),
              _buildDrawerItem(context, Icons.school_outlined, "Education", isDark, () {
                Navigator.pop(context);
                scrollToSection(educationKey);
              }),
              _buildDrawerItem(context, Icons.verified_outlined, "Certifications", isDark,
                  () {
                Navigator.pop(context);
                scrollToSection(certificationsKey);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(color: (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1))),
              ),
              _buildDrawerItem(
                  context, Icons.cloud_outlined, "Live Weather App", isDark, () => _launch(AppUrls.weatherAppDeployed)),
              _buildDrawerItem(context, FontAwesomeIcons.heart, "BetterME App", isDark,
                  () => _launch(AppUrls.BetterMEAPK)),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppColors.glassDecoration(isDark: isDark),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDark ? "Dark Mode" : "Light Mode",
                        style: GoogleFonts.poppins(
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                          fontSize: 14,
                        ),
                      ),
                      Switch(
                        value: isDark,
                        onChanged: (value) => themeProvider.toggleTheme(),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
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
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(FontAwesomeIcons.flutter, size: 32, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text(
            "KURALARASU B",
            style: GoogleFonts.montserrat(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Flutter Developer",
            style: GoogleFonts.poppins(
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, bool isDark, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54, size: 22),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
