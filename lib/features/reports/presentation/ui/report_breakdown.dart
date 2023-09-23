import 'dart:collection';

import 'package:expense_categoriser/core/domain/helpers/helpers.dart';
import 'package:expense_categoriser/core/presentation/themes/light_theme.dart';
import 'package:expense_categoriser/core/presentation/ui/accordion.dart';
import 'package:expense_categoriser/core/presentation/ui/card.dart';
import 'package:expense_categoriser/core/presentation/ui/label.dart';
import 'package:expense_categoriser/features/csv_files/presentation/ui/extra_info_card.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/category_pie_chart.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/editable_categorised_transactions_list.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/spending_per_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportBreakdown extends StatelessWidget {
  const ReportBreakdown({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    final dateFrom = report.dateRangeFrom;
    final dateTo = report.dateRangeTo;
    return SizedBox(
      height: 700,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(46),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
                              report.expenses.toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
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
                            Text(
                              report.income.toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                  CategoriesPieChart(
                    categories: report.categories,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SpendingPerTransactionList(
                    transactions: report.expenseTransactions,
                  ),
                  // CostlyDatesBarChart(
                  //   dateCount: 5,
                  //   transactions: report.expenseTransactions,
                  // )
                  const SizedBox(
                    width: 16,
                  ),
                  DailySpendLineGraph(
                    transactions: report.expenseTransactions,
                  ),
                ],
              ),
              GroupedTransactionsByCategory(
                categorySnapshots: report.categories,
              ),
            ],
          ),
        ),
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

class GroupedTransactionsByCategory extends StatelessWidget {
  final List<ReportCategorySnapshot> categorySnapshots;
  const GroupedTransactionsByCategory(
      {super.key, required this.categorySnapshots});

  @override
  Widget build(BuildContext context) {
    final populatedCategorySnapshots = categorySnapshots
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
        TrAccordion(
          // TODO clean up
          items: generateItems(populatedCategorySnapshots).map((item) {
            return TrAccordionItem(
                id: item.categorySnapshot.id,
                leading: Text(item.categorySnapshot.name),
                expandableHeight: item.categorySnapshot.transactions.length > 10
                    ? 300
                    : (item.categorySnapshot.transactions.length + 1) * 30,
                trailing: Wrap(
                  children: [
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
                    // TODO The more expensses the redded
                    TrLabel(
                      color: TColors.lightgreen,
                      child: Text(
                        '${item.categorySnapshot.totalIncome * -1}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                subItems: _generateCategotySubItems(
                    item.categorySnapshot.transactions));
          }).toList(),
        ),
      ],
    );
  }

  List<Widget> _generateCategotySubItems(List<Transaction> transactions) {
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
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 150, child: Text(transaction.name.toString())),
                Text(TrHelpers.simpleDateFormatter(transaction.date)),
                Text(transaction.amount.toString()),
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
      onButtonClick: () {},
      title: 'Daily spend',
      child: SizedBox(
        child: LineChart(
          LineChartData(
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
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  // TODO interval should be related to length of data
                  interval: 7,
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
                color: TColors.accentGreen,
                dotData: FlDotData(
                  show: false,
                ),
                spots: generateLineSpots(_groupTransactionsByDateMap()),
                isCurved: true,
              )
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
