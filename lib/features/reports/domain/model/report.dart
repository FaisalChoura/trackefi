import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:isar/isar.dart';

part 'report.g.dart';

@collection
class Report {
  Id id = Isar.autoIncrement;
  double income;
  double expenses;
  late DateTime createdAt;
  List<ReportCategorySnapshot> categories;

  Report(this.income, this.expenses, this.categories) {
    this.createdAt = DateTime.now();
    if (categories.isNotEmpty) {
      final totalExpenses = categories
          .map((category) => category.total)
          .reduce((value, element) => value + element);
      expenses = double.parse(totalExpenses.toStringAsFixed(2));
    }
  }
}
