import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_bloc.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_event.dart';
import 'package:uuid/uuid.dart';

class SaveRecordingDialog extends StatefulWidget {
  final Duration recordingDuration;
  final String audioFilePath;

  const SaveRecordingDialog({
    super.key,
    required this.recordingDuration,
    required this.audioFilePath,
  });

  @override
  State<SaveRecordingDialog> createState() => _SaveRecordingDialogState();
}

class _SaveRecordingDialogState extends State<SaveRecordingDialog> {
  final TextEditingController _titleController = TextEditingController();
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _titleController.text = 'Recording 1';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveRecording() {
    final title = _titleController.text.trim().isEmpty
        ? 'Recording 1'
        : _titleController.text;

    final newRecording = RecordingEntity(
      id: const Uuid().v4(),
      title: title,
      colorValue: AppColors.cardColors[_selectedColorIndex].value,
      filePath: widget.audioFilePath, // Use actual recorded file path
      dateCreated: DateTime.now(),
      duration: widget.recordingDuration,
    );

    // Save to bloc (this will automatically save to SharedPreferences)
    context.read<RecordingBloc>().add(AddRecording(newRecording));

    // Close dialog and return to main page
    Navigator.pop(context); // Close dialog
    Navigator.pop(context); // Close recording screen and return to main page
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Save Recording',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Recording Name',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Recording 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Select Card Color',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorIndex = index;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.cardColors[index],
                          shape: BoxShape.circle,
                          border: _selectedColorIndex == index
                              ? Border.all(
                            color: AppColors.primaryBlue,
                            width: 3,
                          )
                              : null,
                        ),
                        child: _selectedColorIndex == index
                            ? const Icon(
                          Icons.check,
                          color: AppColors.primaryBlue,
                          size: 16,
                        )
                            : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveRecording,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}