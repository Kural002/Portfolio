import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/website_constraints.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 20,
        vertical: isWeb ? 0 : 6,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Education',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isWeb ? 30 : 10),
                Expanded(
                  child: Divider(
                    color: Colors.blueAccent,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildEducationTimeline(isWeb: isWeb),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationTimeline({required bool isWeb}) {
    return Column(
      children: [
        _buildEducationItem(
          degree: 'B.Tech Computer and Communication Engineering',
          institution: 'Sri Manakula Vinayagar Engineering College',
          year: '2021 - 2025',
          description: 'CGPA: 6.76/10.0',
          icon: Icons.school_rounded,
          isHighlighted: true,
          isWeb: isWeb,
        ),
        _buildDivider(isWeb: isWeb),
        _buildEducationItem(
          degree: '12th Grade - Computer Science ',
          institution: 'Srk International School',
          year: '2020 - 2021',
          description: 'Percentage: 81% | CBSE Board',
          icon: Icons.school_rounded,
          isWeb: isWeb,
        ),
        SizedBox(height: 30),
        const Divider(color: Colors.white24, height: 1),
      ],
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String institution,
    required String year,
    required String description,
    required IconData icon,
    bool isHighlighted = false,
    required bool isWeb,
  }) {
    if (isWeb) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isHighlighted
                    ? Colors.blueAccent.withOpacity(0.4)
                    : Colors.blueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isHighlighted ? Colors.white : Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              degree,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              institution,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: Colors.blueAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  year,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isHighlighted
              ? Colors.blueAccent.withOpacity(0.2)
              : Colors.grey[900]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: isHighlighted
                      ? Colors.blueAccent.withOpacity(0.9)
                      : Colors.blueAccent.withOpacity(0.2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                icon,
                color: isHighlighted ? Colors.white : Colors.blueAccent,
                size: 28,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    degree,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    institution,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 16,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        year,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDivider({required bool isWeb}) {
    return Divider(
      color: Colors.grey[800],
      height: 20,
      indent: isWeb ? 84 : 0,
      endIndent: isWeb ? 20 : 0,
    );
  }
}
