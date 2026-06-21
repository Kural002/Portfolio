import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final certs = [
      {
        "title": "Flutter Developer Role Selection",
        "provider": "Internshala",
        "url": AppUrls.internshala,
      },
      {
        "title": "Flutter & Dart Bootcamp",
        "provider": "Udemy",
        "url": AppUrls.udemy,
      },
      {
        "title": "Flutter Developer",
        "provider": "GUVI",
        "url": AppUrls.guvi,
      },
      {
        "title": "Flutter Bootcamp",
        "provider": "LetsUpgrade",
        "url": AppUrls.letsUpgrade,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: certs.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: isWeb ? 400 : 500,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: isWeb ? 100 : 90,
            ),
            itemBuilder: (context, index) {
              final c = certs[index];
              return _CertCard(
                title: c["title"] as String,
                provider: c["provider"] as String,
                url: c["url"] as String,
                isDark: isDark,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return CreativeSectionHeader(
      number: "06",
      category: "Credentials",
      title: "Certifications",
      isDark: isDark,
    );
  }
}

class _CertCard extends StatefulWidget {
  final String title;
  final String provider;
  final String url;
  final bool isDark;

  const _CertCard({
    required this.title,
    required this.provider,
    required this.url,
    required this.isDark,
  });

  @override
  State<_CertCard> createState() => _CertCardState();
}

class _CertCardState extends State<_CertCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final strokeColor = widget.isDark ? AppColors.primary : AppColors.primary.withOpacity(0.7);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(isHovered ? 1.03 : 1.0),
        child: CyberPanel(
          cutSize: 0,
          isGlowEnabled: isHovered,
          borderWidth: isHovered ? 1.5 : 1.0,
          color: isHovered ? strokeColor : strokeColor.withOpacity(0.2),
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () => _launchURL(widget.url),
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.verified_rounded, color: AppColors.primary, size: 18),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.provider,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward_rounded,
                    size: 16,
                    color: isHovered ? AppColors.primary : (widget.isDark ? Colors.white30 : Colors.black26),
                  ),
                ],
              ),
            ),
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
