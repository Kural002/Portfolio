import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart'; // Add this import

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = WebsiteConstraints.isWeb(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 24,
        vertical: isWeb ? 25 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certifications",
            style: GoogleFonts.montserrat(
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              _buildMinimalCertificationItem(
                context,
                "Flutter & Dart Bootcamp",
                "Udemy",
                AppUrls.udemy,
                Icons.verified,
                Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              _buildMinimalCertificationItem(
                context,
                "Flutter Developer",
                "GUVI",
                AppUrls.guvi,
                Icons.verified,
                Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              _buildMinimalCertificationItem(
                context,
                "Flutter Bootcamp",
                "LetsUpgrade",
                AppUrls.letsUpgrade,
                Icons.verified,
                Colors.blueAccent,
              ),
            ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalCertificationItem(
    BuildContext context,
    String title,
    String provider,
    String url,
    IconData icon,
    Color color,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                  .withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(isDarkMode ? 0.15 : 0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withOpacity(isDarkMode ? 0.3 : 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: isDarkMode
                            ? AppColors.darkText
                            : AppColors.lightText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      provider,
                      style: GoogleFonts.poppins(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                      .withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: (isDarkMode ? AppColors.darkText : AppColors.lightText)
                      .withOpacity(0.6),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
