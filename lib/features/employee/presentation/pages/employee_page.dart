import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const Center(
        child: Text(
          'Employee Tab Placeholder',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}