import '../entities/recording_entity.dart';

abstract class RecordingRepository {
  Future<List<RecordingEntity>> getRecordings();
  Future<void> saveRecording(RecordingEntity recording);
  Future<void> deleteRecording(String id);
  Future<void> updateRecording(RecordingEntity recording);
}