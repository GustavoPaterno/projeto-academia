import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseAppBar extends ConsumerWidget implements PreferredSizeWidget  {
  final String title;
  final String? icons;
  final Widget? leadingOnTap;
  final double? toolbarHeight;
  const BaseAppBar({super.key, required this.title, this.icons, this.toolbarHeight, this.leadingOnTap});

   @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkMode = ref.watch(darkModeProvider).value ?? false;
    final theme = Theme.of(context).colorScheme;

    return AppBar(
      leading: leadingOnTap ??
          (icons != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                  child: Image.asset(
                    icons!,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                )
              : null),
      title: Text(title, style: TextStyle(color: Colors.white),),
      toolbarHeight: toolbarHeight ?? 100,
      backgroundColor: theme.primaryContainer,
      centerTitle: true,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 35); 
}
