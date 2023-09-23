import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/domain/repository/reports_list_store_repository.dart';

import '../repository/reports_repositry.dart';

class PutReportUseCase {
  PutReportUseCase(this._reportsRepository, this._reportsListStoreRepository);

  final ReportsRepository _reportsRepository;
  final ReportsListStoreRepository _reportsListStoreRepository;

  Future<Report?> execute(Report report) async {
    final savedReport = await _reportsRepository.putReport(report);
    _reportsListStoreRepository.addReport(report);
    return savedReport;
  }
}
