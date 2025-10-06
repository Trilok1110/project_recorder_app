// lib/features/recording/domain/services/audio_player_service.dart
import 'package:audioplayers/audioplayers.dart';

import '../../../../core/utils/logger.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPlayingId;

  AudioPlayer get player => _audioPlayer;

  Future<void> playRecording(String filePath, String recordingId) async {
    try {
      // Stop current playback if any
      if (_currentPlayingId != null) {
        await _audioPlayer.stop();
      }

      // Start new playback
      await _audioPlayer.play(DeviceFileSource(filePath));
      _currentPlayingId = recordingId;
    } catch (e) {
      logger('Error playing audio: $e');
      rethrow;
    }
  }

  Future<void> stopPlaying() async {
    try {
      await _audioPlayer.stop();
      _currentPlayingId = null;
    } catch (e) {
      logger('Error stopping audio: $e');
      rethrow;
    }
  }

  Future<void> pausePlaying() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      logger('Error pausing audio: $e');
      rethrow;
    }
  }

  Future<void> resumePlaying() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      logger('Error resuming audio: $e');
      rethrow;
    }
  }

  bool isPlaying(String recordingId) {
    return _currentPlayingId == recordingId;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}