import '../utils/models/report.dart';
import '../utils/models/transaction.dart';

class ReportService {
  Report generateReport(
      Map<String, List<Transaction>> categorisedTransactions) {
    Report report = Report(0, 0, []);
    for (var categoryName in categorisedTransactions.keys) {
      ReportCategory category =
          ReportCategory(categoryName, categorisedTransactions[categoryName]!);
      report.categories.add(category);
    }
    return report;
  }
}
