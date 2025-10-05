import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/presentation/widgets/save_recording_dialog.dart';

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

  @override
  void initState() {
    super.initState();
    _resetToInitialState();
  }

  void _resetToInitialState() {
    setState(() {
      _isRecording = false;
      _isPaused = false;
      _recordingDuration = Duration.zero;
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _isPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });

    print('Audio recording started/resumed...');
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _isPaused = true;
    });

    print('Audio recording paused...');
  }

  void _cancelRecording() {
    _timer?.cancel();
    _resetToInitialState();

    print('Recording cancelled...');
    Navigator.pop(context);
  }

  void _saveRecording() {
    _timer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          SaveRecordingDialog(recordingDuration: _recordingDuration),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.surfaceWhite),
          onPressed: _cancelRecording,
        ),
        title: Text(
          _isRecording ? 'Recording' : 'Record',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      )
,
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
                  color: const Color(0xFFC5DEFF).withOpacity(0.25),
                  width: 13,
                ),
              ),
              child: Icon(
                Icons.mic,
                size: 48,
                color: _isRecording
                    ? AppColors.accentRed
                    : AppColors.primaryBlue,
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
                      ? _cancelRecording
                      : null,
                ),
                _buildControlButton(
                  icon: _isRecording ? Icons.stop : Icons.mic,
                  iconSize: 32,
                  buttonSize: 66,
                  backgroundColor: _isRecording
                      ? const Color(0xFFD90000)
                      : AppColors.primaryBlue,
                  iconColor: Colors.white,
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  isCenterButton: true,
                ),
                _buildControlButton(
                  icon: Icons.check,
                  iconSize: 28,
                  buttonSize: 66,
                  backgroundColor: Colors.transparent,
                  iconColor: _isPaused
                      ? Colors.greenAccent
                      : (_isRecording
                            ? AppColors.textPrimary
                            : AppColors.textTertiary),
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
    required IconData icon,
    required double iconSize,
    required double buttonSize,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback? onPressed,
    bool isCenterButton = false,
  }) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: isCenterButton
          ? BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            )
          : BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, size: iconSize),
        color: iconColor,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
