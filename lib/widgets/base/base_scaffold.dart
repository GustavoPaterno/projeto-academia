import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectacademia/widgets/base/base_app_bar.dart';
import 'package:projectacademia/widgets/base/base_drawer.dart';

class BaseAppScaffold extends ConsumerWidget {
  final String title;
  final Widget body;
  final Widget? bottomNavigationBar; // opcional
  final Widget? floatingActionButton; // opcional
  final Color? backgroundColor; // opcional
  final Widget? bottomSheet; // opcional
  final String? leading;
  final Widget? leadingOnTap;
  final double? toolBarHeight;

  const BaseAppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.bottomSheet,
    this.leading,
    this.toolBarHeight,
    this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawerEdgeDragWidth: 70, 
      appBar: BaseAppBar(title: title, icons: leading, leadingOnTap: leadingOnTap, toolbarHeight: toolBarHeight,),
      endDrawer: BaseAppDrawer(),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx < -10) {
                Scaffold.of(context).openEndDrawer();
              }
            },
            child: body,
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar, // se for null, não aparece
      floatingActionButton: floatingActionButton, // se for null, não aparece
      backgroundColor: backgroundColor,
      bottomSheet: bottomSheet,
    );
  }
}