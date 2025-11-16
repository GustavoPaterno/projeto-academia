import 'package:flutter/material.dart';
import 'package:projectacademia/core/routes/app_routes.dart';
import 'package:projectacademia/features/presentation/home/view/home_page.dart';
import 'package:projectacademia/features/presentation/login/view/login_page.dart';
import 'package:projectacademia/features/presentation/main/view/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
  debugShowCheckedModeBanner: false,
  routerConfig: appRouter, // <-- usa o GoRouter
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF333333),
    ).copyWith(
      primary: const Color(0xFF333333),
      primaryContainer: Color(0xFF292929),
      secondary: const Color.fromARGB(249, 130, 25, 1),
      surface: Color(0xFF333333),
    ),
    useMaterial3: true,
  ),
);
  }
}