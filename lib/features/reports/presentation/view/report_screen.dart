import 'dart:async';

import 'package:expense_categoriser/core/domain/errors/error_object.dart';
import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/reports/presentation/viewmodel/report_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/uncategories_row_data.dart';
import '../../domain/model/transaction.dart';
import '../../../categories/presentaion/viewmodel/categories_viewmodel.dart';
import '../ui/uncategorised_item_row.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final csvFiles = ref.watch(csvFilesStoreProvider);

    ref.listen(
      reportViewModel,
      (_, state) => state.showDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Column(children: [
        MaterialButton(
            child: const Text('Generate Report'),
            onPressed: () async {
              var categorisedTransactions = await ref
                  .read(reportViewModel.notifier)
                  .categoriseTransactions(csvFiles);

              if (ref
                  .read(reportViewModel.notifier)
                  .hasUncategorisedTransactions(categorisedTransactions)) {
                List<UncategorisedRowData>? updatedCategoryData = [];

                updatedCategoryData = await _handleUncategorisedTransactions(
                    categorisedTransactions['Uncategorised']!);

                if (updatedCategoryData.isNotEmpty) {
                  await ref
                      .read(reportViewModel.notifier)
                      .updateCategoriesFromRowData(updatedCategoryData);
                }

                categorisedTransactions = await ref
                    .read(reportViewModel.notifier)
                    .categoriseTransactions(csvFiles);
              }
              ref
                  .read(reportViewModel.notifier)
                  .buildReport(categorisedTransactions);
            }),
        ref.watch(reportViewModel).maybeWhen(
              data: (report) {
                if (report != null) {
                  return Column(
                    children: [
                      const Text('Total Spent'),
                      Text(report.expenses.toString()),
                      const SizedBox(
                        height: 16,
                      ),
                      for (var category in report.categories)
                        Text("${category.name}: ${category.total}"),
                      SizedBox(
                        height: 300,
                        child: PieChart(PieChartData(
                            centerSpaceRadius: 5,
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 2,
                            sections: ref
                                .read(reportViewModel.notifier)
                                .generateChartData(report))),
                      )
                    ],
                  );
                }
                return Container();
              },
              error: (error, stackTrace) => Container(),
              orElse: () => const Expanded(
                  child: Center(child: CircularProgressIndicator())),
            )
      ]),
    );
  }

  Future<List<UncategorisedRowData>> _handleUncategorisedTransactions(
      List<Transaction> uncategorisedTransactions) async {
    return await showDialog<List<UncategorisedRowData>>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: UncategorisedItemsDialog(
                  uncategorisedTransactions: uncategorisedTransactions),
            );
          },
        ) ??
        [];
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
              child: SingleChildScrollView(
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
            ),
        orElse: () =>
            const Expanded(child: Center(child: CircularProgressIndicator())));
  }
}

extension AsyncValueUI on AsyncValue {
  void showDialogOnError(BuildContext context) => whenOrNull(error: (error, _) {
        showDialog<List<UncategorisedRowData>>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 400,
              child: Dialog(
                child: Text(
                    ErrorObject.exceptionToErrorObjectMapper(error.toString())
                        .title),
              ),
            );
          },
        );
      });
}
