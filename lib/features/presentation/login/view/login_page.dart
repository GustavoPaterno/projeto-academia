import 'package:flutter/material.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
        return Column(
        children: [
          SizedBox(height: 30,),
          Flexible(flex: 2,
            child: BaseCardList(title: "Teste", subtitle: "Teste sub", leading: Icons.access_alarm_outlined,)),
            
        ],
      ); 
  }
}