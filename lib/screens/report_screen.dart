import 'dart:async';

import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/csv_reader_service.dart';
import 'package:expense_categoriser/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../services/csv_files_provider.dart';
import '../ui/uncategorised_item_row.dart';
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
              var categorisedTransactions =
                  // TODO handle multiple files
                  await categoriser.categorise(data[0]!);

              if (categorisedTransactions['Uncategorised']!.isNotEmpty) {
                await _handleUncategorisedTransactions(categorisedTransactions);
                categorisedTransactions =
                    await categoriser.categorise(data[0]!);
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

  Future<Map<String, List<Transaction>>?> _handleUncategorisedTransactions(
      Map<String, List<Transaction>> categorisedTransactions) async {
    return showDialog<Map<String, List<Transaction>>>(
      context: context,
      builder: (BuildContext context) {
        final uncategorisedTransactions =
            categorisedTransactions['Uncategorised'];
        return Dialog(
          child: UncategorisedItemsDialog(
              uncategorisedTransactions: uncategorisedTransactions),
        );
      },
    );
  }
}

class UncategorisedItemsDialog extends StatefulWidget {
  const UncategorisedItemsDialog({
    super.key,
    required this.uncategorisedTransactions,
  });

  final List<Transaction>? uncategorisedTransactions;

  @override
  State<UncategorisedItemsDialog> createState() =>
      _UncategorisedItemsDialogState();
}

class _UncategorisedItemsDialogState extends State<UncategorisedItemsDialog> {
  List<Transaction> transactions = [];
  Map<int, UncategorisedRowData> updatedRowCategoryData = {};

  @override
  void initState() {
    transactions = widget.uncategorisedTransactions ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final categories = ref.watch(categoriesProvider);
          return SingleChildScrollView(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      for (var data in updatedRowCategoryData.values) {
                        data.category.keywords = [
                          ...data.category.keywords,
                          ...data.keywords
                        ];
                        ref
                            .read(categoriesProvider.notifier)
                            .updateCategory(data.category);
                      }
                    },
                    icon: Icon(Icons.check)),
                for (var i = 0; i < transactions.length; i++)
                  // add id for changed rows and a submit button to handle the change
                  UncategorisedItemRow(
                    transaction: transactions[i],
                    categories: categories,
                    onChanged: (categoryData) {
                      updatedRowCategoryData[i] = categoryData;
                    },
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
