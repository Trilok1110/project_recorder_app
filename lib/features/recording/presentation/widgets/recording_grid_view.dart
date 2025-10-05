import 'package:flutter/material.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/widgets/recording_card.dart';

class RecordingGridView extends StatelessWidget {
  final List<RecordingEntity> recordings;
  final Function(RecordingEntity) onPlayPressed;
  final Function(String) onDeletePressed;

  const RecordingGridView({
    super.key,
    required this.recordings,
    required this.onPlayPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8, // Square cards
        ),
        itemCount: recordings.length,
        itemBuilder: (context, index) {
          final recording = recordings[index];
          return RecordingCard(
            recording: recording,
            onPlayPressed: () => onPlayPressed(recording),
            onDeletePressed: () => onDeletePressed(recording.id),
          );
        },
      ),
    );
  }
}