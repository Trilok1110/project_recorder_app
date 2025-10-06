import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EmptyRecordingState extends StatelessWidget {
  const EmptyRecordingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/not_found.webp",
              width: 96,
              height: 96,
            ),
            const SizedBox(height: 24),
            Text(
              'No Recording Found!!',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "There's nothing here yet. Hit the record button to capture something amazing!",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
