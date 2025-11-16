import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectacademia/data/models/user.dart';

class ApiService {
  static const baseUrl = 'http://192.168.15.37:8000';

  static Future<UserModel> getCurrentUser(String token) async {
    final uri = Uri.parse('$baseUrl/user/me');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'X-API-Key': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar usuário: ${response.body}");
    }

    final json = jsonDecode(response.body);
    return UserModel.fromJson(json);
  }
}
