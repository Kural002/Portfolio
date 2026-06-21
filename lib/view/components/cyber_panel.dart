import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/cursor_provider.dart';

/// A premium, frosted-glass container with soft rounded corners and smooth ambient shadows on hover.
class CyberPanel extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double cutSize; // Unused in this layout but kept for signature compatibility
  final double borderWidth;
  final bool isGlowEnabled;
  final bool drawTechMarks; // Unused in this layout but kept for signature compatibility
  final EdgeInsetsGeometry padding;

  const CyberPanel({
    super.key,
    required this.child,
    this.color,
    this.cutSize = 16.0,
    this.borderWidth = 1.0,
    this.isGlowEnabled = false,
    this.drawTechMarks = false,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color strokeColor = color ?? (isDark 
        ? AppColors.primary.withOpacity(0.12) 
        : AppColors.primary.withOpacity(0.25));
    final Color backgroundFill = isDark 
        ? const Color(0xFF0F111A).withOpacity(0.65) 
        : Colors.white.withOpacity(0.75);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: backgroundFill,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isGlowEnabled 
              ? (color ?? AppColors.primary).withOpacity(0.35) 
              : strokeColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: isGlowEnabled 
                ? (color ?? AppColors.primary).withOpacity(0.12) 
                : Colors.black.withOpacity(0.02),
            blurRadius: isGlowEnabled ? 30 : 15,
            spreadRadius: isGlowEnabled ? 2 : 0,
            offset: isGlowEnabled ? const Offset(0, 10) : const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A modern creative button with smooth gradients and hover scale transitions.
class CyberButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final double cutSize; // Kept for signature compatibility
  final bool filled;

  const CyberButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.cutSize = 12.0,
    this.filled = false,
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Premium indigo-violet gradient colors
    final startColor = widget.color ?? AppColors.primary;
    final endColor = AppColors.secondary;

    return Consumer<CursorProvider>(
      builder: (context, cursorProvider, child) {
        return MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            cursorProvider.setHovering(true);
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            cursorProvider.setHovering(false);
          },
          child: GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()..scale(_isHovered ? 1.04 : 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: widget.filled
                    ? LinearGradient(
                        colors: isDark
                            ? [startColor, endColor]
                            : [const Color(0xFF1C1917), const Color(0xFF854D0E), const Color(0xFF78350F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: !widget.filled
                    ? (_isHovered
                        ? startColor.withOpacity(0.08)
                        : (isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02)))
                    : null,
                border: !widget.filled
                    ? Border.all(
                        color: _isHovered ? startColor.withOpacity(0.6) : (isDark ? Colors.white12 : Colors.black12),
                        width: 1.5,
                      )
                    : null,
                boxShadow: [
                  if (widget.filled)
                    BoxShadow(
                      color: isDark 
                          ? startColor.withOpacity(_isHovered ? 0.35 : 0.2)
                          : const Color(0xFF78350F).withOpacity(_isHovered ? 0.22 : 0.12),
                      blurRadius: _isHovered ? 16 : 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A soft, pulsing gradient aura behind avatar images.
class RotatingHologramRing extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Color? color;

  const RotatingHologramRing({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.color,
  });

  @override
  State<RotatingHologramRing> createState() => _RotatingHologramRingState();
}

class _RotatingHologramRingState extends State<RotatingHologramRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = widget.color ?? AppColors.primary;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Parallax float calculations
          final double floatOffset = _controller.value * 6.0;
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Layer 1: Rotated Backing Glass Plate (Editorial Style)
              Transform.rotate(
                angle: -0.05 + _controller.value * 0.01,
                child: Container(
                  width: widget.width * 0.84,
                  height: widget.height * 0.84,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.01),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.12),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.06),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Layer 2: Front Avatar Container (gradient border frame)
              Positioned(
                top: floatOffset - 3,
                left: -floatOffset * 0.3,
                child: Container(
                  width: widget.width * 0.84,
                  height: widget.height * 0.84,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0), // Gradient border width
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F111A) : Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),

              // Layer 3: Floating Creative Glass Badge (Overlay)
              Positioned(
                bottom: 25 + floatOffset,
                right: widget.width * 0.02,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.black : Colors.white).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF10B981), // Active green
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "KURAL.DEV",
                            style: GoogleFonts.spaceMono(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A clean, minimalist status badge (e.g. green pulsing dot showing availability)
class CyberStatusBadge extends StatefulWidget {
  final String label;
  final Color? color;

  const CyberStatusBadge({super.key, required this.label, this.color});

  @override
  State<CyberStatusBadge> createState() => _CyberStatusBadgeState();
}

class _CyberStatusBadgeState extends State<CyberStatusBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = widget.color ?? const Color(0xFF10B981); // Emerald green default

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(_controller.value),
                      blurRadius: 5,
                      spreadRadius: 1.5,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A text wrapper designed to render premium gradient typography.
class GlowText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color glowColor; // Kept for signature compatibility
  final double glowRadius; // Kept for signature compatibility
  final TextAlign? textAlign;

  const GlowText({
    super.key,
    required this.text,
    required this.style,
    required this.glowColor,
    this.glowRadius = 8.0,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: isDark
            ? [AppColors.primary, AppColors.secondary, const Color(0xFFFBBF24)]
            : [const Color(0xFF1C1917), const Color(0xFF854D0E), const Color(0xFF78350F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

/// A highly polished, minimal, and creative section heading displaying
/// hollow numbered watermarks in the background overlay.
class CreativeSectionHeader extends StatelessWidget {
  final String number;
  final String category;
  final String title;
  final bool isDark;

  const CreativeSectionHeader({
    super.key,
    required this.number,
    required this.category,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Monospace section number
            Text(
              "// $number",
              style: GoogleFonts.spaceMono(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            // Minimal bullet dot separator
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            // Monospace category tag
            Text(
              category.toUpperCase(),
              style: GoogleFonts.spaceMono(
                color: isDark ? Colors.white60 : Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Section Title with creative colored period
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: GoogleFonts.playfairDisplay(
                  color: isDark ? Colors.white : AppColors.lightText,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: '.',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A highly polished, scroll-triggered reveal animation widget
/// that fades and slides its child upward as it enters the viewport.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final double delay; // delay in milliseconds
  final double slideOffset; // starting Y offset in pixels

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = 0,
    this.slideOffset = 40.0,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasRevealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, widget.slideOffset),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkReveal() {
    if (_hasRevealed) return;
    if (!mounted) return;

    try {
      final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;

        // Trigger when the top of the widget is within screen bounds (with offset buffer)
        if (position.dy < screenHeight - 60) {
          _hasRevealed = true;
          Future.delayed(Duration(milliseconds: widget.delay.toInt()), () {
            if (mounted) {
              _controller.forward();
            }
          });
        }
      }
    } catch (_) {
      // Retry next frame if layout bounds aren't fully resolved
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkReveal();
        return false;
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Check for entrance on initial frame layout
          WidgetsBinding.instance.addPostFrameCallback((_) => _checkReveal());

          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.translate(
              offset: _slideAnimation.value,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
