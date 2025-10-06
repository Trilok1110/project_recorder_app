import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

class RecordingCard extends StatelessWidget {
  final RecordingEntity recording;
  final VoidCallback onPlayPressed;
  final VoidCallback onDeletePressed;
  final bool isPlaying;
  final bool isLoading;

  const RecordingCard({
    super.key,
    required this.recording,
    required this.onPlayPressed,
    required this.onDeletePressed,
    this.isPlaying = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: recording.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(recording.color)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Duration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recording.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  recording.formattedDuration,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Play + Delete buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedScale(
                scale: isPlaying ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: (isPlaying
                            ? AppColors.accentRed
                            : AppColors.primaryBlue)
                            .withValues(alpha: 0.25),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  width: 36,
                  height: 36,
                  child: isLoading
                      ? const Padding(
                    padding: EdgeInsets.all(6),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue),
                    ),
                  )
                      : IconButton(
                    onPressed: onPlayPressed,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (Widget child,
                          Animation<double> animation) =>
                          ScaleTransition(
                              scale: animation, child: child),
                      child: Icon(
                        isPlaying
                            ? Icons.stop_rounded
                            : Icons.play_arrow_rounded,
                        key: ValueKey(isPlaying),
                        color: isPlaying
                            ? AppColors.accentRed
                            : AppColors.primaryBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // 🗑 Delete Button
              _buildActionButton(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.accentRed,
                onPressed: onDeletePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor, size: 18),
        padding: const EdgeInsets.all(4),
        constraints: const BoxConstraints(),
      ),
    );
  }

  Color _getBorderColor(Color bg) {
    if (bg == AppColors.cardPink) return const Color(0xFFFEB4EB);
    if (bg == AppColors.cardLavender) return const Color(0xFFD3C7FF);
    if (bg == AppColors.cardLightRed) return const Color(0xFFFFBABA);
    if (bg == AppColors.cardLightGreen) return const Color(0xFFA8EAB1);
    if (bg == AppColors.cardLightBlue) return const Color(0xFFB8E0FF);
    if (bg == AppColors.cardLightOrange) return const Color(0xFFFFD8A6);
    return AppColors.border;
  }
}
