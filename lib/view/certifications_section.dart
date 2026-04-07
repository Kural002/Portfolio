import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: isWeb ? 400 : 500,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: isWeb ? 100 : 90,
            ),
            itemBuilder: (context, index) {
              final certs = [
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CREDENTIALS",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Certifications",
          style: GoogleFonts.montserrat(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
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
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered 
                ? AppColors.primary.withOpacity(0.5) 
                : (widget.isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
            width: 2,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: InkWell(
          onTap: () => _launchURL(widget.url),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.verified_rounded, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.montserrat(
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
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 16,
                  color: isHovered ? AppColors.primary : (widget.isDark ? Colors.white24 : Colors.black12),
                ),
              ],
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
