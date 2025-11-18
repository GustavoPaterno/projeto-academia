import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/core/providers/token_provider.dart';
import 'package:projectacademia/core/providers/user_provider.dart';
import 'package:projectacademia/data/models/exercises.dart';
import 'package:projectacademia/data/models/training.dart';
import 'package:projectacademia/widgets/base/base_app_card_rec.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';
import 'package:projectacademia/widgets/base/training_card_with_add_buton.dart';
import 'package:http/http.dart' as http;

class MyTraining extends ConsumerStatefulWidget {
  const MyTraining({super.key});

  @override
  ConsumerState<MyTraining> createState() => MyTrainingState();
}

class MyTrainingState extends ConsumerState<MyTraining> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider); // pega usuário logado

    return BaseAppScaffold(
      title: 'MEUS TREINOS',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // ===========================
          // LISTA DE TREINOS
          // ===========================
          Expanded(
            child: user == null || user.training.isEmpty
                ? Center(
                    child: Text(
                      "Nenhum treino cadastrado.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    itemCount: user.training.length,
                    itemBuilder: (context, index) {
                      final t = user.training[index];

                      return TrainingCardWithAddButton(
                        training: t,
                        onAddExercise: () {
                          showAddExerciseDialog(
                            context: context,
                            onConfirm: (name, type, series) async {
                              addExercise(name, type, series, user.id, t.id );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),

          // ===========================
          // BOTÃO FIXO DE ADICIONAR TREINO
          // ===========================
          Container(
            width: double.infinity,
            height: 150,
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      showAddTrainingDialog(
                         context: context,
                            onConfirm: (name, type) async {
                              addTraining(name, type, user!.id );
                            },
                      );
                    },
                    icon: Icon(Icons.add_circle, size: 50,),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Future addExercise(
  String name,
  String type,
  int series,
  String user_id,
  String training_id,
) async {
  final token = ref.read(tokenProvider);
  final uri = Uri.parse(
      'http://192.168.15.37:8000/user/$user_id/training/$training_id/exercises');

  final newExercise = ExerciseModel(
    // id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: name,
    type: type,
    series: series,
    executions: [],
  );

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(newExercise.toJson()),
    );
    print(" o body: ${response.body} - ${uri}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Exercício adicionado com sucesso!");
      await ref.read(userProvider.notifier).loadUser(user_id, token);

    } else {
      print("Erro ao adicionar exercício: ${response.body}");
    }
  } catch (e) {
    print("Erro na requisição: $e");
  }
}

Future addTraining(
  String name,
  String type,
  String user_id,
) async {
  final token = ref.read(tokenProvider);
  final uri = Uri.parse('http://192.168.15.37:8000/user/$user_id/training');

  final newTraining = {
    "name": name,
    "type": type,
    "exercises": []
  };

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'X-API-Key': token,
      },
      body: jsonEncode(newTraining),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Treino adicionado com sucesso!");
    print(" o body: ${response.body} - ${uri}");
      // 🔥 Agora funciona
      await ref.read(userProvider.notifier).loadUser(user_id, token);

    } else {
      print("Erro ao adicionar treino: ${response.body}");
    }
  } catch (e) {
    print("Erro na requisição: $e");
  }
}



Future<void> showAddTrainingDialog({
  required BuildContext context,
  required Function(String name, String type) onConfirm,
}) async {
  final nameCtrl = TextEditingController();
  final typeCtrl = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Adicionar exercício"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nome")),
            TextField(controller: typeCtrl, decoration: const InputDecoration(labelText: "Tipo")),
            ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () {
              onConfirm(
                nameCtrl.text.trim(),
                typeCtrl.text.trim()
              );
              Navigator.pop(context);
            },
            child: const Text("Adicionar"),
          )
        ],
      );
    },
  );
}


Future<void> showAddExerciseDialog({
  required BuildContext context,
  required Function(String name, String type, int series) onConfirm,
}) async {
  final nameCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final seriesCtrl = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Adicionar exercício"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nome")),
            TextField(controller: typeCtrl, decoration: const InputDecoration(labelText: "Tipo")),
            TextField(controller: seriesCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Séries")),
            ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () {
              onConfirm(
                nameCtrl.text.trim(),
                typeCtrl.text.trim(),
                int.tryParse(seriesCtrl.text.trim()) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text("Adicionar"),
          )
        ],
      );
    },
  );
}
}