import 'package:expense_categoriser/services/categories_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/csv_files_provider.dart';
import '../services/csv_reader_service.dart';

class CsvImportScreen extends ConsumerWidget {
  CsvReaderService csvReaderService = CsvReaderService();
  CsvImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csvFiles = ref.watch(csvFilesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('CSV import')),
      body: Column(
        children: [
          for (var file in csvFiles)
            MaterialButton(
                child: Text(file.name),
                onPressed: () =>
                    ref.read(csvFilesProvider.notifier).removeFile(file)),
          Center(
            child: MaterialButton(
              child: const Text('load CSV'),
              onPressed: () async {
                List<PlatformFile> files = await csvReaderService.importFiles();
                ref.read(csvFilesProvider.notifier).addFiles(files);
              },
            ),
          ),
        ],
      ),
    );
  }
}
