import 'package:flutter/material.dart';

class ExportImportMetaDataScreen extends StatelessWidget {
  const ExportImportMetaDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 36),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    'Import / export meta data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(children: const [
                  ListTile(title: Text('Export meta all data'), onTap: null),
                ]),
              ),
            ])));
  }
}
