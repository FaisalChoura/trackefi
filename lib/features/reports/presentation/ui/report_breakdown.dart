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
    final categories = report.categories;
    // TODO add spending over days bar chart
    // TODO add spending per transaction
    // TODO add transaction list
    return Row(
      children: [
        CategoriesPieChart(
          categories: report.categories,
        )
      ],
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
