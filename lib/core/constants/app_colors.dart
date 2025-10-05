import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF113C6D);
  static const Color accentRed = Color(0xFFEF4444);

  // Background & Surfaces
  static const Color background = Color(0xFFF8FAFC);
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);

  // Gender Colors
  static const Color genderFemale = Color(0xFFEC4899);
  static const Color genderMale = Color(0xFF113C6D);

  // Card Color Palette
  static const Color cardPink = Color(0xFFFFF3FC);
  static const Color cardLavender = Color(0xFFEFE8FF);
  static const Color cardLightRed = Color(0xFFFFDFDF);
  static const Color cardLightGreen = Color(0xFFD9FFDD);
  static const Color cardLightBlue = Color(0xFFE2F2FF);
  static const Color cardLightOrange = Color(0xFFFFEDD8);

  // List of card colors for easy access
  static const List<Color> cardColors = [
    cardPink,
    cardLavender,
    cardLightRed,
    cardLightGreen,
    cardLightBlue,
    cardLightOrange,
  ];

  // Get color by index
  static Color getCardColor(int index) {
    return cardColors[index % cardColors.length];
  }
}