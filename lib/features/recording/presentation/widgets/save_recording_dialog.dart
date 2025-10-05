// lib/features/recording/presentation/widgets/save_recording_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constants/app_colors.dart';
import 'package:recorder_app/features/recording/domain/entities/recording_entity.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_bloc.dart';
import 'package:recorder_app/features/recording/presentation/bloc/recording_event.dart';
import 'package:recorder_app/features/recording/presentation/pages/recording_page.dart';
import 'package:uuid/uuid.dart';

class SaveRecordingDialog extends StatefulWidget {
  final Duration recordingDuration;

  const SaveRecordingDialog({
    super.key,
    required this.recordingDuration,
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
      filePath: '/recordings/${DateTime.now().millisecondsSinceEpoch}.aac',
      dateCreated: DateTime.now(),
      duration: widget.recordingDuration,
    );

    // Save to bloc
    context.read<RecordingBloc>().add(AddRecording(newRecording));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecordingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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

            // Recording Name Section
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

            // Color Selection Section
            const Text(
              'Select Card Color',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Color Grid (6 colors in a row)
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

            // Submit Button
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
    );
  }
}