import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:expense_categoriser/features/reports/domain/model/transaction.dart';

class ReportCategorySnapshot extends Category {
  num total = 0;
  List<Transaction> transactions = [];
  ReportCategorySnapshot(String name, List<String> keywords)
      : super(name, keywords);

  factory ReportCategorySnapshot.fromCategory(Category category) {
    final reportCategory =
        ReportCategorySnapshot(category.name, category.keywords);
    reportCategory.colorValues = category.colorValues;
    return reportCategory;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    total = double.parse((total + transaction.amount).toStringAsFixed(2));
  }
}
