// import 'package:defesa_civil/core/providers/theme_provider.dart';
// import 'package:defesa_civil/core/routes/app_routes.dart';
// import 'package:defesa_civil/core/routes/route_names.dart';
// import 'package:defesa_civil/features/ocorrencia/presentation/widgets/edit_page/ImovelEdit.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class DefCiv extends ConsumerWidget {
//   const DefCiv({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final darkModeAsync = ref.watch(darkModeProvider);
//     final modified = ref.watch(isModifiedProvider);

//     // valor real do tema escuro (fallback = false)
//     final isDarkMode = darkModeAsync.value ?? false;

//     final colorScheme = ColorScheme.fromSeed(
//       seedColor:
//           modified ? Colors.orangeAccent : const Color.fromRGBO(1, 73, 36, 1),
//       brightness: isDarkMode ? Brightness.dark : Brightness.light,
//     ).copyWith(
//       surface: isDarkMode
//           ? const Color(0xFF1E1E1E) // fundo escuro
//           : const Color(0xFFFFFFFF), // fundo claro mais suave
//     );

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Defesa Cívil',
//       initialRoute: RouteNames.splash,
//       routes: AppRoutes.getRoutes(context),
//       theme: ThemeData(
//         colorScheme: colorScheme,
//         scaffoldBackgroundColor: isDarkMode
//             ? const Color.fromARGB(255, 43, 42, 42) // fundo escuro
//             : const Color(0xFFFFFFFF), // fundo claro mais suave
//         appBarTheme: AppBarTheme(
//           backgroundColor: colorScheme.primaryContainer,
//           centerTitle: true,
//         ),
//       ),
//     );
//   }
// }

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
      seedColor: const Color.fromARGB(249, 130, 25, 1),
    ).copyWith(
      primary: const Color.fromARGB(249, 130, 25, 1),
      primaryContainer: Colors.orange,
      secondary: const Color.fromARGB(249, 130, 25, 1),
      surface: Colors.white,
    ),
    useMaterial3: true,
  ),
);
  }
}