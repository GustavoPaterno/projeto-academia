import 'package:projectacademia/data/models/exercises.dart';

class TrainingModel {
  final String id;
  final String name;
  final String type;
  final List<ExerciseModel> exercises;

  TrainingModel({
    required this.id,
    required this.name,
    required this.type,
    required this.exercises,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseModel.fromJson(e))
          .toList(),
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}
