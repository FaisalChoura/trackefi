import 'package:expense_categoriser/features/reports/domain/model/report.dart';

import '../repository/reports_repositry.dart';

class PutReportUseCase {
  PutReportUseCase(this._reportsRepository);

  final ReportsRepository _reportsRepository;

  Future<Report?> execute(Report report) async {
    return await _reportsRepository.putReport(report);
  }
}
