import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          children: [
            Text(
              "\u00a9 2025 Kuralarasu B",
              style: TextStyle(
                color: Colors.white54,
                fontFamily: GoogleFonts.montserratAlternates().fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.white70,
                    size: 25,
                  ),
                  onPressed: () => _launchUrl(AppUrls.github),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Colors.white70,
                    size: 25,
                  ),
                  onPressed: () => _launchUrl(AppUrls.linkedIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
