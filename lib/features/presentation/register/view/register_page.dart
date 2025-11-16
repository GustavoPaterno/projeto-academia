import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController(text: "t");
  final _emailController = TextEditingController(text: "t@gmail");
  final _passwordController = TextEditingController(text: "123456");
  final _confirmController = TextEditingController(text: "123456");
  String? _gender;
  bool _isLoading = false;

  Future<void> _register() async {
    print(">>> teste: entrou no register");
    setState(() => _isLoading = true);

    final uri = Uri.parse('http://192.168.15.37:8000/user');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": _nameController.text,
          "password": _passwordController.text,
          "email": _emailController.text,
          "birthday": "null",
          "genero": _gender,
          "level": 0,
          "exp": 0
        }),
      );
      print("response: ${response.statusCode} ${response.body}");
      if (response.statusCode == 201) {
        
        _showSuccessDialog();
      } else {
        // 🔹 Erro → mostrar mensagem do servidor, se existir
        final message = _parseError(response.body);
        _showErrorDialog('Erro ao fazer login: $message');
      }
    } catch (e) {
      // 🔹 Erro de conexão, timeout, etc
      _showErrorDialog('Erro de conexão. Verifique o servidor ou a rede.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _parseError(String body) {
    try {
      final json = jsonDecode(body);
      if (json is Map && json['detail'] != null) {
        return json['detail'].toString();
      }
    } catch (_) {}
    return 'Resposta inesperada do servidor.';
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Falha no login'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _unfocus() => FocusScope.of(context).unfocus();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929), // igual ao login
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              const Text(
                "Criar Conta",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // NOME
              _buildInputField(
                controller: _nameController,
                label: "Nome",
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // EMAIL
              _buildInputField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // GÊNERO
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  dropdownColor: const Color(0xFF333333),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  iconEnabledColor: Colors.white70,
                  value: _gender,
                  hint: const Text("Gênero", style: TextStyle(color: Colors.white54)),
                  items: const [
                    DropdownMenuItem(
                      value: "Masculino",
                      child: Text("Masculino", style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Feminino",
                      child: Text("Feminino", style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: "Outro",
                      child: Text("Outro", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (value) => setState(() => _gender = value),
                ),
              ),
              const SizedBox(height: 20),

              // SENHA
              _buildInputField(
                controller: _passwordController,
                label: "Senha",
                icon: Icons.lock,
                obscure: true,
              ),
              const SizedBox(height: 20),

              // CONFIRMAR SENHA
              _buildInputField(
                controller: _confirmController,
                label: "Confirmar senha",
                icon: Icons.lock_outline,
                obscure: true,
              ),
              const SizedBox(height: 35),

              // BOTÃO
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Registrar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // COMPONENTE DE INPUT DO SEU LOGIN
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF333333),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
  void _showSuccessDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent, size: 40),
            SizedBox(width: 10),
            Text(
              "Conta criada!",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: const Text(
          "Sua conta foi criada com sucesso.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // fecha o popup
              context.go('/login');        // vai para o login
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

}

