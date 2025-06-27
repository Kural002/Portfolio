import 'package:flutter/material.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInImage;
  late Animation<double> _fadeInText;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeInImage = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _fadeInText = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isWeb ? 80 : 60,
        horizontal: isWeb ? 20 : 24,
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
                FadeTransition(opacity: _fadeInImage, child: _buildFlutterImage()),
              ],
            )
          else
            Column(
              children: [
                FadeTransition(opacity: _fadeInImage, child: _buildFlutterImage()),
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
    return AnimatedBuilder(
      animation: _fadeInText,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInText.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hi, I'm",
                  style: TextStyle(color: Colors.white70, fontSize: 18)),
              const SizedBox(height: 8),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.pinkAccent, Colors.purpleAccent],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  "KURALARASU B",
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "Flutter ",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    TextSpan(
                        text: "Developer",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "I specialize in building high-performance mobile apps with beautiful UIs.",
                style: TextStyle(color: Colors.white60, fontSize: 18),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => _launchURL(AppUrls.resume),
                icon: const Icon(Icons.download, size: 20),
                label:
                    const Text("Download CV", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlutterImage() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.pinkAccent.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
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
