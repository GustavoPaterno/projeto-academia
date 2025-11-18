class ExerciseExecutionModel {
  final String id;
  final double peso;
  final int repeticoes;
  final String hora;

  ExerciseExecutionModel({
    required this.id,
    required this.peso,
    required this.repeticoes,
    required this.hora,
  });

  factory ExerciseExecutionModel.fromJson(Map<String, dynamic> json) {
    return ExerciseExecutionModel(
      id: json['id'] ?? '',
      peso: (json['peso'] ?? 0).toDouble(),
      repeticoes: json['repeticoes'] ?? 0,
      hora: json['hora'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'peso': peso,
      'repeticoes': repeticoes,
      'hora': hora,
    };
  }
}
