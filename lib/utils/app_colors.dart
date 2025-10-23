import 'package:flutter/material.dart';

class AppColors {
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightText = Color(0xFF2D3748);
  static const Color lightCard = Color(0xFFEDF2F7);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Color(0xFFE2E8F0);
  static const Color darkCard = Color(0xFF1E1E1E);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardColor: AppColors.lightCard,
  primaryColor: Colors.grey[700],
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.lightText),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightCard,
    foregroundColor: AppColors.lightText,
    elevation: 0,
  ),
  cardTheme: CardTheme(
    color: AppColors.lightCard,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkCard,
  primaryColor: Colors.grey[400],
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkCard,
    elevation: 0,
  ),
  cardTheme: CardTheme(
    color: AppColors.darkCard,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
