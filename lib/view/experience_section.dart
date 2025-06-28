import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            'Experience',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
          const SizedBox(height: 30),
          ..._buildExperienceItems(isWeb),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }

  List<Widget> _buildExperienceItems(bool isWeb) {
    return [
      _buildExperienceCard(
        company: 'Yellow Boards Pvt Ltd',
        role: 'Flutter Developer',
        period: 'Jan 2025 - May 2025',
        description:
            'Developed and maintained cross-platform mobile applications using Flutter. Collaborated with UI/UX designers to implement pixel-perfect interfaces.',
        isWeb: isWeb,
        certificateUrl: AppUrls.yellowBoards,
      ),
      const SizedBox(height: 20),
      _buildExperienceCard(
        company: 'Elewaytech Pvt Ltd',
        role: 'Mobile Application Developer',
        period: 'Dec 2023 - Feb 2024',
        description:
            'Worked on bug fixes and performance improvements for existing applications. Participated in code reviews and team meetings.',
        isWeb: isWeb,
        certificateUrl: AppUrls.elewayte,
      ),
    ];
  }

  Widget _buildExperienceCard({
    required String company,
    required String role,
    required String period,
    required String description,
    required bool isWeb,
    required String certificateUrl,
  }) {
    return Container(
      width: isWeb ? double.infinity : null,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 20 : 12,
        vertical: isWeb ? 20 : 15,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          // const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              icon: const Icon(
                Icons.verified,
                color: Colors.blueAccent,
                size: 16,
              ),
              label: Text(
                'View Certificate',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              onPressed: () => _launchCertificateUrl(certificateUrl),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchCertificateUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
