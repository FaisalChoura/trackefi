import 'package:expense_categoriser/ui/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/categoriser.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Categoriser categoriser = Categoriser();
    return const MaterialApp(
      home: Layout(),
    );
  }
}
