import 'package:flutter/material.dart';

import 'categories.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Categoriser categoriser = Categoriser();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MaterialButton(
            child: const Text('load CSV'),
            onPressed: () {
              categoriser.categorise();
            },
          ),
        ),
      ),
    );
  }
}
