import 'package:flutter/material.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/widgets/recording_card.dart';

class RecordingGridView extends StatelessWidget {
  final List<RecordingEntity> recordings;
  final String? currentlyPlayingId;
  final bool isPlaying;
  final bool isLoading;
  final Function(RecordingEntity) onPlayPressed;
  final Function(String) onDeletePressed;

  const RecordingGridView({
    super.key,
    required this.recordings,
    required this.currentlyPlayingId,
    required this.isPlaying,
    required this.isLoading,
    required this.onPlayPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisSpacing = 16.0;
          final cardWidth = (constraints.maxWidth - crossAxisSpacing) / 2;
          final aspectRatio = 109 / 75;
          final cardHeight = cardWidth / aspectRatio;

          return GridView.builder(
            padding: const EdgeInsets.only(top: 24),
            physics: const BouncingScrollPhysics(),
            itemCount: recordings.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: 16,
              childAspectRatio: aspectRatio, // 👈 perfect ratio 109:75
            ),
            itemBuilder: (context, index) {
              final recording = recordings[index];
              return SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: RecordingCard(
                  recording: recording,
                  onPlayPressed: () => onPlayPressed(recording),
                  onDeletePressed: () => onDeletePressed(recording.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}