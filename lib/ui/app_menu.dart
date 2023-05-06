import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants/pages.dart';

final selectedPageNameProvider = StateProvider<String>((ref) {
  // default value
  return pages.keys.first;
});

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
