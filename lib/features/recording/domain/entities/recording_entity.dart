import 'package:equatable/equatable.dart';

class RecordingEntity extends Equatable {
  final String title;
  final String color; // Hex string, e.g., '#EF4444'
  final String filePath;
  final String date; // ISO8601 string, e.g., '2023-10-05T12:00:00Z'

  const RecordingEntity({
    required this.title,
    required this.color,
    required this.filePath,
    required this.date,
  });

  // JSON serialization for SharedPreferences storage
  Map<String, dynamic> toJson() => {
    'title': title,
    'color': color,
    'filePath': filePath,
    'date': date,
  };

  // Factory for JSON deserialization
  factory RecordingEntity.fromJson(Map<String, dynamic> json) => RecordingEntity(
    title: json['title'] as String,
    color: json['color'] as String,
    filePath: json['filePath'] as String,
    date: json['date'] as String,
  );

  @override
  List<Object> get props => [title, color, filePath, date];
}