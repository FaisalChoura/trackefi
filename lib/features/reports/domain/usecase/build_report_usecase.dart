import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_settings.dart';

import '../model/report.dart';

class BuildReportUseCase {
  Report execute(List<ReportCategorySnapshot> categorisedTransactions,
      ReportSettings reportSettings) {
    final report = Report(0, 0, categorisedTransactions);
    report.dateRangeFrom = reportSettings.fromDate;
    report.dateRangeTo = reportSettings.toDate;
    return report;
  }
}
