import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';

import '../model/report.dart';

class BuildReportUseCase {
  Report execute(List<ReportCategorySnapshot> categorisedTransactions) {
    return Report(0, 0, categorisedTransactions);
  }
}
