import 'dart:collection';
import 'dart:math';

import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportBreakdown extends StatelessWidget {
  const ReportBreakdown({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
    // TODO add list off all transactions with dates
    return Row(
      children: [
        CategoriesPieChart(
          categories: report.categories,
        ),
        SpendingPerTransactionList(
          transactions: report.transactions,
        ),
        CostlyDatesBarChart(
          dateCount: 5,
          transactions: report.transactions,
        )
      ],
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
        swapAnimationDuration: const Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
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
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
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
    // TODO round doubles
    for (var transaction in transactions) {
      final dateString = _dateString(transaction.date);
      if (groupedTransactions[dateString] != null) {
        groupedTransactions[dateString] =
            groupedTransactions[dateString]! + transaction.amount;
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
    // TODO round doubles
    final groupedTransactions = <String, double>{};
    for (var transaction in transactions) {
      if (groupedTransactions[transaction.name] != null) {
        groupedTransactions[transaction.name] =
            groupedTransactions[transaction.name]! + transaction.amount;
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
      child: ListView.builder(
          itemCount: groupedTransactionsNames.length,
          itemBuilder: (context, i) {
            final name = groupedTransactionsNames[i];
            return ListTile(
              title: Text(name),
              subtitle: Text(groupedTransactionsMap[name].toString()),
            );
          }),
    );
  }
}

class CategoriesPieChart extends StatelessWidget {
  const CategoriesPieChart({super.key, required this.categories});
  final List<ReportCategorySnapshot> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        for (var category in categories)
          Indicator(
            color: category.colorValues != null
                ? category.colorValues!.toColor()
                : Colors.purple,
            text: "${category.name}: ${category.total}",
            isSquare: true,
          ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 300,
          width: 400,
          child: PieChart(
            PieChartData(
                centerSpaceRadius: 125,
                borderData: FlBorderData(show: false),
                sectionsSpace: 1,
                sections: _generateChartData(categories)),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generateChartData(
      List<ReportCategorySnapshot> categories) {
    return categories
        .map(
          (category) => PieChartSectionData(
              color: category.colorValues != null
                  ? category.colorValues!.toColor()
                  : Colors.purple,
              value: double.parse(category.total.toString()),
              radius: 30,
              showTitle: false),
        )
        .toList();
  }
}
