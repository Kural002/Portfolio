import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
      child: Column(
        children: [
          Container(
            height: 1,
            width: double.infinity,
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.github, AppUrls.github, isDark),
              const SizedBox(width: 24),
              _buildSocialIcon(FontAwesomeIcons.linkedin, AppUrls.linkedIn, isDark),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "Designed & Built by Kuralarasu B",
            style: GoogleFonts.poppins(
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\u00a9 2025 All Rights Reserved",
            style: GoogleFonts.poppins(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url, bool isDark) {
    return _SocialIcon(icon: icon, url: url, isDark: isDark);
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final bool isDark;

  const _SocialIcon({required this.icon, required this.url, required this.isDark});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHovered 
                ? AppColors.primary.withOpacity(0.1) 
                : (widget.isDark ? Colors.white : Colors.black).withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: isHovered 
                  ? AppColors.primary.withOpacity(0.5) 
                  : (widget.isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
          ),
          child: Icon(
            widget.icon,
            color: isHovered ? AppColors.primary : (widget.isDark ? Colors.white60 : Colors.black54),
            size: 20,
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
