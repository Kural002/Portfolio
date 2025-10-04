import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/website_constraints.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Skills",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isWeb ? 30 : 10),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            children: const [
              SkillChip(
                icon: FontAwesomeIcons.flutter,
                name: "Flutter",
                color: Colors.blue,
              ),
              SkillChip(
                icon: FontAwesomeIcons.dartLang,
                name: "Dart",
                color: Colors.blueAccent,
              ),
              SkillChip(
                icon: FontAwesomeIcons.mobile,
                name: "Mobile Dev",
                color: Colors.lightBlue,
              ),
              SkillChip(
                icon: Icons.data_array_rounded,
                name: "Provider",
                color: Colors.cyan,
              ),
              SkillChip(
                icon: FontAwesomeIcons.database,
                name: "Firebase",
                color: Colors.amber,
              ),
              SkillChip(
                icon: Icons.api_rounded,
                name: "REST APIs",
                color: Colors.green,
              ),
              SkillChip(
                icon: FontAwesomeIcons.java,
                name: "Java",
                color: Colors.orange,
              ),
              SkillChip(
                icon: FontAwesomeIcons.github,
                name: "Git",
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;

  const SkillChip({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[900]?.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
