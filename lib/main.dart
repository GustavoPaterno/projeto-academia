import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Futuramente
// import 'package:flutter_data/flutter_data.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:projectacademia/core/app.dart';

void main(){
  runApp(
    ProviderScope(
      child:  MyApp(),
    )
  );
}