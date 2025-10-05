import 'package:equatable/equatable.dart';
import '../../domain/entities/recording_entity.dart';

abstract class RecordingState extends Equatable {
  const RecordingState();

  @override
  List<Object> get props => [];
}

class RecordingInitial extends RecordingState {}

class RecordingLoading extends RecordingState {}

class RecordingLoaded extends RecordingState {
  final List<RecordingEntity> recordings;

  const RecordingLoaded({required this.recordings});

  @override
  List<Object> get props => [recordings];
}

class RecordingError extends RecordingState {
  final String message;

  const RecordingError({required this.message});

  @override
  List<Object> get props => [message];
}
