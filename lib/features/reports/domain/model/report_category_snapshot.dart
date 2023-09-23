import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'report_category_snapshot.g.dart';

@embedded
class ReportCategorySnapshot {
  late String id;
  double totalExpenses = 0;
  double totalIncome = 0;
  String name;
  List<Transaction> expensesTransactions = [];
  List<Transaction> incomeTransactions = [];
  ColorValues? colorValues;
  ReportCategorySnapshot([this.name = '']) {
    id = const Uuid().v4();
  }

  factory ReportCategorySnapshot.fromCategory(Category category) {
    final reportCategory = ReportCategorySnapshot(category.name);
    reportCategory.colorValues = category.colorValues;
    return reportCategory;
  }

  List<Transaction> get transactions {
    return [...expensesTransactions, ...incomeTransactions];
  }

  void addTransaction(Transaction transaction) {
    transaction.categorySnapshotId = id;
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

  void removeTransaction(Transaction transaction) {
    if (transaction.isIncome) {
      incomeTransactions.remove(transaction);
      totalIncome = totalIncome - transaction.amount;
      return;
    }

    expensesTransactions.remove(transaction);
    totalExpenses = totalExpenses - transaction.amount;
  }

  void merge(ReportCategorySnapshot mergedCategorySnapshot) {
    incomeTransactions = [
      ...incomeTransactions,
      ...mergedCategorySnapshot.incomeTransactions
    ];
    expensesTransactions = [
      ...expensesTransactions,
      ...mergedCategorySnapshot.expensesTransactions
    ];
    totalIncome = totalIncome + mergedCategorySnapshot.totalIncome;
    totalExpenses = totalExpenses + mergedCategorySnapshot.totalExpenses;
  }

  void recalculate() {
    totalExpenses = 0;
    totalIncome = 0;

    for (var transaction in expensesTransactions) {
      totalExpenses = transaction.amount + totalExpenses;
    }

    for (var transaction in incomeTransactions) {
      totalIncome = transaction.amount + totalIncome;
    }

    totalIncome = double.parse(totalIncome.toStringAsFixed(2));
    totalExpenses = double.parse(totalExpenses.toStringAsFixed(2));
  }
}

@embedded
class Transaction {
  late String id;
  String categorySnapshotId;
  String name;
  late DateTime date;
  double amount;
  bool isIncome;
  String currencyId;
  Transaction({
    this.name = '',
    this.amount = 0,
    String dateString = '1995-01-01',
    this.isIncome = false,
    this.currencyId = '',
    this.categorySnapshotId = '',
  }) {
    id = const Uuid().v4();
    date = DateTime.parse(dateString);
  }
}
