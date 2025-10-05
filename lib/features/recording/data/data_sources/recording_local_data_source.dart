import 'dart:convert';

import '../models/recording_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class RecordingLocalDataSource {
  Future<List<RecordingModel>> getRecordings();
  Future<void> saveRecording(RecordingModel recording);
  Future<void> deleteRecording(String id);
  Future<void> updateRecording(RecordingModel recording);
}

class RecordingLocalDataSourceImpl implements RecordingLocalDataSource {
  final SharedPreferences sharedPreferences;

  RecordingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<RecordingModel>> getRecordings() async {
    try {
      final recordingsJson = sharedPreferences.getStringList('recordings') ?? [];
      final recordings = recordingsJson.map((jsonString) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return RecordingModel.fromJson(jsonMap);
      }).toList();

      // Sort by date created (newest first)
      recordings.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      return recordings;
    } catch (e) {
      throw Exception('Failed to load recordings: $e');
    }
  }

  @override
  Future<void> saveRecording(RecordingModel recording) async {
    try {
      final recordingsJson = sharedPreferences.getStringList('recordings') ?? [];
      final recordingJson = json.encode(recording.toJson());
      recordingsJson.add(recordingJson);

      await sharedPreferences.setStringList('recordings', recordingsJson);
    } catch (e) {
      throw Exception('Failed to save recording: $e');
    }
  }

  @override
  Future<void> deleteRecording(String id) async {
    try {
      final recordingsJson = sharedPreferences.getStringList('recordings') ?? [];
      final updatedRecordings = recordingsJson.where((jsonString) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return jsonMap['id'] != id;
      }).toList();

      await sharedPreferences.setStringList('recordings', updatedRecordings);
    } catch (e) {
      throw Exception('Failed to delete recording: $e');
    }
  }

  @override
  Future<void> updateRecording(RecordingModel recording) async {
    try {
      await deleteRecording(recording.id);
      await saveRecording(recording);
    } catch (e) {
      throw Exception('Failed to update recording: $e');
    }
  }
}