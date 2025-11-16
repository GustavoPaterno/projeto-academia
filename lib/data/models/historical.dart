import 'package:projectacademia/data/models/exercises.dart';

class HistoricalModel {
  final String id;
  final String name;
  final String type;
  final String dia;
  final List<ExerciseModel> exercises;

  HistoricalModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dia,
    required this.exercises,
  });

  factory HistoricalModel.fromJson(Map<String, dynamic> json) {
    return HistoricalModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      dia: json['dia'] ?? '',
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseModel.fromJson(e))
          .toList(),
    );
  }
}
