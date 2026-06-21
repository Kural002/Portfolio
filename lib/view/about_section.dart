import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
import 'package:provider/provider.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 950;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 100 : 25,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 50),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildAboutText(isDark)),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: _buildBentoGrid(isDark, true)),
              ],
            )
          else
            Column(
              children: [
                _buildAboutText(isDark),
                const SizedBox(height: 30),
                _buildBentoGrid(isDark, false),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return CreativeSectionHeader(
      number: "01",
      category: "Introduction",
      title: "About Me",
      isDark: isDark,
    );
  }

  Widget _buildAboutText(bool isDark) {
    final style = GoogleFonts.inter(
      fontSize: 16,
      height: 1.7,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
    );

    return CyberPanel(
      cutSize: 0,
      isGlowEnabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "MY STORY",
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "I am a focused Flutter Developer with a strong foundation in building cross-platform applications during my internships at various startups. I specialize in transforming product requirements into fluid, high-performance mobile experiences.",
            style: style,
          ),
          const SizedBox(height: 16),
          Text(
            "With practical experience in startup environments, I have mastered state management (Provider), Firebase integration, and modern UI/UX principles, ensuring every application I build is scalable and user-centric.",
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildBentoGrid(bool isDark, bool isWeb) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildBentoCard(
              "9", 
              "Months Exp", 
              Icons.timeline_rounded, 
              isDark,
              child: const _HoverWave(),
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildBentoCard(
              "15+", 
              "Projects", 
              Icons.rocket_launch_rounded, 
              isDark,
              child: _buildProjectMiniChart(),
            )),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildBentoCard(
              "10+", 
              "Tools", 
              Icons.build_circle_outlined, 
              isDark,
              child: _buildToolAvatars(isDark),
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildBentoCard(
              "5+", 
              "Certs", 
              Icons.verified_user_outlined, 
              isDark,
              child: const _HoverGauge(),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoCard(String val, String label, IconData icon, bool isDark, {required Widget child}) {
    return CyberPanel(
      cutSize: 0,
      padding: const EdgeInsets.all(16),
      drawTechMarks: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              Text(
                val,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Center(child: child),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectMiniChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildMiniBar(12),
        _buildMiniBar(18),
        _buildMiniBar(28),
        _buildMiniBar(15),
        _buildMiniBar(36),
      ],
    );
  }

  Widget _buildMiniBar(double height) {
    return Container(
      width: 6,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildToolAvatars(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _HoverToolBadge(text: "FL", isDark: isDark),
        const SizedBox(width: 4),
        _HoverToolBadge(text: "FB", isDark: isDark),
        const SizedBox(width: 4),
        _HoverToolBadge(text: "JS", isDark: isDark),
      ],
    );
  }
}

class _HoverToolBadge extends StatefulWidget {
  final String text;
  final bool isDark;
  const _HoverToolBadge({required this.text, required this.isDark});

  @override
  State<_HoverToolBadge> createState() => _HoverToolBadgeState();
}

class _HoverToolBadgeState extends State<_HoverToolBadge> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        cursorProvider.setHovering(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        cursorProvider.setHovering(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isHovered 
              ? AppColors.primary.withOpacity(0.15) 
              : AppColors.primary.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: isHovered 
                ? AppColors.primary 
                : AppColors.primary.withOpacity(0.2),
          ),
          boxShadow: isHovered 
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.spaceMono(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _HoverGauge extends StatefulWidget {
  const _HoverGauge();

  @override
  State<_HoverGauge> createState() => _HoverGaugeState();
}

class _HoverGaugeState extends State<_HoverGauge> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        cursorProvider.setHovering(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        cursorProvider.setHovering(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.15 : 1.0),
        child: Tooltip(
          message: "85% Completed",
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 3.5,
                  backgroundColor: AppColors.primary.withOpacity(0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isHovered ? AppColors.accent : AppColors.primary,
                  ),
                ),
              ),
              if (isHovered)
                Text(
                  "85",
                  style: GoogleFonts.spaceMono(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverWave extends StatefulWidget {
  const _HoverWave();

  @override
  State<_HoverWave> createState() => _HoverWaveState();
}

class _HoverWaveState extends State<_HoverWave> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context, listen: false);
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        cursorProvider.setHovering(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        cursorProvider.setHovering(false);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isHovered ? 0.15 : 1.0,
            child: CustomPaint(
              size: const Size(double.infinity, 30),
              painter: _WavePainter(color: AppColors.primary),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isHovered ? 1.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Nov 2024 - May 2025: Intern @ GUVI",
                style: GoogleFonts.spaceMono(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;
  _WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.1, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
