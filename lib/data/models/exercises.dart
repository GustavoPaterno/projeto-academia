class ExerciseModel {
  final String id;
  final String name;
  final String type;
  final int series;
  final int repetitions;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.type,
    required this.series,
    required this.repetitions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      series: json['series'] ?? 0,
      repetitions: json['repetitions'] ?? 0,
    );
  }
}
