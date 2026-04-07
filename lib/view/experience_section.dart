import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
          _ExperienceTimeline(isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "JOURNEY",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Experience",
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

class _ExperienceTimeline extends StatelessWidget {
  final bool isDark;

  const _ExperienceTimeline({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        "company": "Yellow Boards Pvt Ltd",
        "role": "Flutter Developer Intern",
        "period": "Nov 2024 - May 2025",
        "desc": "Built and maintained cross-platform mobile applications using Flutter. Focused on developing responsive UIs and integrating core features for startup products.",
        "cert": AppUrls.yellowBoards,
        "isCurrent": true,
      },
      {
        "company": "Elewaytech Pvt Ltd",
        "role": "Mobile Application Intern",
        "period": "Dec 2023 - Feb 2024",
        "desc": "Assisted in mobile app development, focusing on bug fixes and performance optimization. Contributed to agile team environments and code reviews.",
        "cert": AppUrls.elewayte,
        "isCurrent": false,
      },
    ];

    return Column(
      children: experiences.map((exp) {
        return _ExperienceCard(
          company: exp["company"] as String,
          role: exp["role"] as String,
          period: exp["period"] as String,
          description: exp["desc"] as String,
          certUrl: exp["cert"] as String,
          isDark: isDark,
          isCurrent: exp["isCurrent"] as bool,
        );
      }).toList(),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String company;
  final String role;
  final String period;
  final String description;
  final String certUrl;
  final bool isDark;
  final bool isCurrent;

  const _ExperienceCard({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.certUrl,
    required this.isDark,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot and Line
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isCurrent ? AppColors.primary : (isDark ? Colors.white24 : Colors.black12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(isCurrent ? 0.3 : 0),
                    width: 4,
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 150,
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Content Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isCurrent 
                      ? AppColors.primary.withOpacity(0.2) 
                      : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role,
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            Text(
                              company,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (isCurrent ? AppColors.primary : (isDark ? Colors.white : Colors.black)).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          period,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isCurrent ? AppColors.primary : (isDark ? AppColors.darkTextDim : AppColors.lightTextDim),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      height: 1.6,
                      color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCertButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertButton(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(certUrl),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_outlined, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              "View Certificate",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
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
