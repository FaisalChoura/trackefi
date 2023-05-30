import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';

class Report {
  num income;
  num expenses;
  List<ReportCategorySnapshot> categories;
  Report(this.income, this.expenses, this.categories) {
    if (categories.isNotEmpty) {
      final totalExpenses = categories
          .map((category) => category.total)
          .reduce((value, element) => value + element);
      expenses = num.parse(totalExpenses.toStringAsFixed(2));
    }
  }
}
