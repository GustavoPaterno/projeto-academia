import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseAppDrawer extends ConsumerWidget {
  const BaseAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Valores de exemplo
    int currentLevel = 12;
    int nextLevel = 13;
    double progress = 0.53; // 53%

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      width: 300,
      child: Column(
        children: [
          // Cabeçalho
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          Positioned(
                            right: 4,
                            bottom: 4,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Nome do usuário
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Temporario",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Visor de Level
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lv. $currentLevel",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        "${(progress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        "Lv. $nextLevel",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Barra de progresso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 18,
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Opções do menu
          ListTile(
            leading: const Icon(Icons.fitness_center_rounded),
            title: const Text('Meus treinos'),
            subtitle: const Text('Ver meus treinos'),
            onTap: () {},
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Conquistas'),
            subtitle: const Text('Ver conquistas'),
            onTap: () {},
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Missões'),
            subtitle: const Text('Ver missões'),
            onTap: () {},
          ),
          const Divider(thickness: .5),

          const Spacer(flex: 4),

          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Limpar Cache'),
            subtitle: const Text('Clique para limpar cache'),
            onTap: () {},
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações (Teste)'),
            subtitle: const Text('Ir para configurações'),
            onTap: () {},
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Deslogar'),
            subtitle: const Text('Desconectar da conta'),
            onTap: () {},
          ),

          const SizedBox(height: 10),

          // Rodapé
          SizedBox(
            height: 80,
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
