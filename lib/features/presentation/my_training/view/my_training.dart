import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class MyTraining extends ConsumerStatefulWidget {
  const MyTraining({super.key});

  @override
  ConsumerState<MyTraining> createState() => MyTrainingState();
}

class MyTrainingState extends ConsumerState<MyTraining> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: 'MEUS TREINOS',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: Column(
        children: [
          // Área que vai rolar
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: 5,
              itemBuilder: (context, index) {
                return BaseCardList(
                  title: "TREINO ${index + 1}",
                  subtitle: "VER TREINO DE HOJE",
                  leading: Icons.fitness_center,
                );
              },
            ),
          ),
          SizedBox(height: 12),
          // Rodapé fixo
          Container(
            width: double.infinity,
            height: 150,
            color: Theme.of(context).colorScheme.onSecondary,
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Container(width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Theme.of(context).colorScheme.primaryContainer,),child: Center(child: Icon(Icons.add_circle, color: Theme.of(context).colorScheme.onSecondary, size: 50,),),), ),
            ),
        ],
      ),
    );
  }
}
