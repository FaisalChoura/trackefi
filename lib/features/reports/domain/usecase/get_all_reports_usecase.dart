import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_list_store_repository.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';

class GetAllReportsUseCase {
  final ReportsRepository _reportsRepository;
  final ReportsListStoreRepository _reportsListStoreRepository;

  const GetAllReportsUseCase(
      this._reportsRepository, this._reportsListStoreRepository);

  Future<List<Report>> execute() async {
    final reports = await _reportsRepository.getAllReports();
    _reportsListStoreRepository.setReports(reports);
    return reports;
  }
}
