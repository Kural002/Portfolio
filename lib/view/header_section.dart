import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatelessWidget {
  final Function(GlobalKey) scrollToSection;
  final VoidCallback onGetInTouch;
  
  const HeaderSection({
    super.key, 
    required this.scrollToSection,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: isWeb ? 100 : 50,
      ),
      child: isWeb
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 3, child: _buildContent(context, isWeb, isDark)),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _buildHeroImage(context, isWeb, isDark)),
              ],
            )
          : Column(
              children: [
                _buildHeroImage(context, isWeb, isDark),
                const SizedBox(height: 40),
                _buildContent(context, isWeb, isDark),
              ],
            ),
    );
  }

  Widget _buildContent(BuildContext context, bool isWeb, bool isDark) {
    final titleStyle = GoogleFonts.playfairDisplay(
      fontSize: isWeb ? 58 : 36,
      fontWeight: FontWeight.w900,
      letterSpacing: -1,
      height: 1.1,
      color: isDark ? Colors.white : AppColors.lightText,
    );

    return Column(
      crossAxisAlignment: isWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Availability badge
        const CyberStatusBadge(
          label: "AVAILABLE FOR PROJECTS",
          color: Color(0xFF10B981), // Emerald green
        ),
        const SizedBox(height: 24),
        
        Text(
          "Hello, I'm",
          style: GoogleFonts.inter(
            fontSize: isWeb ? 18 : 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
          ),
        ),
        const SizedBox(height: 8),
        GlowText(
          text: "KURALARASU B",
          style: titleStyle,
          glowColor: AppColors.primary,
          glowRadius: 10,
          textAlign: isWeb ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 16),
        
        Row(
          mainAxisAlignment: isWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.flutter, 
              color: AppColors.primary, 
              size: isWeb ? 22 : 18,
            ),
            const SizedBox(width: 12),
            Text(
              "Full-Stack Flutter Developer",
              style: GoogleFonts.playfairDisplay(
                fontSize: isWeb ? 22 : 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        SizedBox(
          width: isWeb ? 520 : double.infinity,
          child: Text(
            "Architecting seamless digital experiences with Flutter. I transform complex ideas into high-performance, beautiful mobile and web applications.",
            textAlign: isWeb ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17,
              height: 1.6,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
            ),
          ),
        ),
        const SizedBox(height: 35),
        
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isWeb ? WrapAlignment.start : WrapAlignment.center,
          children: [
            CyberButton(
              filled: true,
              onPressed: () => _launchURL(AppUrls.resume),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_rounded, size: 18, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "DOWNLOAD CV",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            CyberButton(
              filled: false,
              onPressed: onGetInTouch,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mail_outline_rounded, 
                    size: 18, 
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "GET IN TOUCH",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, bool isWeb, bool isDark) {
    final width = isWeb ? 310.0 : 240.0;
    final height = isWeb ? 410.0 : 310.0;
    return Center(
      child: RotatingHologramRing(
        width: width,
        height: height,
        color: AppColors.primary,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.12),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/flutter_developer.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  child: Icon(
                    Icons.person_rounded, 
                    size: isWeb ? 100 : 70, 
                    color: AppColors.primary,
                  ),
                ),
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