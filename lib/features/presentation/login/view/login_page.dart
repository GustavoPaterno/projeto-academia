import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController(text: 'piu2');
  final TextEditingController _passwordController = TextEditingController(text: '123456');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final uri = Uri.parse('http://192.168.15.37:8000/token');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': _nameController.text,
          'password': _passwordController.text,
        }),
      );
      print(">>> TESTE: response - ${response.body}");
      if (response.statusCode == 200) {
        // 🔹 Sucesso → navegar
        context.go('/main');
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
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 10),
                child: Image.asset('assets/image1.png'),
              ),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 400, left: 40, right: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onInverseSurface,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // 🔹 Campo de nome
                          TextFormField(
                            controller: _nameController,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Digite seu nome' : null,
                            style: TextStyle(
                              color: colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: colorScheme.onInverseSurface,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: colorScheme.onInverseSurface,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorScheme.onInverseSurface,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 🔹 Campo de senha
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Digite sua senha' : null,
                            style: TextStyle(
                              color: colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: colorScheme.onInverseSurface,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: colorScheme.onInverseSurface,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorScheme.onInverseSurface,
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // 🔹 Botão de login
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.onInverseSurface,
                                foregroundColor: colorScheme.surface,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
