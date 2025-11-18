import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectacademia/core/utils/api_user.dart';
import 'package:projectacademia/data/models/user.dart';


class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  // 👉 Carregar usuário do backend
  Future<void> loadUser(String userId, String token) async {
    final uri = Uri.parse('${ApiService.baseUrl}/user/me');

    try {
      final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'X-API-Key': token,
        'Content-Type': 'application/json',
      },
    );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data: ${data}");
        state = UserModel.fromJson(data); // 🔥 atualiza o provider
        print("Usuário carregado!");
      } else {
        print("Erro ao carregar usuário: ${response.body}");
      }
    } catch (e) {
      print("Erro no loadUser: $e");
    }
  }

  // 👉 Salvar usuário logado após login
  void setUser(UserModel user) {
    state = user;
  }

  // 👉 Limpar sessão
  void logout() {
    state = null;
  }
}


final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
  (ref) => UserNotifier(),
);