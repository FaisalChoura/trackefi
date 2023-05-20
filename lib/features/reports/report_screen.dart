import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/domain/model/uncategories_row_data.dart';
import 'domain/model/report.dart';
import 'domain/model/transaction.dart';
import '../../services/csv_reader_service.dart';
import '../categories/domain/model/category.dart';
import '../categories/presentaion/viewmodel/categories_viewmodel.dart';
import '../csv_files/csv_files_provider.dart';
import 'report_view_model.dart';
import 'ui/uncategorised_item_row.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final CsvReaderService csvReaderService = CsvReaderService();

  @override
  Widget build(BuildContext context) {
    final csvFiles = ref.watch(csvFilesProvider);
    final viewModel = ref.watch(reportViewModel);
    final Report? report = viewModel.report;

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              // TODO remove dependency on viewModel
              List<Category> categories =
                  ref.read(categoriesViewModelStateNotifierProvider).value ??
                      [];
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
                  // TODO remove dependency on viewModel

                  ref
                      .read(categoriesViewModelStateNotifierProvider.notifier)
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
    return ref.watch(categoriesViewModelStateNotifierProvider).maybeWhen(
        data: (categories) => SizedBox(
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
            ),
        orElse: () =>
            const Expanded(child: Center(child: CircularProgressIndicator())));
  }
}
