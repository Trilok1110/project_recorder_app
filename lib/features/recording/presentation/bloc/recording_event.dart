
import 'package:equatable/equatable.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();

  @override
  List<Object> get props => [];
}

class LoadRecordings extends RecordingEvent {}

class AddRecording extends RecordingEvent {
  final RecordingEntity recording;

  const AddRecording(this.recording);

  @override
  List<Object> get props => [recording];
}

// Rename this to avoid conflict
class DeleteRecordingEvent extends RecordingEvent {
  final String id;

  const DeleteRecordingEvent(this.id);

  @override
  List<Object> get props => [id];
}