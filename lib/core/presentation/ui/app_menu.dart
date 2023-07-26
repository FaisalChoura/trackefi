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
      body: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.money_off_csred_outlined),
                  Text(
                    'Trackefi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
