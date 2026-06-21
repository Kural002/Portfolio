import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/view/components/cyber_panel.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
          _buildSkillsContent(isWeb, isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return CreativeSectionHeader(
      number: "04",
      category: "Abilities",
      title: "Technical Skills",
      isDark: isDark,
    );
  }

  Widget _buildSkillsContent(bool isWeb, bool isDark) {
    final categories = [
      {
        "title": "Languages",
        "skills": ["Dart", "JavaScript", "Java"],
      },
      {
        "title": "Frameworks",
        "skills": ["Flutter", "Node.js", "Express"],
      },
      {
        "title": "Storage & Databases",
        "skills": ["Firebase", "Hive", "Shared Preferences"],
      },
      {
        "title": "Tools & AI",
        "skills": ["Git", "Antigravity", "OpenClaw", "Cursor AI"],
      },
    ];

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 40,
        runSpacing: 40,
        children: categories
            .map((cat) => _buildSkillGroup(
                cat["title"] as String, (cat["skills"] as List).cast<String>(), isWeb, isDark))
            .toList(),
      ),
    );
  }

  Widget _buildSkillGroup(String title, List<String> skills, bool isWeb, bool isDark) {
    return SizedBox(
      width: isWeb ? 300 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) => _buildSkillChip(skill, isDark)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, bool isDark) {
    return _InteractiveSkillChip(skill: skill, isDark: isDark);
  }
}

class _InteractiveSkillChip extends StatefulWidget {
  final String skill;
  final bool isDark;
  
  const _InteractiveSkillChip({required this.skill, required this.isDark});

  @override
  State<_InteractiveSkillChip> createState() => _InteractiveSkillChipState();
}

class _InteractiveSkillChipState extends State<_InteractiveSkillChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(isHovered ? 1.04 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered 
                  ? AppColors.primary.withOpacity(0.5) 
                  : (isDark ? AppColors.primary.withOpacity(0.1) : AppColors.primary.withOpacity(0.22)),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered 
                    ? AppColors.primary.withOpacity(0.12) 
                    : Colors.black.withOpacity(0.02),
                blurRadius: isHovered ? 10 : 4,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isHovered ? AppColors.primary : Colors.grey.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.skill,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isHovered ? FontWeight.w700 : FontWeight.w500,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}