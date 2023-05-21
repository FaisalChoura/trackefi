import '../model/report.dart';
import '../model/transaction.dart';

class BuildReportUseCase {
  Report execute(Map<String, List<Transaction>> categorisedTransactions) {
    Report report = Report(0, 0, []);
    for (var categoryName in categorisedTransactions.keys) {
      ReportCategory category =
          ReportCategory(categoryName, categorisedTransactions[categoryName]!);
      report.categories.add(category);
    }
    return report;
  }
}
