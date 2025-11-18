import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectacademia/data/models/exercises.dart';

class BaseCardListRec extends ConsumerStatefulWidget {
  final String title;
  final String? description;
  final String date;
  final List<ExerciseModel> exercises;

  const BaseCardListRec({
    super.key,
    required this.title,
    this.description,
    required this.date,
    required this.exercises,
  });

  @override
  ConsumerState<BaseCardListRec> createState() => _BaseCardListRecState();
}

class _BaseCardListRecState extends ConsumerState<BaseCardListRec> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => expanded = !expanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: theme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                      color: theme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: theme.onSecondary,
                  ),
                ],
              ),

              // CONTEÚDO EXPANDIDO
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.description != null)
                        Text(
                          widget.description!,
                          style: TextStyle(
                            color: theme.onSecondary,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 12),

                      // LISTA DE EXERCÍCIOS
                      if (widget.exercises.isEmpty)
                        Text(
                          "Nenhum exercício registrado",
                          style: TextStyle(
                            color: theme.onSecondary.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        )
                      else
                        Column(
                          children: widget.exercises.map((ex) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: theme.secondaryContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ex.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.onSecondary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Tipo: ${ex.type}",
                                    style: TextStyle(
                                      color: theme.onSecondary,
                                    ),
                                  ),
                                  Text(
                                    "Séries: ${ex.series}",
                                    style: TextStyle(
                                      color: theme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // LISTA DE EXECUÇÕES
                                  if (ex.executions.isEmpty)
                                    Text(
                                      "Nenhuma execução registrada",
                                      style: TextStyle(
                                        color: theme.onSecondary.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    )
                                  else
                                    Column(
                                      children: ex.executions.map((exec) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Peso: ${exec.peso} kg",
                                                style: TextStyle(
                                                  color: theme.onSecondaryContainer,
                                                ),
                                              ),
                                              Text(
                                                "Reps: ${exec.repeticoes}",
                                                style: TextStyle(
                                                  color: theme.onSecondaryContainer,
                                                ),
                                              ),
                                              Text(
                                                "Hora: ${exec.hora}",
                                                style: TextStyle(
                                                  color: theme.onSecondaryContainer,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                    ],
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
