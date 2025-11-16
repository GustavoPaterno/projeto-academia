import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectacademia/widgets/base/base_app_card_rec.dart';
import 'package:projectacademia/widgets/base/base_card_list.dart';
import 'package:projectacademia/widgets/base/base_scaffold.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => HistoricalPageState();
}

class HistoricalPageState extends State<HistoricalPage> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: 'HISTORICO',
      leadingOnTap: BackButton(onPressed: () => context.pop()),
      body: SingleChildScrollView(
        child: Column(children: [
            BaseCardListRec(title: "Teste cartão", description: "Teste de cartão", data: "15/02/2025",)
        ],
      )
    )); 
  }
}