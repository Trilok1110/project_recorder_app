import 'package:recorder_app/core/usecases/usecase.dart';
import 'package:recorder_app/features/recording/domain/repositories/recording_repository.dart';

class DeleteRecording implements UseCase<void, String> {
  final RecordingRepository repository;

  DeleteRecording(this.repository);

  @override
  Future<void> call(String id) async {
    return await repository.deleteRecording(id);
  }
}