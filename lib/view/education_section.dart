import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ACADEMICS",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Education",
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
                  color: isHighlighted ? AppColors.primary : (isDark ? Colors.white24 : Colors.black12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(isHighlighted ? 0.3 : 0),
                    width: 4,
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 120,
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
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
                  color: isHighlighted 
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
                              degree,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              institution,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
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
                          color: (isHighlighted ? AppColors.primary : (isDark ? Colors.white : Colors.black)).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          period,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isHighlighted ? AppColors.primary : (isDark ? AppColors.darkTextDim : AppColors.lightTextDim),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                    ),
                    child: Text(
                      result,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
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