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
          const SizedBox(height: 30),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWeb ? 4 : 2,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            childAspectRatio: 1,
            children: const [
              SkillItem(
                icon: FontAwesomeIcons.flutter,
                name: "Flutter",
                color: Colors.blue,
              ),
              SkillItem(
                icon: FontAwesomeIcons.dartLang,
                name: "Dart",
                color: Colors.blueAccent,
              ),
              SkillItem(
                icon: FontAwesomeIcons.mobile,
                name: "Mobile Dev",
                color: Colors.lightBlue,
              ),
              SkillItem(
                icon: Icons.data_array_rounded,
                name: "Provider",
                color: Colors.cyan,
              ),
              SkillItem(
                icon: FontAwesomeIcons.database,
                name: "Firebase",
                color: Colors.amber,
              ),
              SkillItem(
                icon: Icons.api_rounded,
                name: "REST APIs",
                color: Colors.green,
              ),
              SkillItem(
                icon: FontAwesomeIcons.java,
                name: "Java",
                color: Colors.orange,
              ),
              SkillItem(
                icon: FontAwesomeIcons.github,
                name: "Git",
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;

  const SkillItem({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900]?.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
