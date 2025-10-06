

import '../../domain/entities/recording_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();

  @override
  List<Object> get props => [];
}

class LoadRecordingsEvent extends RecordingEvent {}

class AddRecordingEvent extends RecordingEvent {
  final RecordingEntity recording;

  const AddRecordingEvent(this.recording);

  @override
  List<Object> get props => [recording];
}

class DeleteRecordingEvent extends RecordingEvent {
  final String id;

  const DeleteRecordingEvent(this.id);

  @override
  List<Object> get props => [id];
}

// Playback events - renamed to avoid conflicts
class PlayRecordingEvent extends RecordingEvent {
  final String recordingId;
  final String filePath;

  const PlayRecordingEvent(this.recordingId, this.filePath);

  @override
  List<Object> get props => [recordingId, filePath];
}

class StopRecordingEvent extends RecordingEvent {
  const StopRecordingEvent();

  @override
  List<Object> get props => [];
}

class PauseRecordingEvent extends RecordingEvent {
  const PauseRecordingEvent();

  @override
  List<Object> get props => [];
}