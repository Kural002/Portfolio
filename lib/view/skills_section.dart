import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/website_constraints.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: isWeb ? 10 : 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          // const SizedBox(height: 5),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWeb ? 4 : 2,
            mainAxisSpacing: isWeb ? 50 : 20,
            crossAxisSpacing: isWeb ? 50 : 20,
            childAspectRatio: isWeb ? 2 : 1.2,
          
            children: const [
              SkillItem(
                icon: FontAwesomeIcons.flutter,
                name: "Flutter",
                level: 75,
              ),
              SkillItem(
                icon: FontAwesomeIcons.dartLang,
                name: "Dart",
                level: 75,
              ),
              SkillItem(
                icon: FontAwesomeIcons.mobile,
                name: "Mobile Dev",
                level: 50,
              ),
              SkillItem(
                icon: Icons.data_array_rounded,
                name: "Provider",
                level: 60,
              ),
              SkillItem(
                icon: FontAwesomeIcons.database,
                name: "Firebase",
                level: 70,
              ),
              SkillItem(
                icon: Icons.api_rounded,
                name: "REST APIs",
                level: 45,
              ),
              SkillItem(
                icon: FontAwesomeIcons.java,
                name: "Java",
                level: 40,
              ),
              SkillItem(
                icon: FontAwesomeIcons.github,
                name: "Git",
                level: 70,
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
  final int level;

  const SkillItem({
    super.key,
    required this.icon,
    required this.name,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 40),
          const SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          isWeb
              ? LinearProgressIndicator(
                  value: level / 100,
                  backgroundColor: Colors.grey[800],
                  color: Colors.blueAccent,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                )
              : Expanded(
                  child: LinearProgressIndicator(
                    value: level / 100,
                    backgroundColor: Colors.grey[800],
                    color: Colors.blueAccent,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
          const SizedBox(height: 8),
          Text("$level%", style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
