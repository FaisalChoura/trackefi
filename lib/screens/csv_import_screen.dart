import 'package:flutter/material.dart';

class CsvImportScreen extends StatelessWidget {
  const CsvImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSV import')),
      body: const Center(
        child: Text('CSV import'),
      ),
    );
  }
}
