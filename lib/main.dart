import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Employee Imports
import 'core/network/api_client.dart';
import 'features/employee/data/data_sources/employee_remote_data_source.dart';
import 'features/employee/data/repositories/employee_repository_impl.dart';
import 'features/employee/domain/usecases/get_employees.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';
// Recording Imports
import 'features/recording/data/data_sources/recording_local_data_source.dart';
import 'features/recording/data/repositories/recording_repository_impl.dart';
import 'features/recording/domain/usecases/delete_recording.dart';
import 'features/recording/domain/usecases/get_recordings.dart';
import 'features/recording/domain/usecases/save_recording.dart';
import 'features/recording/presentation/bloc/recording_bloc.dart';
import 'features/recording/presentation/bloc/recording_event.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for Recording feature
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Employee Bloc
        BlocProvider<EmployeeBloc>(
          create: (context) => EmployeeBloc(
            getEmployees: GetEmployees(
              EmployeeRepositoryImpl(
                remoteDataSource: EmployeeRemoteDataSourceImpl(
                  apiClient: ApiClient(),
                ),
              ),
            ),
          ),
        ),
        // Recording Bloc - ADD THIS
        BlocProvider<RecordingBloc>(
          create: (context) => RecordingBloc(
            getRecordings: GetRecordings(
              RecordingRepositoryImpl(
                localDataSource: RecordingLocalDataSourceImpl(
                  sharedPreferences: sharedPreferences,
                ),
              ),
            ),
            saveRecording: SaveRecording(
              RecordingRepositoryImpl(
                localDataSource: RecordingLocalDataSourceImpl(
                  sharedPreferences: sharedPreferences,
                ),
              ),
            ),
            deleteRecording: DeleteRecording(
              RecordingRepositoryImpl(
                localDataSource: RecordingLocalDataSourceImpl(
                  sharedPreferences: sharedPreferences,
                ),
              ),
            ),
          )..add(LoadRecordings()),
        ),
      ],
      child: MaterialApp(
        title: 'Recorder App',
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
