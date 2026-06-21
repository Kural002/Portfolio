import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/view/components/cyber_panel.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
          _EducationTimeline(isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return CreativeSectionHeader(
      number: "05",
      category: "Academics",
      title: "Education",
      isDark: isDark,
    );
  }
}

class _EducationTimeline extends StatelessWidget {
  final bool isDark;

  const _EducationTimeline({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final education = [
      {
        "degree": "B.Tech Computer and Communication Engineering",
        "institution": "Sri Manakula Vinayagar Engineering College",
        "period": "2021 - 2025",
        "result": "CGPA: 6.76/10.0",
        "isHighlighted": true,
      },
      {
        "degree": "12th Grade - Computer Science",
        "institution": "Srk International School",
        "period": "2020 - 2021",
        "result": "Percentage: 81% (CBSE)",
        "isHighlighted": false,
      },
    ];

    return Column(
      children: education.map((edu) {
        return _EducationCard(
          degree: edu["degree"] as String,
          institution: edu["institution"] as String,
          period: edu["period"] as String,
          result: edu["result"] as String,
          isDark: isDark,
          isHighlighted: edu["isHighlighted"] as bool,
        );
      }).toList(),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final String degree;
  final String institution;
  final String period;
  final String result;
  final bool isDark;
  final bool isHighlighted;

  const _EducationCard({
    required this.degree,
    required this.institution,
    required this.period,
    required this.result,
    required this.isDark,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isHighlighted ? AppColors.primary : (isDark ? Colors.white30 : Colors.black26);

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
                  color: isHighlighted ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isHighlighted ? AppColors.primary : (isDark ? Colors.white30 : Colors.black26),
                    width: 2.5,
                  ),
                  boxShadow: isHighlighted ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ] : [],
                ),
                child: isHighlighted 
                    ? const Center(
                        child: Icon(Icons.circle, size: 6, color: Colors.white),
                      ) 
                    : null,
              ),
              Container(
                width: 1.5,
                height: 130,
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
              isGlowEnabled: isHighlighted,
              color: isHighlighted ? AppColors.primary : (isDark ? Colors.white10 : Colors.black12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Accent bar block
                  Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isHighlighted ? AppColors.primary : Colors.grey.withOpacity(0.3),
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
                                    degree,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.darkText : AppColors.lightText,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  Text(
                                    institution,
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
                              color: isHighlighted ? AppColors.primary : const Color(0xFF64748B),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Score Panel
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.grade_rounded, size: 14, color: AppColors.primary),
                              const SizedBox(width: 6),
                              Text(
                                result,
                                style: GoogleFonts.spaceMono(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}