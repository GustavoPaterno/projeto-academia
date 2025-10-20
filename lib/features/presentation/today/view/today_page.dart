import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/widgets/base/base_app_card.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

final TrainTodayPageSelectProvider = StateProvider<int>((ref) => 0);

class TodayPage extends ConsumerStatefulWidget {
  const TodayPage({super.key});

  @override
  ConsumerState<TodayPage> createState() => TodayPageState();
}

class TodayPageState extends ConsumerState<TodayPage> {
  final _pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(TrainTodayPageSelectProvider);

    return BaseAppScaffold(
      title: 'TREINO DO DIA',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              onPageChanged: (value) {
                ref.read(TrainTodayPageSelectProvider.notifier).state = value;
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Clicou no card do dia");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const BaseAppCard(
                      title: 'Cadeira Extensora',
                      categoria: 'Perna',
                      image: 'assets/image1.png',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                final isSelected = index == selectedPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: isSelected ? 25 : 10,
                  width: isSelected ? 25 : 10,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Color(0xFFBBBBBB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
