import 'package:expense_categoriser/features/reports/data/store/reports_list_store.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_list_store_repository.dart';

class ReportsListStoreRepositoryImpl implements ReportsListStoreRepository {
  ReportsListStoreRepositoryImpl(this._store);
  final ReportsListStore _store;

  @override
  addReport(Report report) {
    _store.addReport(report);
  }

  @override
  removeReport(Report report) {
    _store.removeReport(report);
  }

  @override
  setReports(List<Report> reports) {
    _store.setReports(reports);
  }
}
