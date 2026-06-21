import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/utils/cursor_provider.dart';

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
          // Elegant gradient divider
          Container(
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.0),
                  AppColors.primary.withOpacity(0.3),
                  AppColors.primary.withOpacity(0.0),
                ],
              ),
            ),
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
            style: GoogleFonts.inter(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            "\u00a9 2026 All Rights Reserved",
            style: GoogleFonts.spaceMono(
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
              fontSize: 11,
              letterSpacing: 0.3,
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
    final strokeColor = widget.isDark ? AppColors.primary : AppColors.primary.withOpacity(0.7);

    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) {
            setState(() => isHovered = true);
            cursorProvider.setHovering(true);
          },
          onExit: (_) {
            setState(() => isHovered = false);
            cursorProvider.setHovering(false);
          },
          child: GestureDetector(
            onTap: () {
              _launchURL(widget.url);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
              child: CyberPanel(
                cutSize: 0,
                isGlowEnabled: isHovered,
                borderWidth: isHovered ? 1.5 : 1.0,
                color: isHovered ? strokeColor : strokeColor.withOpacity(0.3),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  widget.icon,
                  color: isHovered ? AppColors.primary : (widget.isDark ? Colors.white60 : Colors.black54),
                  size: 18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
