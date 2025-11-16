import 'package:projectacademia/data/models/historical.dart';
import 'package:projectacademia/data/models/training.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? descricao;
  final String birthday;
  final String genero;
  final int level;
  final int exp;
  final List<TrainingModel> training;
  final List<HistoricalModel> historical;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.descricao,
    required this.birthday,
    required this.genero,
    required this.level,
    required this.exp,
    required this.training,
    required this.historical,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      descricao: json['descricao'],
      birthday: json['birthday'] ?? '',
      genero: json['genero'] ?? '',
      level: json['level'] ?? 0,
      exp: json['exp'] ?? 0,
      training: (json['training'] as List)
          .map((t) => TrainingModel.fromJson(t))
          .toList(),
      historical: (json['historical'] as List)
          .map((h) => HistoricalModel.fromJson(h))
          .toList(),
    );
  }
}
