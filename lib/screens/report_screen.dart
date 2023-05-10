import 'dart:async';

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
                await _handleUncategorisedTransactions(categorisedTransactions);
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
          child: SizedBox(
            height: 400,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final categories = ref.watch(categoriesProvider);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      if (uncategorisedTransactions != null)
                        for (var transaction in uncategorisedTransactions)
                          UncategorisedItemRow(
                              transaction: transaction, categories: categories)
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class UncategorisedItemRow extends StatefulWidget {
  const UncategorisedItemRow({
    super.key,
    required this.transaction,
    required this.categories,
  });

  final Transaction transaction;
  final List<Category> categories;

  @override
  State<UncategorisedItemRow> createState() => _UncategorisedItemRowState();
}

class _UncategorisedItemRowState extends State<UncategorisedItemRow> {
  late Category selectedCategory;

  @override
  void initState() {
    selectedCategory = widget.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.transaction.name),
        DropdownButton(
            value: selectedCategory!.id,
            items: widget.categories
                .map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedCategory = widget.categories
                    .where((element) => element.id == val!)
                    .first;
              });
            }),
        Text(widget.transaction.amount.toString()),
        IconButton(
          onPressed: () => print(selectedCategory.name),
          icon: const Icon(Icons.check),
        )
      ],
    );
  }
}
