// lib/features/recording/domain/services/audio_player_service.dart
import 'package:audioplayers/audioplayers.dart';

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
      print('Error playing audio: $e');
      rethrow;
    }
  }

  Future<void> stopPlaying() async {
    try {
      await _audioPlayer.stop();
      _currentPlayingId = null;
    } catch (e) {
      print('Error stopping audio: $e');
      rethrow;
    }
  }

  Future<void> pausePlaying() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error pausing audio: $e');
      rethrow;
    }
  }

  Future<void> resumePlaying() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      print('Error resuming audio: $e');
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