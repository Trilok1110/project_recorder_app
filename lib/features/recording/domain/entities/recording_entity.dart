import 'dart:ui';

class RecordingEntity {
  final String id;
  final String title;
  final int colorValue; // Store as int for SharedPreferences
  final String filePath;
  final DateTime dateCreated;
  final Duration duration;

  const RecordingEntity({
    required this.id,
    required this.title,
    required this.colorValue,
    required this.filePath,
    required this.dateCreated,
    required this.duration,
  });

  // Convert to Color object
  Color get color => Color(colorValue);

  // Format date for display
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(dateCreated);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateCreated.day}/${dateCreated.month}/${dateCreated.year}';
    }
  }


  // Format duration for display
  String get formattedDuration {
    final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecordingEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}