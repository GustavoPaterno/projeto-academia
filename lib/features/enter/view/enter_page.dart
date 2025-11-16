import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.expand(
      child: Stack(
        children: [
          // Fundo com imagem
          Image.asset(
            'assets/image2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Conteúdo principal (botões)
          Align(
            alignment: const Alignment(0, 0.6), // abaixo da metade da tela
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                  context,
                  label: "Entrar",
                  onPressed: () {
                    context.push('/login');
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  context,
                  label: "Cadastrar",
                  onPressed: () {
                    context.push('/register');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 250, height: 55),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onInverseSurface.withOpacity(0.15),
          foregroundColor: colorScheme.onInverseSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: colorScheme.onInverseSurface.withOpacity(0.5),
            ),
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
