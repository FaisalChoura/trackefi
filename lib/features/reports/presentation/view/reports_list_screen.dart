import 'package:expense_categoriser/core/domain/extensions/async_value_error_extension.dart';
import 'package:expense_categoriser/core/presentation/ui/button.dart';
import 'package:expense_categoriser/features/csv_files/data/data_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/reports/data/data_module.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/model/uncategories_row_data.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/report_breakdown.dart';
import 'package:expense_categoriser/features/reports/presentation/view/report_screen.dart';
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
      appBar: AppBar(title: const Text('Reports List')),
      body: Consumer(builder: (context, ref, child) {
        final reportsList = ref.watch(reportsListStoreProvider);
        final viewModel = ref.watch(reportsListViewModel);
        return Container(
          child: viewModel.maybeWhen(
            data: (data) => ListView.builder(
                itemCount: reportsList.length,
                itemBuilder: (context, index) {
                  final report = reportsList[index];
                  return ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Report: ${report.id}'),
                          Text(report.createdAt.toUtc().toString())
                        ]),
                    // TODO sort out routing for side menu
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReportBreakdownScreen(report: report))),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => ref
                          .read(reportsListViewModel.notifier)
                          .removeReport(report.id),
                    ),
                  );
                }),
            orElse: () => const Center(child: CircularProgressIndicator()),
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

    if (ref
        .read(reportsListViewModel.notifier)
        .hasUncategorisedTransactions(categorisedTransactions)) {
      List<UncategorisedRowData>? updatedCategoryData = [];

      final dataToBeUnique = <Transaction>[];
      var enteredMap = <String, bool?>{};
      for (var transaction in categorisedTransactions[0].expensesTransactions) {
        if (enteredMap[transaction.name] == null) {
          dataToBeUnique.add(transaction);
          enteredMap.putIfAbsent(transaction.name, () => true);
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
}

class ReportBreakdownScreen extends StatelessWidget {
  const ReportBreakdownScreen({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report: ${report.id}')),
      body: Center(child: ReportBreakdown(report: report)),
    );
  }
}
