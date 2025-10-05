import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/domain/repositories/recording_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetRecordings implements UseCase<List<RecordingEntity>, NoParams> {
  final RecordingRepository repository;

  GetRecordings(this.repository);

  @override
  Future<List<RecordingEntity>> call(NoParams params) async {
    return await repository.getRecordings();
  }
}