import '../../domain/entities/recording_entity.dart';

class RecordingModel extends RecordingEntity {
  const RecordingModel({
    required super.id,
    required super.title,
    required super.colorValue,
    required super.filePath,
    required super.dateCreated,
    required super.duration,
  });

  // Convert from Entity to Model
  factory RecordingModel.fromEntity(RecordingEntity entity) {
    return RecordingModel(
      id: entity.id,
      title: entity.title,
      colorValue: entity.colorValue,
      filePath: entity.filePath,
      dateCreated: entity.dateCreated,
      duration: entity.duration,
    );
  }

  // Convert to JSON for SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'colorValue': colorValue,
      'filePath': filePath,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'durationInSeconds': duration.inSeconds,
    };
  }

  // Convert from JSON
  factory RecordingModel.fromJson(Map<String, dynamic> json) {
    return RecordingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      colorValue: json['colorValue'] as int,
      filePath: json['filePath'] as String,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(json['dateCreated'] as int),
      duration: Duration(seconds: json['durationInSeconds'] as int),
    );
  }

  // Copy with method for updates
  RecordingModel copyWith({
    String? id,
    String? title,
    int? colorValue,
    String? filePath,
    DateTime? dateCreated,
    Duration? duration,
  }) {
    return RecordingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      colorValue: colorValue ?? this.colorValue,
      filePath: filePath ?? this.filePath,
      dateCreated: dateCreated ?? this.dateCreated,
      duration: duration ?? this.duration,
    );
  }
}