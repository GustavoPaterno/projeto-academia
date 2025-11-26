import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectacademia/core/providers/user_provider.dart';

class BaseAppDrawer extends ConsumerWidget {
  const BaseAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Drawer(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // XP atual e próximo nível
    final int currentLevel = user.level;
    final int currentExp = user.exp;
    final int expToNextLevel = (currentLevel + 1) * 50; // exemplo: 100xp por level
    final double progress = currentExp / expToNextLevel;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      width: 300,
      child: Column(
        children: [
          // Cabeçalho
          Container(
            width: double.infinity,
            height: 250,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Avatar e status
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
                          child: const CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Nome do usuário
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Barra de XP
                  Row(
                    children: [
                      // Nível atual
                      Text(
                        '$currentLevel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Barra
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${currentExp} / $expToNextLevel XP',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Próximo nível
                      Text(
                        '${currentLevel + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Menu
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

          const Spacer(),

          // Rodapé
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Limpar Cache'),
            subtitle: const Text('Clique para limpar cache'),
            onTap: () {},
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
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
          const Divider(thickness: .5),
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
