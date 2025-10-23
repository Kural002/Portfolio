import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:provider/provider.dart'; // Add this import

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Get theme provider
    final isDarkMode = themeProvider.isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: isWeb ? 25 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: GoogleFonts.montserrat(
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                    .withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBulletPoint(
                  context,
                  "Passionate Flutter developer crafting responsive, cross-platform applications with focus on performance and user experience.",
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  context,
                  "Expertise in Firebase, REST APIs, and state management using Provider to build scalable and maintainable applications.",
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  context,
                  "Transforming ideas into clean, user-friendly mobile and web solutions with attention to detail and best practices.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  (isDarkMode ? AppColors.darkText : AppColors.lightText)
                      .withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.arrow_right_alt_rounded,
          color: Colors.blueAccent,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
