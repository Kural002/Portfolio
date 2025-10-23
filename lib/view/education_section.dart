import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:provider/provider.dart'; // Add this import

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: isWeb ? 25 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education',
            style: GoogleFonts.montserrat(
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          _buildEducationTimeline(context, isWeb: isWeb),
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
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTimeline(BuildContext context, {required bool isWeb}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Column(
      children: [
        _buildEducationItem(
          context: context,
          degree: 'B.Tech Computer and Communication Engineering',
          institution: 'Sri Manakula Vinayagar Engineering College',
          year: '2021 - 2025',
          description: 'CGPA: 6.76/10.0',
          isHighlighted: true,
        ),
        const SizedBox(height: 24),
        _buildEducationItem(
          context: context,
          degree: '12th Grade - Computer Science',
          institution: 'Srk International School',
          year: '2020 - 2021',
          description: 'Percentage: 81% | CBSE Board',
          isHighlighted: false,
        ),
      ],
    );
  }

  Widget _buildEducationItem({
    required BuildContext context,
    required String degree,
    required String institution,
    required String year,
    required String description,
    required bool isHighlighted,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.blueAccent : Colors.grey[600],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isHighlighted ? Colors.blueAccent : Colors.grey[600]!)
                      .withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  institution,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                        .withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      year,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                            .withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(isDarkMode ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(isDarkMode ? 0.3 : 0.2),
                    ),
                  ),
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}