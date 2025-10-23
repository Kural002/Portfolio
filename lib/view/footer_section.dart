import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart'; // Add this import

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(24),
      color: isDarkMode
          ? Colors.black.withOpacity(0.7)
          : Colors.grey[100]!.withOpacity(0.9),
      child: Center(
        child: Column(
          children: [
            Text(
              "\u00a9 2025 Kuralarasu B",
              style: TextStyle(
                color: isDarkMode ? Colors.white54 : Colors.grey[700],
                fontFamily: GoogleFonts.montserratAlternates().fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.github,
                  AppUrls.github,
                  isDarkMode,
                ),
                const SizedBox(width: 16),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.linkedin,
                  AppUrls.linkedIn,
                  isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    String url,
    bool isDarkMode,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.03),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
            ),
          ),
          child: Icon(
            icon,
            color: isDarkMode ? Colors.white70 : Colors.grey[700],
            size: 20,
          ),
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
