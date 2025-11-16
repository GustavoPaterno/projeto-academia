import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            BaseCardList(
              title: "TREINO DE HOJE",
              subtitle: "VER TREINO DE HOJE",
              leading: Icons.access_alarm_outlined,
              onTap: () => context.push('/today'),
            ),
            const Divider(indent: 40, endIndent: 40, thickness: 0.5),
            BaseCardList(
              title: "TREINOS",
              subtitle: "VER TREINOS",
              leading: Icons.fitness_center_rounded,
              onTap: () => context.push('/training'),
            ),
            const Divider(indent: 40, endIndent: 40, thickness: 0.5),
            BaseCardList(
              title: "MEUS TREINOS",
              subtitle: "VER MEUS TREINOS",
              leading: Icons.sports_gymnastics,
              onTap: () => context.push('/mytraining'),
            ),
            const Divider(indent: 40, endIndent: 40, thickness: 0.5),
            BaseCardList(
              title: "HISTÓRICO DE TREINOS",
              subtitle: "VER HISTÓRICO DE TREINOS",
              leading: Icons.description,
              onTap: () => context.push('/historical'),
            ),
          ],
        ),
      ),
    ),
  );
}

}