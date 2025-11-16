import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/core/providers/token_provider.dart';
import 'package:projectacademia/core/providers/user_provider.dart';
import 'package:projectacademia/core/utils/api_user.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    print(">>> LOADING PAGE: inicializando...");
    try {
      final token = ref.read(tokenProvider);

      print(">>> TOKEN LIDO DO PROVIDER:");
      print(token);

      if (token.isEmpty) {
        print(">>> ERRO: token vazio! Voltando para login.");
        if (mounted) context.go('/login');
        return;
      }

      print(">>> Buscando dados do usuário...");

      final user = await ApiService.getCurrentUser(token);

      print(">>> USER CARREGADO COM SUCESSO:");
      print("ID        => ${user.id}");
      print("Nome      => ${user.name}");
      print("Email     => ${user.email}");
      print("Gênero    => ${user.genero}");
      print("Level     => ${user.level}");
      print("Exp       => ${user.exp}");
      print("Birthday  => ${user.birthday}");
      print("");

      print("======= TRAININGS (${user.training.length}) =======");
      for (final t in user.training) {
        print("Treino ID   => ${t.id}");
        print("Nome        => ${t.name}");
        print("Tipo        => ${t.type}");
        print("Exercises   => ${t.exercises.length}");

        if (t.exercises.isEmpty) {
          print("   Nenhum exercício.");
        } else {
          for (var ex in t.exercises) {
            print("   --- EXERCÍCIO ---");
            print("   ID          => ${ex.id}");
            print("   Nome        => ${ex.name}");
            print("   Tipo        => ${ex.type}");
            print("   Séries      => ${ex.series}");
            print("   Repetições  => ${ex.repetitions}");
          }
        }
        print("--------------------------------");

      }

      print("");

      print("======= HISTORICAL (${user.historical.length}) =======");
      for (final h in user.historical) {
        print("Histórico ID => ${h.id}");
        print("Nome         => ${h.name}");
        print("Tipo         => ${h.type}");
        print("Dia          => ${h.dia}");
        print("Exercises    => ${h.exercises.length}");

        if (h.exercises.isEmpty) {
          print("   Nenhum exercício.");
        } else {
          for (var ex in h.exercises) {
            print("   --- EXERCÍCIO ---");
            print("   ID          => ${ex.id}");
            print("   Nome        => ${ex.name}");
            print("   Tipo        => ${ex.type}");
            print("   Séries      => ${ex.series}");
            print("   Repetições  => ${ex.repetitions}");
          }
        }
        print("----------------------------");
      }

      print("\n>>> Usuario salvo no provider!");

      // salvar no provider
      ref.read(userProvider.notifier).state = user;

      print(">>> Usuario salvo no provider!");

      if (!mounted) return;

      print(">>> Indo para /main ...");
      context.go('/main');

    } catch (e) {
      print(">>> ERRO AO CARREGAR USER:");
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar dados: $e")),
      );

      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // opcional
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Carregando dados...",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
