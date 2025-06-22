import 'package:flutter/material.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final url = WebsiteConstraints().resume;
  void _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // For web compatibility
        );
      } else {
        debugPrint("❌ Could not launch $url");
      }
    } catch (e) {
      debugPrint("❌ Error launching $url: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768; // Define this once for clarity

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  // Mobile layout
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _rightImageSection(),
                    const SizedBox(height: 30),
                    _leftTextSection(isMobile: true),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      // Desktop layout
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5, // Give more space to text section
                          child: _leftTextSection(isMobile: false),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4, // Less space for image
                          child: _rightImageSection(),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _leftTextSection({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "KURALARASU B",
          style: TextStyle(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Flutter ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Developer',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I specialize in building high-performance mobile apps with beautiful UI. "
          "From concept to deployment, I handle everything smoothly.",
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            _launchURL(url);
          },
          icon: const Icon(Icons.download, size: 18),
          label: const Text("Download CV"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rightImageSection() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.pinkAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/avatar.png', // Make sure this path is correct
            height: 250,
            width: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              width: 250,
              color: Colors.grey[800],
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
