import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseCardListRec extends ConsumerStatefulWidget {
  final String title;
  final String? description;
  final String data;

  const BaseCardListRec({
    super.key,
    required this.title,
    this.description,
    required this.data,
  });

  @override
  ConsumerState<BaseCardListRec> createState() => _BaseCardListRecState();
}

class _BaseCardListRecState extends ConsumerState<BaseCardListRec> {
  bool expanded = false; // controla se o card está expandido

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() => expanded = !expanded); // alterna o estado
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          // altura muda conforme expandido ou não
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // título e ícone de expansão
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  Text("15/02/2025", style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),

                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
              // conteúdo extra visível só quando expandido
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ 
                      Text(
                        widget.description ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 14,
                        ),
                      ),
                      // Row(children: [
                      //   IconButton(onPressed: (){}, icon: Icon(Icons.add), style: ButtonStyle(
                      //   side: WidgetStateProperty.all(
                      //     BorderSide(color: Colors.blue, width: 2), // cor e espessura da borda
                      //   ),
                      //   foregroundColor: WidgetStateProperty.all(Colors.black),
                      //   backgroundColor: WidgetStateProperty.all(Colors.white),
                      // ),),
                      // ],)
                  ]),
                ),
                crossFadeState: expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
