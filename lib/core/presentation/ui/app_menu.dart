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
    String selectedItem = ref.watch(selectedPageNameProvider);

    List<MenuItem> menuItems = [
      MenuItem(
        icon: Icons.category,
        title: ScreenRoutes.categories,
      ),
      MenuItem(
        icon: Icons.file_present,
        title: ScreenRoutes.csvImport,
      ),
      MenuItem(
        icon: Icons.bar_chart_outlined,
        title: ScreenRoutes.reports,
      ),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 36, bottom: 24, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.money_off_csred_outlined),
                Text(
                  'Trackefi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: menuItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(menuItems[index].title),
                      leading: Icon(menuItems[index].icon),
                      selected: selectedItem == menuItems[index].title,
                      onTap: () => {
                        if (ref.read(selectedPageNameProvider.notifier).state !=
                            menuItems[index].title)
                          {
                            ref.read(selectedPageNameProvider.notifier).state =
                                menuItems[index].title
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

class MenuItem {
  String title;
  IconData icon;
  MenuItem({required this.icon, required this.title});
}
