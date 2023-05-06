import 'package:flutter/material.dart';

import 'services/categoriser.dart';

void main() {
  runApp(const MainApp());
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

class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [SizedBox(width: 240, child: AppMenu())],
    );
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = ['Categories'];
    return Scaffold(
      appBar: AppBar(title: const Text('Categoriser')),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(menuItems[index]),
            );
          }),
    );
  }
}
