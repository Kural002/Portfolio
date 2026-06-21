import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/app_urls.dart';
import 'package:portfolio/view/components/cyber_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:portfolio/view/components/project_case_study.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWeb = width > 1000;
    final isTablet = width > 600 && width <= 1000;
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWeb ? 3 : (isTablet ? 2 : 1),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isWeb ? 1.25 : (isTablet ? 1.2 : 1.15),
            ),
            itemBuilder: (context, index) {
              final projects = [
                {
                  "title": "Expense Tracker",
                  "desc": "Full-stack finance management with real-time sync.",
                  "icon": FontAwesomeIcons.wallet,
                  "url": AppUrls.expenseTracker,
                  "tech": ["Flutter", "Firebase", "Provider"],
                  "status": "Live App",
                },
                {
                  "title": "Pokedex",
                  "desc": "High-performance Pokemon API encyclopedia.",
                  "icon": Icons.catching_pokemon,
                  "url": AppUrls.pokedex,
                  "tech": ["Flutter", "REST API", "Animations"],
                  "status": "Active",
                },
                {
                  "title": "Modern Portfolio",
                  "desc": "Responsive web portfolio with glassmorphism UI.",
                  "icon": Icons.web_rounded,
                  "url": AppUrls.portfolio,
                  "tech": ["Flutter Web", "Glassmorphism"],
                  "status": "Active",
                },
                {
                  "title": "Weather Live",
                  "desc": "Dynamic weather app with geolocation and forecasts.",
                  "icon": Icons.cloud_queue_rounded,
                  "url": AppUrls.weatherApp,
                  "tech": ["Flutter", "OpenWeather", "Maps"],
                  "status": "Deployed",
                },
                {
                  "title": "BetterMe",
                  "desc": "Personalized health and wellness tracking platform.",
                  "icon": FontAwesomeIcons.heartPulse,
                  "url": AppUrls.betterMeApp,
                  "tech": ["Flutter", "Analytics", "HealthKit"],
                  "status": "Active",
                },
              ];
              final p = projects[index];
              return _ProjectCard(
                title: p["title"] as String,
                description: p["desc"] as String,
                icon: p["icon"] as IconData,
                url: p["url"] as String,
                technologies: (p["tech"] as List).cast<String>(),
                status: p["status"] as String,
                isDark: isDark,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return CreativeSectionHeader(
      number: "03",
      category: "Portfolio",
      title: "Featured Projects",
      isDark: isDark,
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final String url;
  final List<String> technologies;
  final String status;
  final bool isDark;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.url,
    required this.technologies,
    required this.status,
    required this.isDark,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    
    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) {
            setState(() => isHovered = true);
            cursorProvider.setHovering(true);
          },
          onExit: (_) {
            setState(() => isHovered = false);
            cursorProvider.setHovering(false);
          },
          child: GestureDetector(
            onTap: () {
              cursorProvider.setHovering(false);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ProjectCaseStudy(
                  title: widget.title,
                  url: widget.url,
                  isDark: isDark,
                ),
              );
            },
            child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered 
                  ? AppColors.primary.withOpacity(0.8) 
                  : (isDark ? AppColors.primary.withOpacity(0.12) : AppColors.primary.withOpacity(0.25)),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered 
                    ? AppColors.primary.withOpacity(0.12) 
                    : Colors.black.withOpacity(0.04),
                blurRadius: isHovered ? 24 : 12,
                offset: Offset(0, isHovered ? 12 : 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Status & Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "[ ${widget.status.toUpperCase()} ]",
                    style: GoogleFonts.spaceMono(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Icon(
                    widget.icon,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Project Title
              Text(
                widget.title,
                style: GoogleFonts.playfairDisplay(
                  color: isDark ? Colors.white : AppColors.lightText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              // Project Description
              Text(
                widget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              
              // Custom Interactive App Preview visualizer
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.02) : AppColors.primary.withOpacity(0.02),
                    border: Border.all(
                      color: isDark ? AppColors.primary.withOpacity(0.1) : AppColors.primary.withOpacity(0.2),
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _buildProjectVisualizer(widget.title, isDark),
                ),
              ),
              
              // Footer row with tech chips and explore action
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.technologies.take(3).map((tech) => _buildTechChip(tech)).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "EXPLORE",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: Matrix4.identity()..translate(isHovered ? 4.0 : 0.0),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        border: Border.all(
          color: AppColors.primary.withOpacity(
            Theme.of(context).brightness == Brightness.dark ? 0.12 : 0.25,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tech,
        style: GoogleFonts.spaceMono(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildProjectVisualizer(String title, bool isDark) {
    if (title.contains("Expense")) {
      return _buildExpenseVisualizer(isDark);
    } else if (title.contains("Pokedex")) {
      return _buildPokedexVisualizer(isDark);
    } else if (title.contains("Portfolio")) {
      return _buildPortfolioVisualizer(isDark);
    } else if (title.contains("Weather")) {
      return _buildWeatherVisualizer(isDark);
    } else {
      return _buildBetterMeVisualizer(isDark);
    }
  }

  Widget _buildExpenseVisualizer(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TOTAL BALANCE",
                  style: GoogleFonts.spaceMono(
                    fontSize: 8,
                    color: isDark ? Colors.white60 : Colors.black54,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "\$12,845.50",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "+14.2%",
                style: GoogleFonts.spaceMono(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 25,
          width: double.infinity,
          child: CustomPaint(
            painter: _MiniSparklinePainter(
              color: AppColors.primary,
              points: [0.1, 0.3, 0.2, 0.5, 0.4, 0.7, 0.6, 0.9],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPokedexVisualizer(bool isDark) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withOpacity(0.2),
                AppColors.primary.withOpacity(0.0),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.catching_pokemon_rounded,
              size: 24,
              color: AppColors.primary.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatBar("HP", 0.75, Colors.redAccent),
              const SizedBox(height: 4),
              _buildStatBar("ATK", 0.85, Colors.orangeAccent),
              const SizedBox(height: 4),
              _buildStatBar("DEF", 0.60, Colors.blueAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBar(String label, double value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 25,
          child: Text(
            label,
            style: GoogleFonts.spaceMono(fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: widget.isDark ? Colors.white10 : Colors.black12,
              valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.8)),
              minHeight: 3.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioVisualizer(bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent)),
            const SizedBox(width: 3),
            Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent)),
            const SizedBox(width: 3),
            Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent)),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.black12,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 16, height: 3, color: isDark ? Colors.white30 : Colors.black26),
                const SizedBox(height: 3),
                Container(width: 12, height: 3, color: isDark ? Colors.white30 : Colors.black26),
                const SizedBox(height: 3),
                Container(width: 14, height: 3, color: isDark ? Colors.white30 : Colors.black26),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) => Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherVisualizer(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.wb_sunny_rounded,
              color: AppColors.primary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "24°C",
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Sunny",
                  style: GoogleFonts.spaceMono(fontSize: 8, color: isDark ? Colors.white60 : Colors.black54),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildWeatherForecastRow("Mon", "☀️ 26°"),
            const SizedBox(height: 3),
            _buildWeatherForecastRow("Tue", "🌦️ 22°"),
            const SizedBox(height: 3),
            _buildWeatherForecastRow("Wed", "🌧️ 18°"),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherForecastRow(String day, String forecast) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: GoogleFonts.spaceMono(fontSize: 7, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        Text(
          forecast,
          style: GoogleFonts.inter(fontSize: 7, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBetterMeVisualizer(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 38,
          height: 38,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: 0.85,
                strokeWidth: 3,
                backgroundColor: AppColors.primary.withOpacity(0.08),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              Center(
                child: SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: 3,
                    backgroundColor: AppColors.accent.withOpacity(0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "STEPS",
              style: GoogleFonts.spaceMono(fontSize: 7, color: isDark ? Colors.white60 : Colors.black54),
            ),
            Text(
              "9.4k / 10k",
              style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 25,
            child: CustomPaint(
              painter: _MiniSparklinePainter(
                color: Colors.redAccent,
                points: [0.3, 0.3, 0.8, 0.1, 0.4, 0.3, 0.3],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

class _MiniSparklinePainter extends CustomPainter {
  final Color color;
  final List<double> points;

  _MiniSparklinePainter({required this.color, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    if (points.isEmpty) return;

    final double dx = size.width / (points.length - 1);
    path.moveTo(0, size.height * (1.0 - points[0]));

    for (int i = 1; i < points.length; i++) {
      path.lineTo(i * dx, size.height * (1.0 - points[i]));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
