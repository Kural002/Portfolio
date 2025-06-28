import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/website_constraints.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: isWeb ? 15 : 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Text(
              "I’m a passionate Flutter developer with hands-on experience building responsive, cross-platform apps.skilled in Firebase, REST APIs, and state management using Provider.\nI turn ideas into clean, user-friendly mobile and web applications with performance in mind.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.6,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }
}
