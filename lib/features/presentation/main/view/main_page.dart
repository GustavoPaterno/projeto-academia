import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectacademia/features/presentation/date/view/date_page.dart';
import 'package:projectacademia/features/presentation/home/view/home_page.dart';
import 'package:projectacademia/features/presentation/login/view/login_page.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

final selectedPageProvider = StateProvider<int>((ref) => 1);

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late final PageController _pageController;

  final List<Widget> _pages = const [
    DatePage(),
    HomePage(),
  ];

  @override
  void initState() {
    super.initState();
    final initialPage = ref.read(selectedPageProvider);
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    // atualiza provider e anima PageView
    ref.read(selectedPageProvider.notifier).state = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(selectedPageProvider);

    return BaseAppScaffold(
      leading: 'assets/image1.png',
      title: 'FITNESS',
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // quando o usuário arrasta, atualiza o provider
          ref.read(selectedPageProvider.notifier).state = index;
        },
        children: _pages, 
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          // currentIndex: selectedPage,
          onTap: _onNavTap,
          items: [
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.calendar_today,
                  size: selectedPage == 0 ? 40 : 25,
                  color: selectedPage == 0
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.home,
                  size: selectedPage == 1 ? 45 : 30,
                  color: selectedPage == 1
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: AnimatedContainer(
            //     duration: const Duration(milliseconds: 200),
            //     curve: Curves.easeInOut,
            //     child: Icon(
            //       Icons.person,
            //       size: selectedPage == 2 ? 45 : 30,
            //       color: selectedPage == 2
            //           ? Theme.of(context).colorScheme.secondaryContainer
            //           : Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   label: '',
            // ),
          ],
        ),
      ),
    );
  }
}
