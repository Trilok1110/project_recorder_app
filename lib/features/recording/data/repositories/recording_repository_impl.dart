import 'package:recorder_app/features/recording/data/data_sources/recording_local_data_source.dart';
import 'package:recorder_app/features/recording/data/repositories/recording_repository.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  final RecordingLocalDataSource _localDataSource;

  const RecordingRepositoryImpl(this._localDataSource);

  @override
  Future<List<RecordingEntity>> getRecordings() => _localDataSource.getRecordings();

  @override
  Future<void> saveRecording(RecordingEntity recording) => _localDataSource.saveRecording(recording);

  @override
  Future<void> deleteRecording(String filePath) => _localDataSource.deleteRecording(filePath);
}