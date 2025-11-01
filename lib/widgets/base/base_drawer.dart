import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseAppDrawer extends ConsumerWidget {
  const BaseAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            width: double.infinity,
            height: 221,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Avatar
                  Flexible(
                    flex: 6,
                    child: Row(
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
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
                                  backgroundColor: Colors.green, // status online
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Nome do usuário
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Temporario",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
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
            onTap: () {
              // Ação do botão
            },
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Conquistas'),
            subtitle: const Text('Ver conquistas'),
            onTap: () {
              // Ação do botão
            },
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Missões'),
            subtitle: const Text('Ver missões'),
            onTap: () {
              // Ação do botão
            },
          ),
          const Divider(thickness: .5),

          const Spacer(flex: 4),

          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Limpar Cache'),
            subtitle: const Text('Clique para limpar cache'),
            onTap: () {
              // Ação do botão
            },
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações (Teste)'),
            subtitle: const Text('Ir para configurações'),
            onTap: () {
              // Ação do botão
            },
          ),
          const Divider(thickness: .5),

          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Deslogar'),
            subtitle: const Text('Desconectar da conta'),
            onTap: () {
              // Ação do botão
            },
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
