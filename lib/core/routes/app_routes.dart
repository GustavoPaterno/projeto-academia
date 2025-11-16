import 'package:go_router/go_router.dart';
import 'package:projectacademia/features/enter/view/enter_page.dart';
import 'package:projectacademia/features/presentation/historical/view/historical_page.dart';
import 'package:projectacademia/features/presentation/home/view/home_page.dart';
import 'package:projectacademia/features/presentation/login/view/login_page.dart';
import 'package:projectacademia/features/presentation/main/view/main_page.dart';
import 'package:projectacademia/features/presentation/my_training/view/my_training.dart';
import 'package:projectacademia/features/presentation/register/view/register_page.dart';
import 'package:projectacademia/features/presentation/today/view/today_page.dart';
import 'package:projectacademia/features/presentation/training/view/training.dart';

final appRouter = GoRouter(
  initialLocation: '/initial',
  routes: [
    GoRoute(
      path: '/initial',
      builder: (context, state) => const EnterPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
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
      path: '/training',
      builder: (context, state) => const Training(),
    ),
    GoRoute(
      path: '/mytraining',
      builder: (context, state) => const MyTraining(),
    ),
    GoRoute(
      path: '/historical',
      builder: (context, state) => const HistoricalPage(),
    ),
  ],
);
