import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatelessWidget {
  final Function scrollToSection;
  
  const HeaderSection({super.key, required this.scrollToSection});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.only(
        left: isWeb ? 100 : 25,
        right: isWeb ? 100 : 25,
        top: isWeb ? 80 : 50, 
        bottom: isWeb ? 30 : 25,
      ),
      child: Column(
        children: [
      
            Align(
              alignment: Alignment.topLeft,
              child: Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    size: 26,
                  ),
                ),
              ),
            ),
          
 
          const SizedBox(height: 20),
          
          if (isWeb)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildContent(isWeb, context)),
                const SizedBox(width: 40),
                _buildFlutterImage(context),
              ],
            )
          else
            Column(
              children: [
                _buildFlutterImage(context),
                const SizedBox(height: 30),
                _buildContent(isWeb, context),
              ],
            ),
              
          SizedBox(height: isWeb ? 40 : 50),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.blueAccent.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isWeb, BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hi, I'm",
            style: TextStyle(color: textColor?.withOpacity(0.7), fontSize: 18)),
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
            style: GoogleFonts.montserrat(
              color: textColor,
              fontSize: 42,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(FontAwesomeIcons.flutter, size: 24, color: Colors.blue),
            const SizedBox(width: 10),
            Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "I specialize in building high-performance mobile apps with beautiful UIs.",
          style: TextStyle(
            color: textColor?.withOpacity(0.7),
            fontSize: 18,
          ),
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
          icon: const Icon(Icons.download, size: 20, color: Colors.white),
          label: const Text(
            "Download CV",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlutterImage(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    return Container(
      width: isWeb ? 200 : 200,
      height: isWeb ? 250 : 250,
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
          fit: BoxFit.cover,
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