import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class Training extends ConsumerStatefulWidget {
  const Training({super.key});

  @override
  ConsumerState<Training> createState() => TrainingState();
}

class TrainingState extends ConsumerState<Training> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: 'TREINOS',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: SingleChildScrollView(
        child: Column(children: [
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
      BaseCardList(title: "TREINO DE HOJE", subtitle: "VER TREINO DE HOJE", leading: Icons.access_alarm_outlined),
        ],)
      )); 
  }
}