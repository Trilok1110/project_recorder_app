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
            // Magnifying Glass Icon with Water Drop (from Figma)
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Water Drop
                  Positioned(
                    top: 24,
                    child: Container(
                      width: 24,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  // Magnifying Glass Handle
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Container(
                        width: 12,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Title
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
            // Subtitle
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