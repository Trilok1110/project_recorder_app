import 'package:recorder_app/core/usecases/usecase.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/domain/repositories/recording_repository.dart';

class SaveRecording implements UseCase<void, RecordingEntity> {
  final RecordingRepository repository;

  SaveRecording(this.repository);

  @override
  Future<void> call(RecordingEntity recording) async {
    return await repository.saveRecording(recording);
  }
}