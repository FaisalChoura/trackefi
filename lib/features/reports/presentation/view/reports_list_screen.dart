import 'package:expense_categoriser/core/domain/extensions/async_value_error_extension.dart';
import 'package:expense_categoriser/core/domain/helpers/helpers.dart';
import 'package:expense_categoriser/core/presentation/ui/button.dart';
import 'package:expense_categoriser/features/categories/presentaion/viewmodel/categories_viewmodel.dart';
import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/reports/data/data_module.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/model/uncategories_row_data.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/editable_categorised_transactions_list.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/report_breakdown.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/uncategorised_item_row.dart';
import 'package:expense_categoriser/features/reports/presentation/viewmodel/reports_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsListScreen extends ConsumerWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csvFiles = ref.watch(csvFilesStoreProvider);

    ref.listen(
      reportsListViewModel,
      (_, state) => state.showDialogOnError(context),
    );

    return Scaffold(
      floatingActionButton: TrButton(
        onPressed: () => _generateReport(csvFiles, context, ref),
        child: const Wrap(children: [
          Icon(Icons.refresh),
          Text('Generate'),
        ]),
      ),
      key: const Key('1'),
      body: Consumer(builder: (context, ref, child) {
        final reportsList = ref.watch(reportsListStoreProvider);
        return Container(
          padding:
              const EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reports',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: reportsList.length,
                    itemBuilder: (context, index) {
                      final report = reportsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Report: ${report.id}'),
                                Text(TrHelpers.dateString(report.createdAt))
                              ]),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportBreakdownScreen(report: report))),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => ref
                                .read(reportsListViewModel.notifier)
                                .removeReport(report.id),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _generateReport(
      List<CsvFileData> csvFiles, BuildContext context, WidgetRef ref) async {
    var categorisedTransactions = await ref
        .read(reportsListViewModel.notifier)
        .categoriseTransactions(csvFiles);

    if (categorisedTransactions.isEmpty) {
      return;
    }

    if (ref
        .read(reportsListViewModel.notifier)
        .hasUncategorisedTransactions(categorisedTransactions)) {
      List<UncategorisedRowData>? updatedCategoryData = [];

      final dataToBeUnique = <Transaction>[];
      var enteredMap = <String, bool?>{};

      for (var categorisedTransactionBatch in categorisedTransactions) {
        for (var transaction
            in categorisedTransactionBatch.expensesTransactions) {
          if (enteredMap[transaction.name] == null) {
            dataToBeUnique.add(transaction);
            enteredMap.putIfAbsent(transaction.name, () => true);
          }
        }
      }

      updatedCategoryData =
          await _handleUncategorisedTransactions(dataToBeUnique, context);

      if (updatedCategoryData.isNotEmpty) {
        await ref
            .read(reportsListViewModel.notifier)
            .updateCategoriesFromRowData(updatedCategoryData);
      }

      categorisedTransactions = await ref
          .read(reportsListViewModel.notifier)
          .categoriseTransactions(csvFiles);

      categorisedTransactions = await _showAndEditCategorisedTransactions(
          categorisedTransactions, context);
    }
    final report = ref
        .read(reportsListViewModel.notifier)
        .buildReport(categorisedTransactions);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReportBreakdownScreen(report: report)));
  }

  Future<List<UncategorisedRowData>> _handleUncategorisedTransactions(
      List<Transaction> uncategorisedTransactions, BuildContext context) async {
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

  Future<List<ReportCategorySnapshot>> _showAndEditCategorisedTransactions(
      List<ReportCategorySnapshot> categories, BuildContext context) async {
    // TODO extract dialog into TrDialog to use in app
    return await showDialog<List<ReportCategorySnapshot>>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: EditableCategorisedTransactionsList(
                categorySnapshots: categories,
              ),
            );
          },
        ) ??
        categories;
  }
}

class ReportBreakdownScreen extends ConsumerWidget {
  const ReportBreakdownScreen({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 35,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.chevron_left,
                    )),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Report: ${report.id}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                ReportBreakdown(report: report),
                report.id < 0
                    ? MaterialButton(
                        child: const Text('Save Report'),
                        onPressed: () => ref
                            .read(reportsListViewModel.notifier)
                            .putReport(report),
                      )
                    : Container()
              ],
            )),
          ],
        ),
      ),
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
              height: 600,
              width: 800,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Unknown keywords mapper',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TrButton(
                            onPressed: () => Navigator.of(context).pop(
                                groupRowData(
                                    updatedRowCategoryData.values.toList())),
                            child: const Text('Done'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        orElse: () =>
            const Expanded(child: Center(child: CircularProgressIndicator())));
  }

  List<UncategorisedRowData> groupRowData(
      List<UncategorisedRowData> ungroupedList) {
    Map<String, UncategorisedRowData> groupedMap = {};
    for (var item in ungroupedList) {
      if (groupedMap[item.category.name] != null) {
        final existingItem = groupedMap[item.category.name]!;
        existingItem.keywords = [...existingItem.keywords, ...item.keywords];
      } else {
        groupedMap[item.category.name] = item;
      }
    }
    return groupedMap.values.toList();
  }
}
