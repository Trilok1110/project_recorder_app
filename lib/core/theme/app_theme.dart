import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.secondary,
        error: AppColors.error,
      ),
    );
  }
}