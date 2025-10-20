import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseAppCard extends ConsumerWidget{
  final String title;
  final String categoria;
  final String? image;
  const BaseAppCard({super.key, required this.title, required this.categoria, required this.image});

  
   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriaToUpper = categoria.toUpperCase();
    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 16,
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side:
                BorderSide(color: Colors.transparent, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 12,
                  child: image != null
                      ? Image.asset(image!)
                      : Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 0), // x, y
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                ),
                SizedBox(height: 30,),
                Flexible(
                  flex: 10,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // ajuste o raio que quiser
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                            ),
                            onPressed: null, 
                            child: Text(categoriaToUpper, style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer, fontWeight: FontWeight.bold),)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 25, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 80,),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              onPressed: null,
                              child: Text(
                                'TREINAR',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            
              ],
            ),
          ) 
          
      ),
    );
  } 
}
