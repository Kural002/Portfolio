import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
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
    return CreativeSectionHeader(
      number: "02",
      category: "Journey",
      title: "Work Experience",
      isDark: isDark,
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
        "company": "Mission Invictus",
        "role": "Flutter Developer Intern",
        "period": "Mar 2026 - Present",
        "desc": "Collaborating remotely to build and enhance real-world mobile applications using Flutter.",
        "cert": AppUrls.missionInvictus,
        "isCurrent": true,
      },
      {
        "company": "Yellow Boards Pvt Ltd",
        "role": "Flutter Developer Intern",
        "period": "Nov 2024 - May 2025",
        "desc": "Built and maintained cross-platform mobile applications using Flutter. Focused on developing responsive UIs and integrating core features for startup products.",
        "cert": AppUrls.yellowBoards,
        "isCurrent": false,
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
    final accentColor = isCurrent ? AppColors.primary : (isDark ? Colors.white24 : Colors.black26);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Elegant dot and connector
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isCurrent ? AppColors.primary : (isDark ? Colors.white30 : Colors.black26),
                    width: 2.5,
                  ),
                  boxShadow: isCurrent ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ] : [],
                ),
                child: isCurrent 
                    ? const Center(
                        child: Icon(Icons.circle, size: 6, color: Colors.white),
                      ) 
                    : null,
              ),
              Container(
                width: 1.5,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      accentColor,
                      (isDark ? Colors.white10 : Colors.black12),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          
          // Content Card
          Expanded(
            child: CyberPanel(
              cutSize: 0,
              isGlowEnabled: isCurrent,
              color: isCurrent ? AppColors.primary : (isDark ? Colors.white10 : Colors.black12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Decorative left accent bar inside the card itself
                  Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isCurrent ? AppColors.primary : Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.darkText : AppColors.lightText,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  Text(
                                    company,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CyberStatusBadge(
                              label: period,
                              color: isCurrent ? AppColors.primary : const Color(0xFF64748B),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          description,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                          ),
                        ),
                        if (certUrl.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          CyberButton(
                            cutSize: 0,
                            onPressed: () => _launchURL(certUrl),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified_outlined, size: 14, color: AppColors.primary),
                                const SizedBox(width: 6),
                                Text(
                                  "VIEW CERTIFICATE",
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
