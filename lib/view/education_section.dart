import 'package:flutter/material.dart';
import 'package:portfolio/utils/website_constraints.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});
  @override
  Widget build(BuildContext context) {
    final isWeb = WebsiteConstraints.isWeb(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 100 : 20, vertical: isWeb ? 10 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Education',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          _buildEducationTimeline(),
        ],
      ),
    );
  }

  Widget _buildEducationTimeline() {
    return Column(
      children: [
        _buildEducationItem(
          degree: 'B.Tech Computer and Communication Engineering ',
          institution: 'Sri Manakula Vinayagar Engineering College',
          year: '2021 - 2025',
          description: '\nCGPA: 6.60/10.0',
          icon: Icons.school,
        ),
        _buildDivider(),
        _buildEducationItem(
          degree: '12th Grade',
          institution: 'Srk International School',
          year: '2020 - 2021',
          description: 'Percentage: 81%\nBoard: CBSE',
          icon: Icons.school,
        ),
        _buildDivider(),
        _buildEducationItem(
          degree: '10th Grade',
          institution: 'Jawahar Higher Secondary School',
          year: '2018 - 2019',
          description: 'Percentage: 56%\nBoard: CBSE',
          icon: Icons.school,
        ),
      ],
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String institution,
    required String year,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.pinkAccent),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  institution,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  year,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      height: 1,
      indent: 70,
    );
  }
}
