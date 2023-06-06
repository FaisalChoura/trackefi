import 'package:expense_categoriser/features/reports/domain/repository/reports_list_store_repository.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';

class RemoveReportUseCase {
  RemoveReportUseCase(
      this._reportsRepository, this._reportsListStoreRepository);

  final ReportsRepository _reportsRepository;
  final ReportsListStoreRepository _reportsListStoreRepository;

  void execute(int id) async {
    await _reportsRepository.deleteReport(id);
    _reportsListStoreRepository.removeReport(id);
  }
}
