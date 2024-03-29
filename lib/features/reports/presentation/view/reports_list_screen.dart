import 'package:Trackefi/core/domain/extensions/async_value_error_extension.dart';
import 'package:Trackefi/core/domain/helpers/helpers.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:Trackefi/core/presentation/ui/date_picker.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/core/presentation/ui/select_field.dart';
import 'package:Trackefi/features/categories/presentaion/viewmodel/categories_viewmodel.dart';
import 'package:Trackefi/features/csv_files/data/data_module.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/reports/data/data_module.dart';
import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';
import 'package:Trackefi/features/reports/domain/model/report_settings.dart';
import 'package:Trackefi/features/reports/domain/model/transaction.dart';
import 'package:Trackefi/features/reports/domain/model/uncategories_row_data.dart';
import 'package:Trackefi/features/reports/presentation/ui/editable_categorised_transactions_list.dart';
import 'package:Trackefi/features/reports/presentation/ui/uncategorised_item_row.dart';
import 'package:Trackefi/features/reports/presentation/view/report_breakdown_screen.dart';
import 'package:Trackefi/features/reports/presentation/viewmodel/reports_list_viewmodel.dart';
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
    // TODO create base page
    return Scaffold(
      floatingActionButton: TrButton(
        onPressed: () => _generateReport(csvFiles, context, ref),
        child: const Wrap(alignment: WrapAlignment.center, children: [
          Icon(Icons.refresh),
          SizedBox(
            width: 8,
          ),
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
              Wrap(
                children: reportsList
                    .map((report) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                ref
                                    .read(reportsListViewModel.notifier)
                                    .setSelectedReport(report);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ReportBreakdownScreen()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(color: TColors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Report: ${report.id}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () => ref
                                                .read(reportsListViewModel
                                                    .notifier)
                                                .removeReport(report.id),
                                          )
                                        ],
                                      ),
                                      Text(
                                          'Date: ${TrHelpers.dateString(report.createdAt)}'),
                                      Text('Currency: ${report.currencyId}'),
                                    ]),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        );
      }),
    );
  }

  void _generateReport(
      List<CsvFileData> csvFiles, BuildContext context, WidgetRef ref) async {
    final reportSettings = await _getReportSettings(context, ref);

    var categorisedTransactions = await ref
        .read(reportsListViewModel.notifier)
        .categoriseTransactions(csvFiles, reportSettings);

    if (categorisedTransactions.isEmpty) {
      return;
    }

    if (ref
        .read(reportsListViewModel.notifier)
        .hasUncategorisedTransactions(categorisedTransactions)) {
      List<UncategorisedRowData>? updatedCategoryData = [];

      final dataToBeUnique = <Transaction>[];
      var enteredMap = <String, List<Transaction>>{};

      for (var transaction in categorisedTransactions[0].expensesTransactions) {
        if (enteredMap[transaction.name] == null) {
          dataToBeUnique.add(transaction);
          enteredMap.putIfAbsent(transaction.name, () => [transaction]);
        } else {
          enteredMap[transaction.name] = [
            ...enteredMap[transaction.name]!,
            transaction
          ];
        }
      }

      for (var transaction in categorisedTransactions[0].incomeTransactions) {
        if (enteredMap[transaction.name] == null) {
          dataToBeUnique.add(transaction);
          enteredMap.putIfAbsent(transaction.name, () => [transaction]);
        } else {
          enteredMap[transaction.name] = [
            ...enteredMap[transaction.name]!,
            transaction
          ];
        }
      }

      updatedCategoryData = await _handleUncategorisedTransactions(
          dataToBeUnique, enteredMap, context);

      if (updatedCategoryData.isNotEmpty) {
        await ref
            .read(reportsListViewModel.notifier)
            .updateCategoriesFromRowData(updatedCategoryData);
      }

      categorisedTransactions = await ref
          .read(reportsListViewModel.notifier)
          .categoriseTransactions(csvFiles, reportSettings);

      categorisedTransactions = await _showAndEditCategorisedTransactions(
          categorisedTransactions, context);
    }

    final unifiedCurrencyTransaction = await ref
        .read(reportsListViewModel.notifier)
        .unifyTransactionCurrencies(
            categorisedTransactions, reportSettings.currencyId);

    final report = ref
        .read(reportsListViewModel.notifier)
        .buildReport(unifiedCurrencyTransaction, reportSettings);

    ref.read(reportsListViewModel.notifier).setSelectedReport(report);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ReportBreakdownScreen()));
  }

  Future<ReportSettings> _getReportSettings(
      BuildContext context, WidgetRef ref) async {
    return await showTrDialog(context, const ReportSettingsDialog());
  }

  Future<List<UncategorisedRowData>> _handleUncategorisedTransactions(
      List<Transaction> uncategorisedTransactions,
      Map<String, List<Transaction>> map,
      BuildContext context) async {
    return await showTrDialog<List<UncategorisedRowData>>(
          context,
          UncategorisedItemsDialog(
              uncategorisedTransactions: uncategorisedTransactions,
              nonUniqueTransactionsMap: map),
        ) ??
        [];
  }

  Future<List<ReportCategorySnapshot>> _showAndEditCategorisedTransactions(
      List<ReportCategorySnapshot> categories, BuildContext context) async {
    return await showTrDialog<List<ReportCategorySnapshot>>(
            context,
            EditableCategorisedTransactionsList(
              categorySnapshots: categories,
            )) ??
        categories;
  }
}

class ReportSettingsDialog extends ConsumerStatefulWidget {
  const ReportSettingsDialog({super.key});

  @override
  ConsumerState<ReportSettingsDialog> createState() =>
      _ReportSettingsDialogState();
}

class _ReportSettingsDialogState extends ConsumerState<ReportSettingsDialog> {
  String selectedCurrencyId = 'USD';
  DateTime? dateFrom;
  DateTime? dateTo;

  @override
  Widget build(BuildContext context) {
    final currencyList =
        ref.read(reportsListViewModel.notifier).getCurrencies();
    return SizedBox(
      height: 300,
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Report Settings'),
          TrSelectField(
              label: 'Currency',
              value: selectedCurrencyId,
              items: currencyList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.id),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCurrencyId = value;
                  });
                }
              }),
          TrDateField(
            label: 'Date from',
            onSaved: (val) {
              setState(() {
                dateFrom = val;
              });
            },
          ),
          TrDateField(
            label: 'Date to',
            onSaved: (val) {
              setState(() {
                dateTo = val;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: TrButton(
                  onPressed: () => Navigator.of(context).pop(ReportSettings(
                    currencyId: selectedCurrencyId,
                    fromDate: dateFrom,
                    toDate: dateTo,
                  )),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UncategorisedItemsDialog extends ConsumerStatefulWidget {
  const UncategorisedItemsDialog(
      {super.key,
      required this.uncategorisedTransactions,
      this.nonUniqueTransactionsMap});

  final List<Transaction> uncategorisedTransactions;
  final Map<String, List<Transaction>>? nonUniqueTransactionsMap;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Unknown keywords mapper',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i = 0; i < transactions.length; i++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Tooltip(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    richMessage: WidgetSpan(child: Builder(
                                      builder: (context) {
                                        if (widget.nonUniqueTransactionsMap ==
                                            null) {
                                          return const SizedBox();
                                        }
                                        final transactionList =
                                            widget.nonUniqueTransactionsMap![
                                                transactions[i].name];
                                        if (transactionList == null) {
                                          return const SizedBox();
                                        }
                                        return SizedBox(
                                          width: 400,
                                          child: Column(
                                            children: [
                                              for (var transaction
                                                  in transactionList)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(transaction.name),
                                                    Text(TrHelpers.dateString(
                                                        transaction.date)),
                                                    Text(transaction
                                                        .originalAmount
                                                        .toString())
                                                  ],
                                                )
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                                    child: const Icon(
                                      Icons.info_outline,
                                      size: 18,
                                    )),
                                Flexible(
                                  flex: 1,
                                  child: UncategorisedItemRow(
                                    transaction: transactions[i],
                                    categories: categories,
                                    onChanged: (categoryData) {
                                      updatedRowCategoryData[i] = categoryData;
                                    },
                                  ),
                                ),
                              ],
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
