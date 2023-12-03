import 'package:Trackefi/core/domain/helpers/helpers.dart';
import 'package:Trackefi/features/categories/domain/model/category.dart';
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
      totalIncome = TrHelpers.round(totalIncome + transaction.amount, 2);
      return;
    }
    expensesTransactions.add(transaction);
    totalExpenses = TrHelpers.round(totalExpenses + transaction.amount, 2);
  }

  void removeTransaction(Transaction transaction) {
    if (transaction.isIncome) {
      incomeTransactions.remove(transaction);
      totalIncome = TrHelpers.round(totalIncome - transaction.amount, 2);
      return;
    }

    expensesTransactions.remove(transaction);
    totalExpenses = TrHelpers.round(totalExpenses - transaction.amount, 2);
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
    totalIncome =
        TrHelpers.round(totalIncome + mergedCategorySnapshot.totalIncome, 2);
    totalExpenses = TrHelpers.round(
        totalExpenses + mergedCategorySnapshot.totalExpenses, 2);
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

    totalIncome = TrHelpers.round(totalIncome, 2);
    totalExpenses = TrHelpers.round(totalExpenses, 2);
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
