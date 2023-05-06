import 'package:flutter/material.dart';

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
