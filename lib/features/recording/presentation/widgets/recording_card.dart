import 'package:flutter/material.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

class RecordingCard extends StatelessWidget {
  final RecordingEntity recording;

  const RecordingCard({super.key, required this.recording});

  Color _parseColor(String hex) {
    // Parse hex string to Color (e.g., '#EF4444' → Color)
    final int colorInt = int.parse(hex.substring(1), radix: 16) + 0xFF000000;
    return Color(colorInt);
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _parseColor(recording.color);
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                recording.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Play button overlay (top-left)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          // Delete button overlay (top-right)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

