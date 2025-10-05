import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_bloc.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_event.dart';
import 'package:recorder_app/features/recording/presentation/pages/recording_screen.dart';
import 'package:recorder_app/features/recording/presentation/widgets/empty_recording_state.dart';
import 'package:recorder_app/features/recording/presentation/widgets/recording_grid_view.dart';

import '../bloc/recording_state.dart';

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
                onPlayPressed: (recording) {
                  _playRecording(context, recording);
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
                MaterialPageRoute(
                  builder: (context) => const RecordingScreen(),
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

  void _playRecording(BuildContext context, RecordingEntity recording) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing: ${recording.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
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
              context.read<RecordingBloc>().add(DeleteRecordingEvent(id));
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
