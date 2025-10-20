import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseCardList extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final VoidCallback? onTap;
  const BaseCardList({super.key, required this.title, this.subtitle, this.leading, this.onTap});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // define o raio das bordas
          ),
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          leading: leading == null? null : Icon(leading, size: 50, color: Theme.of(context).colorScheme.onSecondary,),
          title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.bold),),
          subtitle: subtitle == null? null : Text(subtitle!, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.80))),
        ),
      ),
    );
  }
}