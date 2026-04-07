import 'package:flutter/material.dart';

class AppColors {
  // Common Accents
  static const Color primary = Color(0xFF00D2FF);
  static const Color secondary = Color(0xFF3A7BD5);
  static const Color accent = Color(0xFF7F00FF);
  
  // Dark Theme Colors (Premium Dark)
  static const Color darkBg = Color(0xFF0A0B10);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkCard = Color(0xFF1C2128);
  static const Color darkText = Color(0xFFE6EDF3);
  static const Color darkTextDim = Color(0xFF8B949E);
  
  // Light Theme Colors (Modern Light)
  static const Color lightBg = Color(0xFFF6F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1F2328);
  static const Color lightTextDim = Color(0xFF656D76);

  // Glassmorphism helpers (Simplified for theme)
  static BoxDecoration glassDecoration({bool isDark = true}) {
    return BoxDecoration(
      color: isDark 
        ? Colors.white.withOpacity(0.05) 
        : Colors.black.withOpacity(0.03),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark 
          ? Colors.white.withOpacity(0.1) 
          : Colors.black.withOpacity(0.05),
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
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: AppColors.lightText, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightTextDim),
  ),
  cardTheme: CardThemeData(
    color: AppColors.lightCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
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
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkTextDim),
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.white.withOpacity(0.1)),
    ),
  ),
);
