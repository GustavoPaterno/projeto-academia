import 'package:flutter/material.dart';
import '../../data/models/training.dart'; // ajuste para seu path real

class TrainingCardWithAddButton extends StatelessWidget {
  final TrainingModel training;
  final VoidCallback onAddExercise;

  const TrainingCardWithAddButton({
    super.key,
    required this.training,
    required this.onAddExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ Nome do treino
            Text(
              training.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),

            // ⭐ Tipo do treino
            Text(
              training.type,
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 12),

            // ⭐ Lista de exercícios
            if (training.exercises.isEmpty)
              Text(
                "Nenhum exercício ainda.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: training.exercises.map((ex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nome + tipo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ex.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              ex.type,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),

                        // Séries
                        Text(
                          "${ex.series} séries",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // ⭐ Botão de adicionar exercício
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                icon: Icon(
                  Icons.add,
                  color:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                label: Text(
                  "Adicionar exercício",
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                onPressed: onAddExercise,
              ),
            )
          ],
        ),
      ),
    );
  }
}
