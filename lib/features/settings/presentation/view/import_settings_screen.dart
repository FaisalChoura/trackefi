import 'package:Trackefi/features/settings/presentation/viewmodel/import_settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsScreen extends ConsumerWidget {
  const ImportSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(importSettingsViewModelProvider.notifier);
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 35,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.chevron_left,
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Import Settings',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: viewModel.getImportSettings(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final importListItem = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(importListItem.currencyId),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      ),
    );
  }
}
