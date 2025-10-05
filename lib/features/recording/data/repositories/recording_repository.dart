import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

abstract class RecordingRepository {
  /// Retrieves all saved recordings from local storage.
  Future<List<RecordingEntity>> getRecordings();

  /// Saves a new recording to local storage.
  Future<void> saveRecording(RecordingEntity recording);

  /// Deletes a recording by its file path from local storage.
  Future<void> deleteRecording(String filePath);
}