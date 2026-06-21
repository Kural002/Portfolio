import 'package:flutter/material.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/cursor_provider.dart';
import 'package:provider/provider.dart';

class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context);
    final isHovered = cursorProvider.isHoveringInteractive;

    if (!cursorProvider.showCursor) return const SizedBox.shrink();

    final Color goldColor = AppColors.primary;

    return Stack(
      children: [
        // Outer lagging ring
        AnimatedPositioned(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          left: cursorProvider.position.dx - (isHovered ? 20.0 : 10.0),
          top: cursorProvider.position.dy - (isHovered ? 20.0 : 10.0),
          width: isHovered ? 40.0 : 20.0,
          height: isHovered ? 40.0 : 20.0,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHovered 
                    ? goldColor.withOpacity(0.08) 
                    : Colors.transparent,
                border: Border.all(
                  color: isHovered ? goldColor : goldColor.withOpacity(0.4),
                  width: isHovered ? 1.5 : 1.0,
                ),
                boxShadow: isHovered 
                    ? [
                        BoxShadow(
                          color: goldColor.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
            ),
          ),
        ),
        // Inner fixed dot
        Positioned(
          left: cursorProvider.position.dx - 3.0,
          top: cursorProvider.position.dy - 3.0,
          width: 6.0,
          height: 6.0,
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isHovered ? 0.0 : 1.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: goldColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
