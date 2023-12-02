import 'package:Trackefi/features/settings/presentation/view/export_import_meta_data_screen.dart';
import 'package:Trackefi/features/settings/presentation/view/import_settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsListScreen extends StatelessWidget {
  const SettingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(children: [
                ListTile(
                  title: Text('Import settings list'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ImportSettingsScreen())),
                ),
                ListTile(
                  title: Text('Export / import meta data'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ExportImportMetaDataScreen())),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
