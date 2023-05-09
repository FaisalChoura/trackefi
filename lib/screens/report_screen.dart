import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/csv_reader_service.dart';
import 'package:expense_categoriser/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../services/csv_files_provider.dart';
import '../utils/models/category.dart';

class ReportScreen extends ConsumerWidget {
  final ReportService reportService = ReportService();
  final CsvReaderService csvReaderService = CsvReaderService();
  ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    final csvFiles = ref.watch(csvFilesProvider);

    Categoriser categoriser = Categoriser(categories);
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              final data = await csvReaderService.convertFilesToCsv(csvFiles);
              final categorisedTransactions =
                  // TODO handle multiple files
                  await categoriser.categorise(data[0]!);
              reportService.generateReport(categorisedTransactions);
            })
      ]),
    );
  }
}
