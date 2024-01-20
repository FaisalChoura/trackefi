import 'package:Trackefi/features/settings/data/store/import_settings_list_store.dart';
import 'package:Trackefi/features/settings/presentation/ui/import_settings_dialog.dart';
import 'package:Trackefi/features/settings/presentation/viewmodel/import_settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsScreen extends ConsumerWidget {
  const ImportSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(importSettingsViewModelProvider.notifier);
    final importSettingsList = ref.watch(importSettingsListProvider);
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
                const Text(
                  'Import Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: importSettingsList.length,
                  itemBuilder: (context, index) {
                    final importSettings = importSettingsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(importSettings.name),
                        onTap: () => openImportSettingsDialog(
                            context, importSettings, false),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              viewModel.deleteImportSettings(importSettings.id),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
