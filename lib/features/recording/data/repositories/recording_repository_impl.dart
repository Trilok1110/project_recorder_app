import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/domain/repositories/recording_repository.dart';
import 'package:recorder_app/features/recording/data/models/recording_model.dart';

import '../data_sources/recording_local_data_source.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  final RecordingLocalDataSource localDataSource;

  RecordingRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RecordingEntity>> getRecordings() async {
    final recordings = await localDataSource.getRecordings();
    return recordings;
  }

  @override
  Future<void> saveRecording(RecordingEntity recording) async {
    final recordingModel = RecordingModel.fromEntity(recording);
    await localDataSource.saveRecording(recordingModel);
  }

  @override
  Future<void> deleteRecording(String id) async {
    await localDataSource.deleteRecording(id);
  }

  @override
  Future<void> updateRecording(RecordingEntity recording) async {
    final recordingModel = RecordingModel.fromEntity(recording);
    await localDataSource.updateRecording(recordingModel);
  }
}