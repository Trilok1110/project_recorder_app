import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_bloc.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_event.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_state.dart'; // Fixed import
import 'package:recorder_app/features/recording/presentation/pages/recording_screen.dart';
import 'package:recorder_app/features/recording/presentation/widgets/empty_recording_state.dart';
import 'package:recorder_app/features/recording/presentation/widgets/recording_grid_view.dart';

import '../../../../core/navigation/slide_page_route.dart';

class RecordingPage extends StatelessWidget {
  const RecordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<RecordingBloc, RecordingState>(
        builder: (context, state) {
          if (state is RecordingLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            );
          } else if (state is RecordingError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: AppColors.accentRed),
              ),
            );
          } else if (state is RecordingLoaded) {
            if (state.recordings.isEmpty) {
              return const EmptyRecordingState();
            } else {
              return RecordingGridView(
                recordings: state.recordings,
                currentlyPlayingId: state.currentlyPlayingId,
                isPlaying: state.isPlaying,
                isLoading: state.isLoading,
                onPlayPressed: (recording) {
                  _handlePlayPressed(context, recording, state);
                },
                onDeletePressed: (id) {
                  _deleteRecording(context, id);
                },
              );
            }
          } else {
            return const EmptyRecordingState();
          }
        },
      ),
        floatingActionButton: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                SlidePageRoute(
                  page: const RecordingScreen(),
                  direction: AxisDirection.left, // move in from left
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.mic, size: 24),
          ),
        ),

    );
  }

  void _handlePlayPressed(BuildContext context, RecordingEntity recording, RecordingLoaded state) {
    if (state.currentlyPlayingId == recording.id && state.isPlaying) {
      // Stop currently playing recording
      context.read<RecordingBloc>().add(const StopRecordingEvent());
    } else if (state.currentlyPlayingId == recording.id && !state.isPlaying) {
      // Resume paused recording
      context.read<RecordingBloc>().add(PlayRecordingEvent(recording.id, recording.filePath));
    } else {
      // Stop any currently playing recording and start new one
      if (state.currentlyPlayingId != null) {
        context.read<RecordingBloc>().add(const StopRecordingEvent());
      }
      // Play the selected recording
      context.read<RecordingBloc>().add(PlayRecordingEvent(recording.id, recording.filePath));
    }
  }

  void _deleteRecording(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recording'),
        content: const Text('Are you sure you want to delete this recording?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<RecordingBloc>().add(DeleteRecordingEvent(id)); // Fixed event name
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.accentRed),
            ),
          ),
        ],
      ),
    );
  }
}