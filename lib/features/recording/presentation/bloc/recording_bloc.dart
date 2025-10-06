import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/delete_recording.dart';
import '../../domain/usecases/get_recordings.dart';
import '../../domain/usecases/save_recording.dart';
import '../../domain/services/audio_player_service.dart';
import 'recording_event.dart';
import 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final GetRecordings getRecordings;
  final SaveRecording saveRecording;
  final DeleteRecording deleteRecordingUseCase; // Renamed to avoid conflict
  final AudioPlayerService audioPlayerService; // Add audio service

  RecordingBloc({
    required this.getRecordings,
    required this.saveRecording,
    required this.deleteRecordingUseCase,
    required this.audioPlayerService, // Add to constructor
  }) : super(RecordingInitial()) {
    on<LoadRecordingsEvent>(_onLoadRecordings);
    on<AddRecordingEvent>(_onAddRecording);
    on<DeleteRecordingEvent>(_onDeleteRecording);
    on<PlayRecordingEvent>(_onPlayRecording);
    on<StopRecordingEvent>(_onStopRecording);
    on<PauseRecordingEvent>(_onPauseRecording);
  }

  Future<void> _onLoadRecordings(
      LoadRecordingsEvent event,
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
      AddRecordingEvent event,
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
    } else {
      emit(RecordingLoading());
      try {
        await saveRecording(event.recording);
        final recordings = await getRecordings(NoParams());
        emit(RecordingLoaded(recordings: recordings));
      } catch (e) {
        emit(RecordingError(message: e.toString()));
      }
    }
  }

  Future<void> _onDeleteRecording(
      DeleteRecordingEvent event,
      Emitter<RecordingState> emit,
      ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;
      try {
        await deleteRecordingUseCase(event.id);
        final updatedRecordings = await getRecordings(NoParams());
        emit(RecordingLoaded(recordings: updatedRecordings));
      } catch (e) {
        emit(RecordingError(message: e.toString()));
        emit(RecordingLoaded(recordings: currentState.recordings));
      }
    }
  }

  Future<void> _onPlayRecording(
      PlayRecordingEvent event,
      Emitter<RecordingState> emit,
      ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;

      // Show loading state
      emit(currentState.copyWith(
        currentlyPlayingId: event.recordingId,
        isLoading: true,
      ));

      try {
        // Play the audio
        await audioPlayerService.playRecording(event.filePath, event.recordingId);

        // Update to playing state
        emit(currentState.copyWith(
          currentlyPlayingId: event.recordingId,
          isPlaying: true,
          isLoading: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(
          currentlyPlayingId: null,
          isPlaying: false,
          isLoading: false,
        ));
        emit(RecordingError(message: 'Failed to play recording: $e'));
        emit(currentState);
      }
    }
  }

  Future<void> _onStopRecording(
      StopRecordingEvent event,
      Emitter<RecordingState> emit,
      ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;

      try {
        await audioPlayerService.stopPlaying();

        emit(currentState.copyWith(
          currentlyPlayingId: null,
          isPlaying: false,
          isLoading: false,
        ));
      } catch (e) {
        emit(RecordingError(message: 'Failed to stop recording: $e'));
        emit(currentState);
      }
    }
  }

  Future<void> _onPauseRecording(
      PauseRecordingEvent event,
      Emitter<RecordingState> emit,
      ) async {
    if (state is RecordingLoaded) {
      final currentState = state as RecordingLoaded;

      try {
        await audioPlayerService.pausePlaying();

        emit(currentState.copyWith(
          isPlaying: false,
        ));
      } catch (e) {
        emit(RecordingError(message: 'Failed to pause recording: $e'));
        emit(currentState);
      }
    }
  }

  @override
  Future<void> close() {
    audioPlayerService.dispose();
    return super.close();
  }
}