import 'package:bloc/bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/delete_recording.dart';
import '../../domain/usecases/get_recordings.dart';
import '../../domain/usecases/save_recording.dart';
import 'recording_event.dart';
import 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final GetRecordings getRecordings;
  final SaveRecording saveRecording;
  final DeleteRecording deleteRecording; // Use case

  RecordingBloc({
    required this.getRecordings,
    required this.saveRecording,
    required this.deleteRecording,
  }) : super(RecordingInitial()) {
    on<LoadRecordings>(_onLoadRecordings);
    on<AddRecording>(_onAddRecording);
    on<DeleteRecordingEvent>(_onDeleteRecording); // Updated event name
  }

  Future<void> _onLoadRecordings(
    LoadRecordings event,
    Emitter<RecordingState> emit,
  ) async {
    emit(RecordingLoading());
    try {
      final recordings = await getRecordings(NoParams());
      emit(RecordingLoaded(recordings: recordings));
    } catch (e) {
      emit(RecordingError(message: e.toString()));
    }
  }

  Future<void> _onAddRecording(
    AddRecording event,
    Emitter<RecordingState> emit,
  ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;
      try {
        await saveRecording(event.recording);
        final updatedRecordings = await getRecordings(NoParams());
        emit(RecordingLoaded(recordings: updatedRecordings));
      } catch (e) {
        emit(RecordingError(message: e.toString()));
        emit(RecordingLoaded(recordings: currentState.recordings));
      }
    }
  }

  Future<void> _onDeleteRecording(
    DeleteRecordingEvent event,
    // Updated parameter type
    Emitter<RecordingState> emit,
  ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;
      try {
        await deleteRecording(event.id); // Use case
        final updatedRecordings = await getRecordings(NoParams());
        emit(RecordingLoaded(recordings: updatedRecordings));
      } catch (e) {
        emit(RecordingError(message: e.toString()));
        emit(RecordingLoaded(recordings: currentState.recordings));
      }
    }
  }
}
