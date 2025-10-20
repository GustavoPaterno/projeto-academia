import 'package:go_router/go_router.dart';
import 'package:projectacademia/features/presentation/home/view/home_page.dart';
import 'package:projectacademia/features/presentation/login/view/login_page.dart';
import 'package:projectacademia/features/presentation/main/view/main_page.dart';
import 'package:projectacademia/features/presentation/my_training/view/my_training.dart';
import 'package:projectacademia/features/presentation/today/view/today_page.dart';
import 'package:projectacademia/features/presentation/training/view/training.dart';

final appRouter = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/today',
      builder: (context, state) => const TodayPage(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/Training',
      builder: (context, state) => const Training(),
    ),
    GoRoute(
      path: '/MyTraining',
      builder: (context, state) => const MyTraining(),
    ),
  ],
);
