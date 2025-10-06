

import '../../domain/entities/recording_entity.dart';
import 'package:equatable/equatable.dart';
abstract class RecordingState extends Equatable {
  const RecordingState();

  @override
  List<Object> get props => [];
}

class RecordingInitial extends RecordingState {}

class RecordingLoading extends RecordingState {}

class RecordingLoaded extends RecordingState {
  final List<RecordingEntity> recordings;
  final String? currentlyPlayingId;
  final bool isPlaying;
  final bool isLoading;

  const RecordingLoaded({
    required this.recordings,
    this.currentlyPlayingId,
    this.isPlaying = false,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
    recordings,
    currentlyPlayingId ?? '',
    isPlaying,
    isLoading,
  ];

  RecordingLoaded copyWith({
    List<RecordingEntity>? recordings,
    String? currentlyPlayingId,
    bool? isPlaying,
    bool? isLoading,
  }) {
    return RecordingLoaded(
      recordings: recordings ?? this.recordings,
      currentlyPlayingId: currentlyPlayingId ?? this.currentlyPlayingId,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RecordingError extends RecordingState {
  final String message;

  const RecordingError({required this.message});

  @override
  List<Object> get props => [message];
}