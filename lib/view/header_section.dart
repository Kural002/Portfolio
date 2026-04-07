import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
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
        vertical: isWeb ? 120 : 60,
      ),
      child: isWeb
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 3, child: _buildContent(context, isWeb, isDark)),
                const SizedBox(width: 60),
                Expanded(flex: 2, child: _buildHeroImage(context, isWeb, isDark)),
              ],
            )
          : Column(
              children: [
                _buildHeroImage(context, isWeb, isDark),
                const SizedBox(height: 50),
                _buildContent(context, isWeb, isDark),
              ],
            ),
    );
  }

  Widget _buildContent(BuildContext context, bool isWeb, bool isDark) {
    return Column(
      crossAxisAlignment: isWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "👋 Welcome to my portfolio",
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "I'm",
          style: GoogleFonts.montserrat(
            fontSize: isWeb ? 24 : 20,
            color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
          ),
        ),
        Text(
          "KURALARASU B",
          textAlign: isWeb ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: isWeb ? 72 : 40,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            height: 1.1,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: isWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FontAwesomeIcons.flutter, color: AppColors.primary, size: 24),
            const SizedBox(width: 12),
            Text(
              "Full-Stack Flutter Developer",
              style: GoogleFonts.poppins(
                fontSize: isWeb ? 28 : 20,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: isWeb ? 500 : double.infinity,
          child: Text(
            "Architecting seamless digital experiences with Flutter. I transform complex ideas into high-performance, beautiful mobile and web applications.",
            textAlign: isWeb ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              height: 1.6,
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isWeb ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _buildPrimaryButton("Download CV", Icons.download_rounded, () => _launchURL(AppUrls.resume)),
            _buildSecondaryButton("Get in Touch", Icons.mail_outline_rounded, onGetInTouch),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, bool isWeb, bool isDark) {
    final size = isWeb ? 450.0 : 320.0;
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Glow Background
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
            // Layer 1: Glassmorphic Background Card (Slightly Rotated)
            Transform.rotate(
              angle: 0.1,
              child: Container(
                width: size * 0.75,
                height: size * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(isWeb ? 80 : 60),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Layer 2: Image Container with Gradient Border
            Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isWeb ? 80 : 60),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0), // The gradient border width
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBg : AppColors.lightBg,
                    borderRadius: BorderRadius.circular(isWeb ? 76 : 56),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isWeb ? 76 : 56),
                    child: Image.asset(
                      'assets/images/flutter_developer.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                        child: const Icon(Icons.person_rounded, size: 120, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: Colors.black),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    );
  }

  Widget _buildSecondaryButton(String label, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: const BorderSide(color: AppColors.primary, width: 2),
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