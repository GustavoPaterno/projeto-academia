import 'package:flutter/material.dart';
import 'package:projectacademia/features/presentation/training_executing/view/training_executing.dart';
import '../../data/models/training.dart';
import '../../data/models/exercises.dart';

class TrainingCardWithAddButton extends StatelessWidget {
  final TrainingModel training;
  final VoidCallback onAddExercise;
  final Function(String name, String type) onEditTraining;
  final Function(ExerciseModel exercise, String newName, String newType, int newSeries) onEditExercise;

  const TrainingCardWithAddButton({
    super.key,
    required this.training,
    required this.onAddExercise,
    required this.onEditTraining,
    required this.onEditExercise,
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
            // ========================
            // Nome do treino + editar
            // ========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  training.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Chama função de editar treino
                    onEditTraining(training.name, training.type);
                  },
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Tipo do treino
            Text(
              training.type,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 12),

            // Lista de exercícios
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
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              "${ex.series} séries",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Botão de editar exercício
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                onEditExercise(ex, ex.name, ex.type, ex.series);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // Botões adicionar exercício e treinar
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: Text(
                    "Adicionar exercício",
                    style: TextStyle(color: Theme.of(context).colorScheme.onInverseSurface),
                  ),
                  onPressed: onAddExercise,
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    "Treinar",
                    style: TextStyle(color: Theme.of(context).colorScheme.onInverseSurface),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainingExecuting(training: training),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
