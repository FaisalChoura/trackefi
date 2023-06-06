import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportBreakdown extends StatelessWidget {
  const ReportBreakdown({super.key, required this.report});
  final Report report;

  @override
  Widget build(BuildContext context) {
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
          child: PieChart(
            PieChartData(
                centerSpaceRadius: 5,
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                sections: _generateChartData(report)),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generateChartData(Report report) {
    return report.categories
        .map(
          (category) => PieChartSectionData(
              color: category.colorValues != null
                  ? category.colorValues!.toColor()
                  : Colors.purple,
              value: double.parse(category.total.toString()),
              radius: 100),
        )
        .toList();
  }
}
