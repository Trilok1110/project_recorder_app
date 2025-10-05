import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  static const TextStyle employeeName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E293B),
    fontFamily: 'Roboto',
    height: 1.0,
  );

  static const TextStyle employeeEmail = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:AppColors.primaryBlue ,
    fontFamily: 'Roboto',
    height: 1.0,
  );

  static const TextStyle employeeDetailLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF64748B),
    fontFamily: 'Roboto',
    height: 1.0,
  );

  static const TextStyle employeeDetailValue = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryBlue,
    fontFamily: 'Roboto',
    height: 1.0,
  );



  static TextStyle genderTextWithColor(Color color) {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      height: 1.0,
    ).copyWith(color: color);
  }
}