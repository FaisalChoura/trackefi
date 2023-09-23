import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';

class MoveTransactionBetweenCategorySnapshots {
  List<ReportCategorySnapshot> execute(
      ReportCategorySnapshot fromCategory,
      ReportCategorySnapshot toCategory,
      Transaction transaction,
      List<ReportCategorySnapshot> categorySnapshots) {
    fromCategory.removeTransaction(transaction);

    toCategory.addTransaction(transaction);

    final fromCategoryIndex = categorySnapshots.indexOf(fromCategory);
    final toCategoryIndex = categorySnapshots.indexOf(toCategory);

    categorySnapshots[fromCategoryIndex] = fromCategory;

    categorySnapshots[toCategoryIndex] = toCategory;

    return categorySnapshots;
  }
}
