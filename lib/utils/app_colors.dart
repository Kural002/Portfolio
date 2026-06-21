import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Premium Modern Creative Gradient Accents (Amber Gold & Bronze)
  static const Color primary = Color(0xFFE2B659); // Amber Gold
  static const Color secondary = Color(0xFFC5A880); // Champagne Sand
  static const Color accent = Color(0xFFD97706); // Rich Amber
  
  // Dark Theme Colors (Deep Midnight Obsidian)
  static const Color darkBg = Color(0xFF0C0C0E);
  static const Color darkSurface = Color(0xFF131316);
  static const Color darkCard = Color(0xFF19191C);
  static const Color darkText = Color(0xFFFDFBF7); // Warm white
  static const Color darkTextDim = Color(0xFF9CA3AF);
  
  // Light Theme Colors (Sleek Modern Cream/Stone)
  static const Color lightBg = Color(0xFFFAF8F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F2EC);
  static const Color lightText = Color(0xFF1C1917); // Stone dark text
  static const Color lightTextDim = Color(0xFF78716C);

  // Reusable Glassmorphism Decoration
  static BoxDecoration glassDecoration({bool isDark = true}) {
    return BoxDecoration(
      color: isDark 
        ? const Color(0xFF131316).withOpacity(0.5) 
        : Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: isDark 
            ? AppColors.primary.withOpacity(0.12) 
            : AppColors.primary.withOpacity(0.25),
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBg,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    surface: AppColors.lightSurface,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.playfairDisplay(color: AppColors.lightText, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.playfairDisplay(color: AppColors.lightText, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.playfairDisplay(color: AppColors.lightText, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.inter(color: AppColors.lightText, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.inter(color: AppColors.lightTextDim, fontWeight: FontWeight.w500),
  ),
  cardTheme: CardThemeData(
    color: AppColors.lightCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: Colors.black.withOpacity(0.05)),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBg,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    surface: AppColors.darkSurface,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.playfairDisplay(color: AppColors.darkText, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.playfairDisplay(color: AppColors.darkText, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.playfairDisplay(color: AppColors.darkText, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.inter(color: AppColors.darkText, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.inter(color: AppColors.darkTextDim, fontWeight: FontWeight.w500),
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: Colors.white.withOpacity(0.04)),
    ),
  ),
);
