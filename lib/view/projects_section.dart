import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 1000;
    final isTablet = width > 600 && width <= 1000;
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWeb ? 3 : (isTablet ? 2 : 1),
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: isWeb ? 1.4 : 1.2,
            ),
            itemBuilder: (context, index) {
              final projects = [
                {
                  "title": "Expense Tracker",
                  "desc": "Full-stack finance management with real-time sync.",
                  "icon": FontAwesomeIcons.wallet,
                  "url": AppUrls.expenseTracker,
                  "tech": ["Flutter", "Firebase", "Provider"]
                },
                {
                  "title": "Pokedex",
                  "desc": "High-performance Pokemon encyclopedia using REST API.",
                  "icon": Icons.catching_pokemon,
                  "url": AppUrls.pokedex,
                  "tech": ["Flutter", "REST API", "Animations"]
                },
                {
                  "title": "Modern Portfolio",
                  "desc": "Responsive web portfolio with glassmorphism UI.",
                  "icon": Icons.web_rounded,
                  "url": AppUrls.portfolio,
                  "tech": ["Flutter Web", "Glassmorphism"]
                },
                {
                  "title": "Weather Live",
                  "desc": "Dynamic weather app with geolocation and forecasts.",
                  "icon": Icons.cloud_queue_rounded,
                  "url": AppUrls.weatherApp,
                  "tech": ["Flutter", "OpenWeather", "Maps"]
                },
                {
                  "title": "BetterMe",
                  "desc": "Personalized health and wellness tracking platform.",
                  "icon": FontAwesomeIcons.heartPulse,
                  "url": AppUrls.betterMeApp,
                  "tech": ["Flutter", "Analytics", "HealthKit"]
                },
              ];
              final p = projects[index];
              return _ProjectCard(
                title: p["title"] as String,
                description: p["desc"] as String,
                icon: p["icon"] as IconData,
                url: p["url"] as String,
                technologies: (p["tech"] as List).cast<String>(),
                isDark: isDark,
              );
            },
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
          "PORTFOLIO",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Featured Projects",
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
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final String url;
  final List<String> technologies;
  final bool isDark;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.url,
    required this.technologies,
    required this.isDark,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered 
                ? AppColors.primary.withOpacity(0.5) 
                : (widget.isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            width: 2,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _launchURL(widget.url),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(widget.icon, color: AppColors.primary, size: 24),
                    ),
                    Icon(
                      Icons.arrow_outward_rounded,
                      color: isHovered ? AppColors.primary : (widget.isDark ? Colors.white30 : Colors.black26),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: widget.isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.technologies.map((tech) => _buildTechChip(tech)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (widget.isDark ? Colors.white : Colors.black).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (widget.isDark ? Colors.white : Colors.black).withOpacity(0.05)),
      ),
      child: Text(
        tech,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: widget.isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
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
