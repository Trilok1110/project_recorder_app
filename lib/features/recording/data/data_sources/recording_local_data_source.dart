import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:recorder_app/core/utils/logger.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';

class RecordingLocalDataSource {
  static const String _recordingsKey = 'recordings';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Retrieves all saved recordings as a list.
  Future<List<RecordingEntity>> getRecordings() async {
    try {
      final prefs = await _prefs;
      final jsonString = prefs.getString(_recordingsKey);
      if (jsonString == null) {
        return const []; // Default empty list
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => RecordingEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger('Error loading recordings: $e');
      return const [];
    }
  }

  /// Saves a recording by appending to the existing list.
  Future<void> saveRecording(RecordingEntity recording) async {
    try {
      final prefs = await _prefs;
      final List<RecordingEntity> recordings = await getRecordings();
      recordings.add(recording);
      final jsonList = recordings.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_recordingsKey, jsonString);
      logger('Saved recording: ${recording.title}');
    } catch (e) {
      logger('Error saving recording: $e');
      rethrow;
    }
  }

  /// Deletes a recording by matching filePath.
  Future<void> deleteRecording(String filePath) async {
    try {
      final prefs = await _prefs;
      final List<RecordingEntity> recordings = await getRecordings();
      final updatedRecordings = recordings
          .where((r) => r.filePath != filePath)
          .toList();
      final jsonList = updatedRecordings.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_recordingsKey, jsonString);
      logger('Deleted recording with filePath: $filePath');
    } catch (e) {
      logger('Error deleting recording: $e');
      rethrow;
    }
  }
}
