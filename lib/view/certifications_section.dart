import 'package:flutter/material.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isWeb = WebsiteConstraints.isWeb(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 24,
        vertical: isWeb ? 10 : 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Certifications",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              children: [
                _buildCertificationItem(
                  "Flutter & Dart Bootcamp",
                  AppUrls.udemy,
                ),
                const Divider(color: Colors.white24, height: 30),
                _buildCertificationItem(
                  "Flutter Developer",
                  AppUrls.guvi,
                ),
                const Divider(color: Colors.white24, height: 30),
                _buildCertificationItem(
                  "Mobile Application Development",
                  AppUrls.elewayte,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCertificationItem(String title, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Row(
          children: [
            Icon(Icons.verified, color: Colors.pinkAccent),
            const SizedBox(width: 16),
            Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const Spacer(),
            Icon(Icons.open_in_new, color: Colors.white54, size: 18),
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
