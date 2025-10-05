import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recorder_app/features/recording/data/repositories/recording_repository_impl.dart';
import 'package:recorder_app/features/recording/domain/repositories/recording_repository.dart';
import 'package:recorder_app/features/recording/domain/usecases/get_recordings.dart';
import 'package:recorder_app/features/recording/domain/usecases/save_recording.dart';
import 'package:recorder_app/features/recording/domain/usecases/delete_recording.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_bloc.dart';

import 'features/recording/data/data_sources/recording_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Data sources
  sl.registerLazySingleton<RecordingLocalDataSource>(
        () => RecordingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Repository
  sl.registerLazySingleton<RecordingRepository>(
        () => RecordingRepositoryImpl(localDataSource: sl()),
  );

  //! Use cases
  sl.registerLazySingleton(() => GetRecordings(sl()));
  sl.registerLazySingleton(() => SaveRecording(sl()));
  sl.registerLazySingleton(() => DeleteRecording(sl()));

  //! Bloc
  sl.registerFactory(
        () => RecordingBloc(
      getRecordings: sl(),
      saveRecording: sl(),
      deleteRecording: sl(),
    ),
  );
}