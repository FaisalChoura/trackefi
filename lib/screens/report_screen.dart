import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/csv_reader_service.dart';
import 'package:expense_categoriser/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../services/csv_files_provider.dart';
import '../utils/models/category.dart';
import '../utils/models/report.dart';
import '../utils/models/transaction.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final ReportService reportService = ReportService();
  final CsvReaderService csvReaderService = CsvReaderService();
  Report? report;

  @override
  Widget build(BuildContext context) {
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

              if (categorisedTransactions['Uncategorised']!.isNotEmpty) {
                _handleUncategorisedTransactions(categorisedTransactions);
              }

              setState(() {
                report = reportService.generateReport(categorisedTransactions);
              });
            }),
        if (report != null)
          Column(
            children: [
              for (var category in report!.categories)
                Text("${category.name}: ${category.total}")
            ],
          )
      ]),
    );
  }

  _handleUncategorisedTransactions(
      Map<String, List<Transaction>> categorisedTransactions) async {
    return showDialog<Future<Map<String, List<Transaction>>>?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text('A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
