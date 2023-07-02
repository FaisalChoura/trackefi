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
    createdAt = DateTime.now();
    if (categories.isNotEmpty) {
      final totalExpenses = categories
          .map((category) => category.total)
          .reduce((value, element) => value + element);
      expenses = double.parse(totalExpenses.toStringAsFixed(2));
    }
  }

  List<Transaction> get expenseTransactions {
    List<Transaction> transactions = [];
    for (var category in categories) {
      final expenseTransactions =
          category.transactions.where((transaction) => !transaction.isIncome);
      transactions = [...transactions, ...expenseTransactions];
    }
    return transactions;
  }

  List<Transaction> get incomeTransactions {
    List<Transaction> transactions = [];

    // TODO O(nm) can be better
    for (var category in categories) {
      final incomeTransactions =
          category.transactions.where((transaction) => transaction.isIncome);
      transactions = [...transactions, ...incomeTransactions];
    }
    return transactions;
  }
}
