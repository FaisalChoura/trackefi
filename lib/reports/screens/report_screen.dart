import 'dart:async';

import 'package:expense_categoriser/reports/models/report.dart';
import 'package:expense_categoriser/reports/view_models/report_view_model.dart';
import 'package:expense_categoriser/services/categoriser.dart';
import 'package:expense_categoriser/services/csv_reader_service.dart';
import 'package:expense_categoriser/reports/view_models/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/categories_provider.dart';
import '../../services/csv_files_provider.dart';
import '../ui/uncategorised_item_row.dart';
import '../../utils/models/category.dart';
import '../../utils/models/transaction.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final ReportService reportService = ReportService();
  final CsvReaderService csvReaderService = CsvReaderService();

  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesProvider);
    final csvFiles = ref.watch(csvFilesProvider);
    final viewModel = ref.watch(reportViewModel);
    final Report? report = viewModel.report;

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              var categorisedTransactions = await ref
                  .read(reportViewModel.notifier)
                  .categoriseTransactions(csvFiles, categories);

              if (ref
                  .read(reportViewModel.notifier)
                  .hasUncategorisedTransactions(categorisedTransactions)) {
                List<UncategorisedRowData>? updatedCategoryData = [];

                updatedCategoryData = await _handleUncategorisedTransactions(
                    categorisedTransactions['Uncategorised']!);

                if (updatedCategoryData!.isNotEmpty) {
                  ref
                      .read(categoriesProvider.notifier)
                      .updateCategoriesFromRowData(updatedCategoryData);
                }

                categorisedTransactions = await ref
                    .read(reportViewModel.notifier)
                    .categoriseTransactions(csvFiles, categories);
              }
              ref
                  .read(reportViewModel.notifier)
                  .buildReport(categorisedTransactions);
            }),
        if (report != null)
          Column(
            children: [
              for (var category in report.categories)
                Text("${category.name}: ${category.total}")
            ],
          )
      ]),
    );
  }

  Future<List<UncategorisedRowData>?> _handleUncategorisedTransactions(
      List<Transaction> uncategorisedTransactions) async {
    return showDialog<List<UncategorisedRowData>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: UncategorisedItemsDialog(
              uncategorisedTransactions: uncategorisedTransactions),
        );
      },
    );
  }
}

class UncategorisedItemsDialog extends ConsumerStatefulWidget {
  const UncategorisedItemsDialog({
    super.key,
    required this.uncategorisedTransactions,
  });

  final List<Transaction>? uncategorisedTransactions;

  @override
  ConsumerState<UncategorisedItemsDialog> createState() =>
      _UncategorisedItemsDialogState();
}

class _UncategorisedItemsDialogState
    extends ConsumerState<UncategorisedItemsDialog> {
  List<Transaction> transactions = [];
  Map<int, UncategorisedRowData> updatedRowCategoryData = {};

  @override
  void initState() {
    transactions = widget.uncategorisedTransactions ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .pop(updatedRowCategoryData.values.toList()),
              icon: const Icon(Icons.check)),
          for (var i = 0; i < transactions.length; i++)
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
  }
}
