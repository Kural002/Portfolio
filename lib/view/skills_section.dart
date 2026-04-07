import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ABILITIES",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Technical Skills",
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
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
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
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered 
                ? AppColors.primary.withOpacity(0.5) 
                : (widget.isDark ? Colors.white : Colors.black).withOpacity(0.05),
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered 
                  ? AppColors.primary.withOpacity(0.2) 
                  : Colors.black.withOpacity(0.02),
              blurRadius: isHovered ? 12 : 4,
              offset: Offset(0, isHovered ? 4 : 2),
            ),
          ],
        ),
        child: Text(
          widget.skill,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
            color: isHovered ? AppColors.primary : (widget.isDark ? AppColors.darkText : AppColors.lightText),
          ),
        ),
      ),
    );
  }
}