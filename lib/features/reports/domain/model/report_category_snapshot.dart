import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:isar/isar.dart';

part 'report_category_snapshot.g.dart';

@embedded
class ReportCategorySnapshot {
  double totalExpenses = 0;
  double totalIncome = 0;
  String name;
  List<Transaction> expensesTransactions = [];
  List<Transaction> incomeTransactions = [];
  ColorValues? colorValues;
  ReportCategorySnapshot([this.name = '']);

  factory ReportCategorySnapshot.fromCategory(Category category) {
    final reportCategory = ReportCategorySnapshot(category.name);
    reportCategory.colorValues = category.colorValues;
    return reportCategory;
  }

  void addTransaction(Transaction transaction) {
    if (transaction.isIncome) {
      incomeTransactions.add(transaction);
      totalIncome =
          double.parse((totalIncome + transaction.amount).toStringAsFixed(2));
      return;
    }
    expensesTransactions.add(transaction);
    totalExpenses =
        double.parse((totalExpenses + transaction.amount).toStringAsFixed(2));
  }
}

@embedded
class Transaction {
  String name;
  late DateTime date;
  double amount;
  bool isIncome;
  Transaction(
      [this.name = '',
      this.amount = 0,
      String dateString = '1995-01-01',
      this.isIncome = false]) {
    date = DateTime.parse(dateString);
  }
}
