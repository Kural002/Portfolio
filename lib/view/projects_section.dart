import 'package:flutter/material.dart';
import 'package:portfolio/model/project_model.dart';
import 'package:portfolio/utils/website_constraints.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  final List<ProjectModel> projects;
  final Key? key;

  const ProjectsSection({
    required this.projects,
    required this.key,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  void _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
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
    final projects = [
      {
        'title': 'Epension Tracker',
        'url': WebsiteConstraints().expense_tracker,
        'image': 'assets/expense/expense1.jpg',
      },
      {
        'title': 'Pokedex',
        'url': WebsiteConstraints().pokedex,
        'image': 'assets/expense/expense2.jpg',
      },
      {
        'title': 'Portfolio Flutter Website',
        'url': WebsiteConstraints().pokedex,
        'image': 'assets/expense/expense3.jpg',
      },
      {
        'title': 'Weather App',
        'url': WebsiteConstraints().weather,
        'image': 'assets/expense/expense4.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Projects",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: projects.map((project) {
                return GestureDetector(
                  onTap: () => _launchURL(project['url']!),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 600
                        ? double.infinity
                        : 250,
                    child: Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              project['image']!, // <- dynamic local image
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 250,
                                width: 250,
                                color: Colors.grey[800],
                                child: const Icon(Icons.broken_image,
                                    size: 60, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  project['title']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => _launchURL(project['url']!),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  child: const Text("View Project"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
