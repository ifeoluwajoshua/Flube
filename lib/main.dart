import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';

void main() {
  runApp(ProviderScope(
    observers: [Logger()],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flube',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeView(),
    );
  }
}


class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}