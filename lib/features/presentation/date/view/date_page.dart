import 'package:flutter/material.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class DatePage extends StatefulWidget {
  const DatePage({super.key});

  @override
  State<DatePage> createState() => DatePageState();
}

class DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 30,),
          Flexible(flex: 2,
            child: BaseCardList(title: "Teste", subtitle: "Teste sub", leading: Icons.access_alarm_outlined,)),
            Divider(indent: 40, endIndent: 40, thickness: 0.5,),
          Flexible(flex: 2,
            child: BaseCardList(title: "Teste", subtitle: "Teste sub", leading: Icons.fitness_center_rounded,)),
        ],
      ); 
  }
}