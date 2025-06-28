import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.only(
        left: isWeb ? 100 : 25,
        right: isWeb ? 100 : 25,
        top: isWeb ? 100 : 100,
        bottom: isWeb ? 30 : 25,
      ),
      child: Column(
        children: [
          if (isWeb)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildContent(isWeb)),
                const SizedBox(width: 40),
                _buildFlutterImage(context),
              ],
            )
          else
            Column(
              children: [
                _buildFlutterImage(context),
                const SizedBox(height: 30),
                _buildContent(isWeb),
              ],
            ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }

  Widget _buildContent(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hi, I'm",
            style: TextStyle(color: Colors.white70, fontSize: 18)),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.blue.withOpacity(0.8)
            ],
          ).createShader(bounds),
          child: Text(
            "KURALARASU B",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.flutter,
              size: 24,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.8),
                  Colors.white,
                ],
              ).createShader(bounds),
              child: Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "I specialize in building high-performance mobile apps with beautiful UIs.",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 18,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => _launchURL(AppUrls.resume),
          icon: Icon(
            Icons.download,
            size: 20,
            color: Colors.white,
          ),
          label: Text(
            "Download CV",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlutterImage(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Container(
      width: isWeb ? 200 : 200, // Adjust width based on platform
      height: isWeb ? 250 : 250, // Adjust height based on platform
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/images/flutter_developer.png',
          // 'assets/images/flutter_dev.jpg',
          fit: BoxFit.cover, // This will properly fill the container
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            alignment: Alignment.center,
            child: const Icon(Icons.person, size: 100, color: Colors.white),
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
