import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/presentation/ui/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoriesPieChart extends StatelessWidget {
  const CategoriesPieChart({super.key, required this.categories});
  final List<ReportCategorySnapshot> categories;

  @override
  Widget build(BuildContext context) {
    final sortedCategories = [...categories];
    sortedCategories.sort((a, b) => b.totalExpenses.compareTo(a.totalExpenses));
    return SizedBox(
      height: 250,
      width: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Expenses by category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            height: 420,
                            width: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        icon: const Icon(
                                          Icons.close,
                                          size: 20,
                                        )),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Expenses by category',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: PieChart(
                                          PieChartData(
                                              centerSpaceRadius: 100,
                                              borderData:
                                                  FlBorderData(show: false),
                                              sectionsSpace: 1,
                                              sections: _generateChartData(
                                                  categories)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var i = 0;
                                              i < sortedCategories.length;
                                              i++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: Indicator(
                                                color: sortedCategories[i]
                                                            .colorValues !=
                                                        null
                                                    ? sortedCategories[i]
                                                        .colorValues!
                                                        .toColor()
                                                    : Colors.purple,
                                                text:
                                                    "${sortedCategories[i].name}: ${sortedCategories[i].totalExpenses}",
                                                isSquare: false,
                                                size: 12,
                                              ),
                                            ),
                                        ],
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('View all'))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 100,
                  child: PieChart(
                    PieChartData(
                        centerSpaceRadius: 35,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1,
                        sections: _generateChartData(categories)),
                  ),
                ),
                const SizedBox(
                  width: 46,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Indicator(
                          color: sortedCategories[i].colorValues != null
                              ? sortedCategories[i].colorValues!.toColor()
                              : Colors.purple,
                          text:
                              "${sortedCategories[i].name}: ${sortedCategories[i].totalExpenses}",
                          isSquare: false,
                          size: 12,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
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
              value: double.parse(category.totalExpenses.toString()),
              radius: 30,
              showTitle: false),
        )
        .toList();
  }
}
