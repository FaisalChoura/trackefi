import 'dart:collection';

import 'package:expense_categoriser/core/presentation/ui/card.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/category_pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportBreakdown extends StatelessWidget {
  const ReportBreakdown({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    // TODO add list off all transactions with dates
    return Padding(
      padding: const EdgeInsets.all(46),
      child: Column(
        children: [
          Row(
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
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              CategoriesPieChart(
                categories: report.categories,
              ),
              SpendingPerTransactionList(
                transactions: report.expenseTransactions,
              ),
              CostlyDatesBarChart(
                dateCount: 5,
                transactions: report.expenseTransactions,
              )
            ],
          ),
        ],
      ),
    );
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

class SpendingPerTransactionList extends StatelessWidget {
  const SpendingPerTransactionList({super.key, required this.transactions});
  final List<Transaction> transactions;

  Map<String, double> groupedTransactionByNameMap() {
    final groupedTransactions = <String, double>{};
    for (var transaction in transactions) {
      if (groupedTransactions[transaction.name] != null) {
        groupedTransactions[transaction.name] = double.parse(
            (groupedTransactions[transaction.name]! + transaction.amount)
                .toStringAsFixed(2));
      } else {
        groupedTransactions[transaction.name] = transaction.amount;
      }
    }
    return groupedTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionsMap = groupedTransactionByNameMap();
    final groupedTransactionsNames = groupedTransactionsMap.keys.toList();
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          const Text(
            'Expenses by transaction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: groupedTransactionsNames.length,
                itemBuilder: (context, i) {
                  final name = groupedTransactionsNames[i];
                  return ListTile(
                    title: Text(name),
                    subtitle: Text(groupedTransactionsMap[name].toString()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
