import '../model/report.dart';
import '../model/transaction.dart';

class BuildReportUseCase {
  Report execute(Map<String, List<Transaction>> categorisedTransactions) {
    List<ReportCategory> categories = [];
    for (var categoryName in categorisedTransactions.keys) {
      ReportCategory category =
          ReportCategory(categoryName, categorisedTransactions[categoryName]!);
      categories.add(category);
    }
    return Report(0, 0, categories);
  }
}
