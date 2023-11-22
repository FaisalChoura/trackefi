import 'package:Trackefi/features/settings/presentation/import_settings_screen.dart';
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
            Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(children: [
                ListTile(
                  title: Text('Import Settings'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImportSettingsScreen())),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
