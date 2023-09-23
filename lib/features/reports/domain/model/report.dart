import 'package:Trackefi/features/categories/domain/model/category.dart';
import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';
import 'package:isar/isar.dart';

part 'report.g.dart';

@collection
class Report {
  Id id = Isar.autoIncrement;
  double income;
  double expenses;
  late DateTime createdAt;
  List<ReportCategorySnapshot> categories;
  DateTime? dateRangeFrom;
  DateTime? dateRangeTo;
  String currencyId = '';

  Report(this.income, this.expenses, this.categories) {
    createdAt = DateTime.now();
    if (categories.isNotEmpty) {
      final totalExpenses = categories
          .map((category) => category.totalExpenses)
          .reduce((value, element) => value + element);
      // TODO create function for rounding
      expenses = double.parse(totalExpenses.toStringAsFixed(2));
    }
  }

  List<Transaction> get expenseTransactions {
    List<Transaction> transactions = [];
    for (var category in categories) {
      transactions = [...transactions, ...category.expensesTransactions];
    }
    return transactions;
  }

  List<Transaction> get incomeTransactions {
    List<Transaction> transactions = [];
    for (var category in categories) {
      transactions = [...transactions, ...category.incomeTransactions];
    }
    return transactions;
  }
}
