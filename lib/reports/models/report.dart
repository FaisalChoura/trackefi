import '../../utils/models/transaction.dart';

class ReportCategory {
  num total = 0;
  String name;
  List<Transaction> transactions;
  ReportCategory(this.name, this.transactions) {
    for (var transaction in transactions) {
      total = double.parse((total + transaction.amount).toStringAsFixed(2));
    }
  }
}

class Report {
  num income;
  num expenses;
  List<ReportCategory> categories;
  Report(this.income, this.expenses, this.categories);
}
