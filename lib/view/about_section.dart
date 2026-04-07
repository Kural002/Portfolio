import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 50),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildAboutText(isDark)),
                const SizedBox(width: 60),
                Expanded(flex: 2, child: _buildStatsGrid(isDark)),
              ],
            )
          else
            Column(
              children: [
                _buildAboutText(isDark),
                const SizedBox(height: 40),
                _buildStatsGrid(isDark),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INTRODUCTION",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "About Me",
          style: GoogleFonts.montserrat(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutText(bool isDark) {
    final style = GoogleFonts.poppins(
      fontSize: 18,
      height: 1.8,
      color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I am a focused Flutter Developer with a strong foundation in building cross-platform applications during my internships at various startups. I specialize in transforming product requirements into fluid, high-performance mobile experiences.",
          style: style,
        ),
        const SizedBox(height: 20),
        Text(
          "With practical experience in startup environments, I have mastered state management (Provider), Firebase integration, and modern UI/UX principles, ensuring every application I build is scalable and user-centric.",
          style: style,
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isDark) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard("9", "Months Exp", Icons.timeline_rounded, isDark),
        _buildStatCard("15+", "Projects", Icons.rocket_launch_rounded, isDark),
        _buildStatCard("10+", "Tools", Icons.build_circle_outlined, isDark),
        _buildStatCard("5+", "Certs", Icons.verified_user_outlined, isDark),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 12),
          Text(
            val,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
            ),
          ),
        ],
      ),
    );
  }
}
