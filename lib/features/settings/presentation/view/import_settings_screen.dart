import 'package:flutter/material.dart';

class ImportSettingsScreen extends StatelessWidget {
  const ImportSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView(children: []),
            ),
          ],
        ),
      ),
    );
  }
}
