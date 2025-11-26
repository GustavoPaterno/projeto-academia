import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/core/providers/token_provider.dart';
import 'package:projectacademia/core/providers/user_provider.dart';
import 'package:projectacademia/core/utils/api_user.dart';
import 'package:projectacademia/data/models/training.dart';
import 'package:projectacademia/data/models/user.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final TrainingExecutingPageSelectProvider = StateProvider<int>((ref) => 0);

class TrainingExecuting extends ConsumerStatefulWidget {
  final TrainingModel training;
  
  TrainingExecuting({super.key, required this.training});

  @override
  ConsumerState<TrainingExecuting> createState() => TrainingExecutingState();
}

class TrainingExecutingState extends ConsumerState<TrainingExecuting> {
  final _pageController = PageController(viewportFraction: 1);

  // Controllers para cada exercício e cada série
  late List<List<TextEditingController>> pesoControllers;
  late List<List<TextEditingController>> repeticaoControllers;

  @override
  void initState() {
    super.initState();

    // Cria listas de controllers para cada exercício e cada série
    pesoControllers = widget.training.exercises.map((exercise) {
      return List.generate(exercise.series, (_) => TextEditingController());
    }).toList();

    repeticaoControllers = widget.training.exercises.map((exercise) {
      return List.generate(exercise.series, (_) => TextEditingController());
    }).toList();
  }

  @override
  void dispose() {
    for (var exList in pesoControllers) {
      for (var c in exList) c.dispose();
    }
    for (var exList in repeticaoControllers) {
      for (var c in exList) c.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void salvarExecucao() async {
  try {
    final user = ref.watch(userProvider);
    final userId = user!.id;
    final token = ref.read(tokenProvider);
    print("userId: ${userId} ${token}");

    // Monta os dados dos exercícios
    List<Map<String, dynamic>> exercisesData = [];

    for (int i = 0; i < widget.training.exercises.length; i++) {
      final exercise = widget.training.exercises[i];
      List<Map<String, dynamic>> seriesData = [];

      for (int j = 0; j < exercise.series; j++) {
        seriesData.add({
          'peso': double.tryParse(pesoControllers[i][j].text) ?? 0,
          'repeticoes': int.tryParse(repeticaoControllers[i][j].text) ?? 0,
          'hora': TimeOfDay.now().format(context),
        });
      }

      exercisesData.add({
        'name': exercise.name,
        'type': exercise.type,
        'series': exercise.series,
        'seriesData': seriesData,
      });
    }

    await salvarExecucaoBackend(
      user,
      userId,
      token,
      'Treino ${widget.training.name}',
      widget.training.type,
      DateTime.now().toString().split(' ')[0], // dia atual
      exercisesData,
      ref
    );
    await ref.read(userProvider.notifier).loadUser(userId, token);
    context.go('/historical');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Treino salvo com sucesso!")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro ao salvar treino: $e")),
    );
    print("Erro ao salvar treino: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(TrainingExecutingPageSelectProvider);

    return BaseAppScaffold(
      title: 'TREINO DE ${widget.training.type.toUpperCase()}',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 2, // se tiver mais dias/treinos, ajustar
              onPageChanged: (value) {
                ref.read(TrainingExecutingPageSelectProvider.notifier).state = value;
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Text(widget.training.name,
                            style: const TextStyle(color: Colors.white, fontSize: 20)),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.training.exercises.length,
                            itemBuilder: (context, exIndex) {
                              final exercise = widget.training.exercises[exIndex];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exercise.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: exercise.series,
                                        itemBuilder: (context, seriesIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        pesoControllers[exIndex][seriesIndex],
                                                    keyboardType:
                                                        const TextInputType.numberWithOptions(
                                                            decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText: "Peso série ${seriesIndex + 1}",
                                                      labelStyle: const TextStyle(
                                                          color: Colors.white70),
                                                      border: const OutlineInputBorder(),
                                                    ),
                                                    style:
                                                        const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        repeticaoControllers[exIndex][seriesIndex],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Repetições série ${seriesIndex + 1}",
                                                      labelStyle: const TextStyle(
                                                          color: Colors.white70),
                                                      border: const OutlineInputBorder(),
                                                    ),
                                                    style:
                                                        const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: salvarExecucao,
                            child: const Text("Concluir Treino"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // indicadores da página
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                final isSelected = index == selectedPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: isSelected ? 25 : 10,
                  width: isSelected ? 25 : 10,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : const Color(0xFFBBBBBB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> salvarExecucaoBackend(
  UserModel user,
  String userId,
  String token,
  String historicalName,
  String historicalType,
  String historicalDia,
  List<Map<String, dynamic>> exercisesData,
  ref
) async {
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'X-API-Key': token,
  };

  // 1️⃣ Cria o histórico
  final historicoBody = jsonEncode({
    'name': historicalName,
    'type': historicalType,
    'dia': historicalDia,
    'exercises': [],
  });

  final historicoResponse = await http.post(
    Uri.parse('${ApiService.baseUrl}/user/$userId/historical'),
    headers: headers,
    body: historicoBody,
  );

  if (historicoResponse.statusCode != 200 && historicoResponse.statusCode != 201) {
    throw Exception('Erro ao criar histórico: ${historicoResponse.body}');
  }

  final historicoData = jsonDecode(historicoResponse.body);
  final historicalId = historicoData['id'];
  // 2️⃣ Para cada exercício, cria no backend e depois adiciona as execuções
  for (var exercise in exercisesData) {
    final exerciseBody = jsonEncode({
      'name': exercise['name'],
      'type': exercise['type'],
      'series': exercise['series'],
      'repetitions': exercise['repetitions'],
    });

    final exerciseResponse = await http.post(
      Uri.parse('${ApiService.baseUrl}/user/$userId/historical/$historicalId/exercises'),
      headers: headers,
      body: exerciseBody,
    );

    if (exerciseResponse.statusCode != 200 && exerciseResponse.statusCode != 201) {
      throw Exception('Erro ao criar exercício: ${exerciseResponse.body}');
    }

    final exerciseData = jsonDecode(exerciseResponse.body);
    final exerciseId = exerciseData['id'];

    // 3️⃣ Criar execuções (peso/repetições por série)
    for (int i = 0; i < exercise['seriesData'].length; i++) {
      final serie = exercise['seriesData'][i];
      final execBody = jsonEncode({
        'peso': serie['peso'],
        'repeticoes': serie['repeticoes'],
        'hora': serie['hora'],
      });

      final execResponse = await http.post(
        Uri.parse('${ApiService.baseUrl}/user/$userId/historical/$historicalId/exercises/$exerciseId'),
        headers: headers,
        body: execBody,
      );

      if (execResponse.statusCode != 200 && execResponse.statusCode != 201) {
        throw Exception('Erro ao criar execução: ${execResponse.body}');
      }
    }
  }

  Level().expUp(user, ref);
  await ref.read(userProvider.notifier).loadUser(user.id, token);
}


class Level{
  
  void expUp(UserModel user, ref){
    int exp = user.getExp;
    int level = user.getLevel;
    exp += 20;
    if(exp >= (level +1) * 50){
      levelUp(user, ref);
    }
    saveLevelExpBackend(
      user.id,
      ref.read(tokenProvider),
      level,
      exp,
    );
  }

  void levelUp(UserModel user, ref){
    int level = user.getLevel;
    int exp = user.getExp;
    level +=1;
    exp = 0;
    saveLevelExpBackend(
      user.id,
      ref.read(tokenProvider),
      level,
      exp,
    );
  }

  Future<void> saveLevelExpBackend(
    String userId,
    String token,
    int level,
    int exp,
  ) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'X-API-Key': token,
    };

    final body = jsonEncode({
      'level': level,
      'exp': exp,
    });

     final execResponse = await http.post(
        Uri.parse('${ApiService.baseUrl}/user/$userId'),
        headers: headers,
        body: body,
      );
    
    print("usuario atualizado com sucesso");
  }
}