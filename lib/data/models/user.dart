// // import 'package:flutter_data/flutter_data.dart';

// // part 'user.freezed.dart';
// // part 'user.g.dart';

// // @DataRepository([])
// // @Freezed
// // class User {
// //   final String id;          // UUID do backend
// //   final String name;
// //   final String email;
// //   final String? descricao;
// //   final String birthday;    // pode ser DateTime também
// //   final String password;
// //   final String? genero;
// //   final int level;
// //   final int exp;
// //   final String? photo;      // URL ou caminho
// //   final List<Training> training;
// //   final List<Historical> historical;

// //   User({
// //     required this.id,
// //     required this.name,
// //     required this.email,
// //     this.descricao,
// //     required this.birthday,
// //     required this.password,
// //     this.genero,
// //     required this.level,
// //     required this.exp,
// //     this.photo,
// //     this.training = const [],
// //     this.historical = const [],
// //   });

// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       id: json['id'] as String,
// //       name: json['name'] as String,
// //       email: json['email'] as String,
// //       descricao: json['descricao'] as String?,
// //       birthday: json['birthday'] as String, // se quiser DateTime: DateTime.parse(json['birthday'])
// //       password: json['password'] as String,
// //       genero: json['genero'] as String?,
// //       level: json['level'] as int,
// //       exp: json['exp'] as int,
// //       photo: json['photo'] as String?,
// //       training: (json['training'] as List<dynamic>?)
// //               ?.map((e) => Training.fromJson(e as Map<String, dynamic>))
// //               .toList() ??
// //           [],
// //       historical: (json['historical'] as List<dynamic>?)
// //               ?.map((e) => Historical.fromJson(e as Map<String, dynamic>))
// //               .toList() ??
// //           [],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'name': name,
// //       'email': email,
// //       'descricao': descricao,
// //       'birthday': birthday,
// //       'password': password,
// //       'genero': genero,
// //       'level': level,
// //       'exp': exp,
// //       'photo': photo,
// //       'training': training.map((t) => t.toJson()).toList(),
// //       'historical': historical.map((h) => h.toJson()).toList(),
// //     };
// //   }
// // }

// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:flutter_data/flutter_data.dart';
// import 'training.dart';
// import 'historical.dart';

// part 'user.freezed.dart';
// part 'user.g.dart';

// @DataRepository([])
// @freezed
// class User with _$User {
//   const factory User({
//     required String id,
//     required String name,
//     required String email,
//     String? descricao,
//     required String birthday,
//     required String password,
//     required String genero,
//     required int level,
//     required int exp,
//     required List<Training> training,
//     required List<Historical> historical,
//   }) = _User;

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
// }
