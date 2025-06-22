import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onCertificationsTap;

  const CustomNavBar({
    super.key,
    this.onAboutTap,
    this.onProjectsTap,
    this.onCertificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 30,
          children: [
            _NavItem(title: 'About us', onTap: onAboutTap),
            _NavItem(title: 'Projects', onTap: onProjectsTap),
            _NavItem(title: 'Certifications', onTap: onCertificationsTap),
          ],
        ),
      ),
    );
  }
}
class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _NavItem({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}