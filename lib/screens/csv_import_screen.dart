import 'package:flutter/material.dart';

import '../services/categoriser.dart';

class CsvImportScreen extends StatelessWidget {
  const CsvImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Categoriser categoriser = Categoriser();
    return Scaffold(
      appBar: AppBar(title: const Text('CSV import')),
      body: Center(
        child: MaterialButton(
          child: const Text('load CSV'),
          onPressed: () {
            categoriser.categorise();
          },
        ),
      ),
    );
  }
}
