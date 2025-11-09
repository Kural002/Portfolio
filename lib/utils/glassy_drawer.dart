import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/utils/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GlassyDrawer extends StatelessWidget {
  final ThemeProvider themeProvider;
  final void Function(GlobalKey) scrollToSection;

  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey educationKey;
  final GlobalKey certificationsKey;

  const GlassyDrawer({
    super.key,
    required this.themeProvider,
    required this.scrollToSection,
    required this.aboutKey,
    required this.experienceKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.educationKey,
    required this.certificationsKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeProvider.isDarkMode
                  ? [
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.03),
                      Colors.transparent,
                    ]
                  : [
                      Colors.blueGrey.withOpacity(0.15),
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
            ),
            border: Border.all(
              color: themeProvider.isDarkMode
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.2),
              width: 1.1,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: themeProvider.isDarkMode
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(context),
              _buildDrawerItem(context, Icons.person, "About", () {
                Navigator.pop(context);
                scrollToSection(aboutKey);
              }),
              _buildDrawerItem(context, Icons.work, "Experience", () {
                Navigator.pop(context);
                scrollToSection(experienceKey);
              }),
              _buildDrawerItem(context, Icons.code, "Skills", () {
                Navigator.pop(context);
                scrollToSection(skillsKey);
              }),
              _buildDrawerItem(context, Icons.assignment, "Projects", () {
                Navigator.pop(context);
                scrollToSection(projectsKey);
              }),
              _buildDrawerItem(context, Icons.school, "Education", () {
                Navigator.pop(context);
                scrollToSection(educationKey);
              }),
              _buildDrawerItem(context, Icons.card_membership, "Certifications",
                  () {
                Navigator.pop(context);
                scrollToSection(certificationsKey);
              }),
              Divider(
                color: themeProvider.isDarkMode
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.2),
              ),
              _buildDrawerItem(
                  context, Icons.cloud_outlined, "Live Weather App", () async {
                final Uri url = Uri.parse(AppUrls.weatherAppDeployed);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  await launchUrl(url, mode: LaunchMode.inAppWebView);
                }
              }),
              _buildDrawerItem(context, FontAwesomeIcons.heart, "BetterME App",
                  () async {
                final Uri url = Uri.parse(AppUrls.BetterMEAPK);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  await launchUrl(url, mode: LaunchMode.inAppWebView);
                }
              }),
              _buildDrawerItem(
                  context, Icons.attach_money, "Expense tracker APK", () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Coming Soon'),
                      content: const Text(
                          'The APK for this app will be available soon.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }),

              //     () async {
              //   // final Uri url = Uri.parse();
              //   // if (await canLaunchUrl(url)) {
              //   //   await launchUrl(url, mode: LaunchMode.externalApplication);
              //   // } else {
              //   //   ScaffoldMessenger.of(context).showSnackBar(
              //   //     const SnackBar(content: Text("Could not open the link")),
              //   //   );
              //   // }
              // }),
              _buildDrawerItem(context, Icons.catching_pokemon, "PokeDex APK",
                  () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Coming Soon'),
                      content: const Text(
                          'The APK for this app will be available soon.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }),
              //     () async {
              //   // final Uri url = Uri.parse();
              //   // if (await canLaunchUrl(url)) {
              //   //   await launchUrl(url, mode: LaunchMode.externalApplication);
              //   // } else {
              //   //   ScaffoldMessenger.of(context).showSnackBar(
              //   //     const SnackBar(content: Text("Could not open the link")),
              //   //   );
              //   // }
              // }),
              Divider(
                color: themeProvider.isDarkMode
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.2),
              ),
              _buildThemeToggle(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
              color: themeProvider.isDarkMode ? Colors.white30 : Colors.black26,
              width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[100],
            child: Icon(FontAwesomeIcons.flutter, size: 40, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          const Text(
            "KURALARASU B",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Flutter Developer",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[200]),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return ListTile(
      leading: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Colors.white,
      ),
      title: Text(
        themeProvider.isDarkMode ? "Light Mode" : "Dark Mode",
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Switch(
        value: themeProvider.isDarkMode,
        onChanged: (value) => themeProvider.toggleTheme(),
        activeColor: Colors.blueAccent,
      ),
    );
  }
}
