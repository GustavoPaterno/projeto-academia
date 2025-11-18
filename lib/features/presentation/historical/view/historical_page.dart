import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/core/providers/user_provider.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';
import 'package:projectacademia/widgets/base/base_app_card_rec.dart';

class HistoricalPage extends ConsumerWidget {
  const HistoricalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider); // pega o usuário atual

    return BaseAppScaffold(
      title: 'HISTÓRICO',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Caso ainda não existam históricos
            if (user!.historical.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Nenhum histórico encontrado.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),

            // Lista de cards
            for (var h in user!.historical)
              BaseCardListRec(
                title: h.name,
                description: h.type,
                date: h.dia,
                exercises: h.exercises,
              ),
          ],
        ),
      ),
    );
  }
}
