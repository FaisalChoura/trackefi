import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

final selectedPageNameProvider = StateProvider<String>((ref) {
  return pages.keys.first;
});

class AppMenu extends ConsumerWidget {
  const AppMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> menuItems = [
      ScreenRoutes.categories,
      ScreenRoutes.csvImport,
      ScreenRoutes.reports,
      ScreenRoutes.reportsList,
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Categoriser')),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(menuItems[index]),
              onTap: () => {
                if (ref.read(selectedPageNameProvider.notifier).state !=
                    menuItems[index])
                  {
                    ref.read(selectedPageNameProvider.notifier).state =
                        menuItems[index]
                  }
              },
            );
          }),
    );
  }
}
