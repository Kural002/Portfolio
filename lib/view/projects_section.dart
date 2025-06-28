import 'package:flutter/material.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    final crossAxisCount = isWeb ? 4 : 2;
    final childAspectRatio = isWeb ? 1.1 : 0.9;

    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal:isWeb ? 100 : 16,
        vertical: isWeb ? 10 : 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Projects",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: childAspectRatio,
            children: [
              _buildProjectCard(
                "Expense Tracker",
                Icons.account_balance_wallet,
                AppUrls.expenseTracker,
              ),
              _buildProjectCard(
                "Pokedex",
                Icons.catching_pokemon,
                AppUrls.pokedex,
              ),
              _buildProjectCard(
                "Portfolio Website",
                Icons.web,
                AppUrls.portfolio,
              ),
              _buildProjectCard(
                "Weather App",
                Icons.cloud,
                AppUrls.weatherApp,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900]?.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.pinkAccent, size: 28),
                ),
                const SizedBox(height: 16),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _launchURL(url),
                  child: const Text("View Project"),
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
