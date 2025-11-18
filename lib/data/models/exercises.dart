import 'package:projectacademia/data/models/executions.dart';

class ExerciseModel {
  final String? id;
  final String name;
  final String type;
  final int series;
  final List<ExerciseExecutionModel> executions;

  ExerciseModel({
    this.id,
    required this.name,
    required this.type,
    required this.series,
    required this.executions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'], // <-- agora ele lê o ID vindo da API
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      series: json['series'] ?? 0,
      executions: (json['executions'] as List<dynamic>? ?? [])
          .map((e) => ExerciseExecutionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'series': series,
      'executions': executions
          .map((exec) => exec.toJson())
          .toList(),
    };
  }
}
