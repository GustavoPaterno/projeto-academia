import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  @override
  void initState() {
    super.initState();
    initialize();
  }
  Future<void> initialize() async{
    
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

