import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    final isHorizontal = WebsiteConstraints.isLandscape(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    int crossAxisCount;
    if (isWeb) {
      crossAxisCount = 5;
    } else if (isHorizontal) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    double childAspectRatio;
    if (isWeb) {
      childAspectRatio = 0.9;
    } else if (isHorizontal) {
      childAspectRatio = 1.3;
    } else {
      childAspectRatio = 1.4;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 80 : 25,
        vertical: isWeb ? 40 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects",
            style: GoogleFonts.montserrat(
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isWeb ? 30 : 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
            children: [
              _buildProjectCard(
                context,
                "Expense Tracker",
                "Track expenses with budget management",
                FontAwesomeIcons.wallet,
                AppUrls.expenseTracker,
                ["Flutter", "Firebase", "Provider"],
              ),
              _buildProjectCard(
                context,
                "Pokedex",
                "Pokemon encyclopedia with search & filters",
                Icons.catching_pokemon,
                AppUrls.pokedex,
                ["Flutter", "REST API", "Provider"],
              ),
              _buildProjectCard(
                context,
                "Portfolio Website",
                "Responsive portfolio with clean UI",
                Icons.web,
                AppUrls.portfolio,
                ["Flutter", "Web", "Responsive"],
              ),
              _buildProjectCard(
                context,
                "Weather App",
                "Real-time weather with forecasts",
                Icons.cloud,
                AppUrls.weatherApp,
                ["Flutter", "API", "Geolocation"],
              ),
              _buildProjectCard(
                context,
                "BetterMe App",
                "Personalized fitness and wellness app",
                FontAwesomeIcons.heart,
                AppUrls.betterMeApp,
                ["Flutter", "API", "Geolocation"],
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
          )
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    String url,
    List<String> technologies,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? AppColors.darkText
                              : AppColors.lightText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      color: (isDarkMode
                              ? AppColors.darkText
                              : AppColors.lightText)
                          .withOpacity(0.7),
                      fontSize: 12,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: technologies.map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.blueAccent.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent
                          .withOpacity(isDarkMode ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.blueAccent
                            .withOpacity(isDarkMode ? 0.4 : 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View",
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: 10, // Smaller font
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blueAccent,
                          size: 12, // Smaller icon
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
