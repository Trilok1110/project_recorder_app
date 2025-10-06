import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/presentation/widgets/save_recording_dialog.dart';
import '../../../../core/utils/logger.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  Duration _recordingDuration = Duration.zero;
  bool _isRecording = false;
  bool _isPaused = false;
  Timer? _timer;
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    _resetToInitialState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  void _resetToInitialState() {
    setState(() {
      _isRecording = false;
      _isPaused = false;
      _recordingDuration = Duration.zero;
      _audioFilePath = null;
    });
  }

  Future<String> _getRecordingPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final recordingsDir = Directory('${directory.path}/recordings');

    if (!await recordingsDir.exists()) {
      await recordingsDir.create(recursive: true);
    }

    return '${recordingsDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
  }

  Future<void> _startRecording() async {
    if (!await Permission.microphone.isGranted) {
      await _requestPermissions();
      if (!await Permission.microphone.isGranted) {
        _showErrorSnackBar('Microphone permission required');
        return;
      }
    }

    try {
      _audioFilePath = await _getRecordingPath();
      logger('Starting recording at: $_audioFilePath');

      await _audioRecorder.start(
        const RecordConfig(),
        path: _audioFilePath!,
      );

      setState(() {
        _isRecording = true;
        _isPaused = false;
        _recordingDuration = Duration.zero;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      });

      logger('Audio recording started successfully');
    } catch (e) {
      logger('Error starting recording: $e');
      _showErrorSnackBar('Failed to start recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      _timer?.cancel();
      final path = await _audioRecorder.stop();
      _audioFilePath = path ?? _audioFilePath;

      setState(() {
        _isRecording = false;
        _isPaused = true;
      });

      logger('Audio recording stopped. File: $_audioFilePath');

      if (_audioFilePath != null) {
        final file = File(_audioFilePath!);
        if (await file.exists()) {
          final length = await file.length();
          logger('Recording file size: $length bytes');
        } else {
          logger('Recording file was not created');
        }
      }
    } catch (e) {
      logger('Error stopping recording: $e');
      _showErrorSnackBar('Failed to stop recording: $e');
    }
  }

  Future<void> _resetRecording() async {
    _timer?.cancel();

    try {
      await _audioRecorder.stop();
      if (_audioFilePath != null) {
        final file = File(_audioFilePath!);
        if (await file.exists()) {
          await file.delete();
          logger('Recording file deleted');
        }
      }
    } catch (e) {
      logger('Error resetting recording: $e');
    }

    _resetToInitialState();
    logger('Recording reset to initial state');
  }

  void _saveRecording() {
    _timer?.cancel();

    if (_audioFilePath == null) {
      _showErrorSnackBar('No recording to save');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SaveRecordingDialog(
        recordingDuration: _recordingDuration,
        audioFilePath: _audioFilePath!,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.accentRed,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildTimerText() {
    final hours = _recordingDuration.inHours;
    final minutes = _recordingDuration.inMinutes.remainder(60);
    final seconds = _recordingDuration.inSeconds.remainder(60);

    bool hasMinutes = _recordingDuration.inMinutes > 0;
    bool hasHours = _recordingDuration.inHours > 0;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.0,
          letterSpacing: 0,
        ),
        children: [
          TextSpan(
            text: '${twoDigits(hours)}:',
            style: TextStyle(
              color: hasHours ? AppColors.textPrimary : Colors.grey,
            ),
          ),
          TextSpan(
            text: '${twoDigits(minutes)}:',
            style: TextStyle(
              color: (hasMinutes || hasHours)
                  ? AppColors.textPrimary
                  : Colors.grey,
            ),
          ),
          TextSpan(
            text: twoDigits(seconds),
            style: const TextStyle(color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          elevation: 0,

          title: Text(
            _isRecording ? 'Recording' : 'Record',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset(
                'assets/app_logo.webp',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2FF),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFC5DEFF).withValues(alpha: 0.25),
                  width: 13,
                ),
              ),
              child: Icon(
                Icons.mic,
                size: 48,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 39.67),
            _buildTimerText(),
            const SizedBox(height: 218.33),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: Icons.close,
                  iconSize: 28,
                  buttonSize: 66,
                  backgroundColor: Colors.transparent,
                  iconColor: _isRecording || _isPaused
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                  onPressed: _isRecording || _isPaused
                      ? _resetRecording
                      : null,
                ),
                _buildControlButton(
                  isRecording: _isRecording,
                  buttonSize: 90,
                  backgroundColor: Colors.white,
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  isCenterButton: true,
                ),
                _buildControlButton(
                  icon: Icons.check,
                  iconSize: 28,
                  buttonSize: 66,
                  backgroundColor: Colors.transparent,
                  iconColor: _isPaused
                      ? Colors.green
                      : AppColors.textTertiary,
                  onPressed: _isPaused ? _saveRecording : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    IconData? icon,
    double iconSize = 28,
    required double buttonSize,
    required Color backgroundColor,
    Color? iconColor,
    required VoidCallback? onPressed,
    bool isCenterButton = false,
    bool isRecording = false,
  }) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isCenterButton
            ? Border.all(color: Colors.white, width: 1)
            : null,
      ),
      child: IconButton(
        icon: isCenterButton
            ? AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isRecording ? 40 : 50,
          height: isRecording ? 40 : 50,
          decoration: ShapeDecoration(
            color: const Color(0xFFD90000),
            shape: isRecording
                ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
                : const CircleBorder(),
          ),
        )
            : Icon(icon, size: iconSize),
        color: iconColor,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}