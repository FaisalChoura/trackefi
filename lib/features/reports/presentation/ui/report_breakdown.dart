import 'dart:collection';

import 'package:Trackefi/core/domain/helpers/helpers.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/accordion.dart';
import 'package:Trackefi/core/presentation/ui/card.dart';
import 'package:Trackefi/core/presentation/ui/label.dart';
import 'package:Trackefi/features/csv_files/presentation/ui/extra_info_card.dart';
import 'package:Trackefi/features/reports/data/data_module.dart';
import 'package:Trackefi/features/reports/domain/domain_modulde.dart';
import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';
import 'package:Trackefi/features/reports/domain/model/transaction.dart';
import 'package:Trackefi/features/reports/presentation/ui/category_pie_chart.dart';
import 'package:Trackefi/features/reports/presentation/ui/editable_categorised_transactions_list.dart';
import 'package:Trackefi/features/reports/presentation/ui/spending_per_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class ReportBreakdown extends StatelessWidget {
  const ReportBreakdown({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    final dateFrom = report.dateRangeFrom;
    final dateTo = report.dateRangeTo;
    return SizedBox(
      height: MediaQuery.of(context).size.height < 1000
          ? MediaQuery.of(context).size.height * 0.85
          : MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TrCard(
                    child: Column(
                      children: [
                        const Text(
                          'Expenses',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              report.expenses.toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              report.currencyId,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TrCard(
                    child: Column(
                      children: [
                        const Text(
                          'Income',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              report.income.toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              report.currencyId,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TrCard(
                    child: Column(
                      children: [
                        const Text(
                          'Created on',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          TrHelpers.simpleDateFormatter(report.createdAt),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (dateTo != null && dateFrom != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Date Range',
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${TrHelpers.simpleDateFormatter(dateFrom)} - ${TrHelpers.simpleDateFormatter(dateTo)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CategoriesPieChart(
                  categories: report.categories,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SpendingPerTransactionList(
                  transactions: report.expenseTransactions,
                ),
              ),
              // CostlyDatesBarChart(
              //   dateCount: 5,
              //   transactions: report.expenseTransactions,
              // )
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: DailySpendLineGraph(
                  transactions: report.expenseTransactions,
                ),
              ),
            ],
          ),
          GroupedTransactionsByCategory(
            categorySnapshots: report.categories,
          ),
        ],
      ),
    );
  }

  // TODO duplicated
  List<CategorySnapshotItem> generateItems(
      List<ReportCategorySnapshot> categorySnapshots) {
    final numberOfItems = categorySnapshots.length;
    return List<CategorySnapshotItem>.generate(numberOfItems, (int index) {
      return CategorySnapshotItem(
        categorySnapshot: categorySnapshots[index],
      );
    });
  }
}

class GroupedTransactionsByCategory extends ConsumerStatefulWidget {
  final List<ReportCategorySnapshot> categorySnapshots;
  const GroupedTransactionsByCategory(
      {super.key, required this.categorySnapshots});

  @override
  ConsumerState<GroupedTransactionsByCategory> createState() =>
      _GroupedTransactionsByCategoryState();
}

class _GroupedTransactionsByCategoryState
    extends ConsumerState<GroupedTransactionsByCategory> {
  @override
  Widget build(BuildContext context) {
    final populatedCategorySnapshots = widget.categorySnapshots
        .where(
          (snapshot) => snapshot.transactions.isNotEmpty,
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        TrCard(
          child: TrAccordion(
            // TODO clean up
            items: generateItems(populatedCategorySnapshots).map((item) {
              return TrAccordionItem(
                  id: item.categorySnapshot.id,
                  leading: Text(item.categorySnapshot.name),
                  expandableHeight: item.categorySnapshot.transactions.length >
                          10
                      ? 400
                      : (item.categorySnapshot.transactions.length + 1) * 30,
                  trailing: Wrap(
                    children: [
                      // TODO The more expensses the redded
                      if (item.categorySnapshot.totalExpenses != 0)
                        TrLabel(
                          color: TColors.lightRed,
                          child: Text(
                            '${item.categorySnapshot.totalExpenses * -1}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (item.categorySnapshot.totalIncome != 0)
                        TrLabel(
                          color: TColors.lightGreen,
                          child: Text(
                            '${item.categorySnapshot.totalIncome * -1}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                    ],
                  ),
                  subItems: _generateCategotySubItems(item.categorySnapshot));
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _generateCategotySubItems(ReportCategorySnapshot category) {
    final transactions = category.transactions;
    final subItemList = <Widget>[];
    for (var i = 0; i < transactions.length; i++) {
      final transaction = transactions[i];
      subItemList.add(
        Container(
          decoration: BoxDecoration(
              color: i % 2 == 0 ? Colors.transparent : TColors.lightGrey),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: SizedBox(
            height: 45,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                    message: "File: ${transaction.originFileName}",
                    child: SizedBox(
                        width: 250, child: Text(transaction.name.toString()))),
                Text(TrHelpers.simpleDateFormatter(transaction.date)),
                Text(
                    "${transaction.originalAmount} ${transaction.originalCurrencyId}"),
                Row(
                  children: [
                    Text("${transaction.amount} ${transaction.currencyId}"),
                    PopupMenuButton(
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              value: 'Remove',
                              child: const Text('Remove'),
                              onTap: () {
                                // TODO move to viewModel
                                final report =
                                    ref.read(selectedReportStoreProvider);
                                final reportCategory = report.categories
                                    .where((reportCategory) =>
                                        reportCategory.id == category.id)
                                    .first;
                                reportCategory.removeTransaction(transaction);
                                reportCategory.recalculate();
                                report.calculate();
                                final clonedReport = Report.clone(report);
                                ref
                                    .read(selectedReportStoreRepositoryProvider)
                                    .updateReport(Report.clone(clonedReport));
                                if (report.id > 0) {
                                  ref
                                      .read(putReportUseCaseProvider)
                                      .execute(clonedReport);
                                }
                              },
                            ),
                          ]),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return subItemList;
  }
}

class DailySpendLineGraph extends StatelessWidget {
  final List<Transaction> transactions;

  const DailySpendLineGraph({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return TrExtraInfoCard(
      title: 'Daily spend',
      child: SizedBox(
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                        '${spot.y} \n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Date: ${_getDateFromMap(spot.x)}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                        textAlign: TextAlign.right);
                  }).toList();
                },
              ),
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  interval: 13.0 * transactions.length,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  interval: _groupTransactionsByDateMap().keys.length / 7,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              border: const Border(
                bottom: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  color: TColors.accent,
                  dotData: FlDotData(
                    show: false,
                  ),
                  spots: generateLineSpots(_groupTransactionsByDateMap()),
                  isCurved: true,
                  preventCurveOverShooting: true)
            ],
          ),
          swapAnimationDuration: const Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        ),
      ),
    );
  }

  List<FlSpot> generateLineSpots(Map<String, double> map) {
    final list = <FlSpot>[];
    for (var i = 0; i < map.values.length; i++) {
      list.add(FlSpot(i.toDouble(), map.values.toList()[i]));
    }
    return list;
  }

  String _getDateFromMap(double value) {
    final dates = _groupTransactionsByDateMap().keys.toList();

    final splitDate = dates[value.toInt()].split('-');
    final shortDate = "${splitDate[1]}/${splitDate[2]}";
    return shortDate;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

    final dates = _groupTransactionsByDateMap().keys.toList();

    final splitDate = dates[value.toInt()].split('-');
    final shortDate = "${splitDate[1]}/${splitDate[2]}";

    return SideTitleWidget(
      space: 4,
      axisSide: meta.axisSide,
      child: Text(
        shortDate,
        style: style,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

    return SideTitleWidget(
      space: 2,
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  // TODO used a lot can be more efficient
  Map<String, double> _groupTransactionsByDateMap() {
    final groupedTransactions = <String, double>{};
    for (var transaction in transactions) {
      final dateString = _dateString(transaction.date);
      if (groupedTransactions[dateString] != null) {
        groupedTransactions[dateString] = double.parse(
            (groupedTransactions[dateString]! + transaction.amount)
                .toStringAsFixed(2));
      } else {
        groupedTransactions[dateString] = transaction.amount;
      }
    }

    var sortedMapByAmount = Map.fromEntries(groupedTransactions.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    var sortedMapByDate =
        SplayTreeMap<String, double>.from(sortedMapByAmount, (key1, key2) {
      final date1 = DateTime.parse(key1);
      final date2 = DateTime.parse(key2);
      return date1.compareTo(date2);
    });
    return sortedMapByDate;
  }

  String _dateString(DateTime date) {
    final month = date.month < 10 ? "0${date.month}" : "${date.month}";
    final day = date.day < 10 ? "0${date.day}" : "${date.day}";
    return "${date.year}-$month-$day";
  }
}

class CostlyDatesBarChart extends StatelessWidget {
  const CostlyDatesBarChart({
    super.key,
    required this.dateCount,
    required this.transactions,
  });
  final List<Transaction> transactions;
  final int dateCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          const Text(
            'Most expensive dates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                  barGroups: generateBarGroups(_groupTransactionsByDateMap()),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: getTitles,
                      ),
                    ),
                  )),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final transactionsMap = _groupTransactionsByDateMap();
    String dateString = transactionsMap.keys.toList()[value.toInt()];
    final date = DateTime.parse(dateString);
    String text = "${date.day}/${date.month}";
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<BarChartGroupData> generateBarGroups(Map<String, double> map) {
    final groupList = <BarChartGroupData>[];
    final dateList = map.keys.toList();
    for (var i = 0; i < dateCount; i++) {
      final amount = map[dateList[i]] ?? 0;
      groupList.add(
          BarChartGroupData(x: i, barRods: [BarChartRodData(toY: amount)]));
    }
    return groupList;
  }

  Map<String, double> _groupTransactionsByDateMap() {
    final groupedTransactions = <String, double>{};
    for (var transaction in transactions) {
      final dateString = _dateString(transaction.date);
      if (groupedTransactions[dateString] != null) {
        groupedTransactions[dateString] = double.parse(
            (groupedTransactions[dateString]! + transaction.amount)
                .toStringAsFixed(2));
      } else {
        groupedTransactions[dateString] = transaction.amount;
      }
    }

    var sortedMapByAmount = Map.fromEntries(groupedTransactions.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    var shortenedMap = <String, double>{};
    final keysList = sortedMapByAmount.keys.toList();

    for (var i = 0; i < dateCount; i++) {
      var dateString = keysList[i];
      shortenedMap[dateString] = sortedMapByAmount[dateString] ?? 0;
    }

    var sortedMapByDate =
        SplayTreeMap<String, double>.from(shortenedMap, (key1, key2) {
      final date1 = DateTime.parse(key1);
      final date2 = DateTime.parse(key2);
      return date1.compareTo(date2);
    });
    return sortedMapByDate;
  }

  String _dateString(DateTime date) {
    final month = date.month < 10 ? "0${date.month}" : "${date.month}";
    final day = date.day < 10 ? "0${date.day}" : "${date.day}";
    return "${date.year}-$month-$day";
  }
}
