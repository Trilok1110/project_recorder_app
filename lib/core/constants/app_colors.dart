import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF113C6D);
  static const Color accentRed = Color(0xFFEF4444);

  // Background & Surfaces
  static const Color background = Color(0xFFF8FAFC); // App Background
  static const Color surfaceWhite = Color(0xFFFFFFFF); // Cards, Dialogs

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B); // Headlines, Important Text
  static const Color textSecondary = Color(0xFF64748B); // Body Text, Labels
  static const Color textTertiary = Color(0xFF94A3B8); // Inactive Tabs, Disabled Text

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0); // Dividers, Input Borders

  // Gender Colors
  static const Color genderFemale = Color(0xFFEC4899); // ♀ Female
  static const Color genderMale = Color(0xFF113C6D); // ♂ Male#113C6D

  // Card Color Palette (6 Options)
  static const Color cardRed = Color(0xFFEF4444);
  static const Color cardBlue = Color(0xFF3B82F6);
  static const Color cardGreen = Color(0xFF10B981);
  static const Color cardYellow = Color(0xFFF59E0B);
  static const Color cardPurple = Color(0xFF8B5CF6);
  static const Color cardPink = Color(0xFFEC4899);

  // List of card colors for easy access
  static const List<Color> cardColors = [
    cardRed,
    cardBlue,
    cardGreen,
    cardYellow,
    cardPurple,
    cardPink,
  ];
}