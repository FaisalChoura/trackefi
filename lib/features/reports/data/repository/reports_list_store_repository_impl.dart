import 'package:Trackefi/features/reports/data/store/reports_list_store.dart';
import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/domain/repository/reports_list_store_repository.dart';

class ReportsListStoreRepositoryImpl implements ReportsListStoreRepository {
  ReportsListStoreRepositoryImpl(this._store);
  final ReportsListStore _store;

  @override
  addReport(Report report) {
    _store.addReport(report);
  }

  @override
  removeReport(int id) {
    _store.removeReport(id);
  }

  @override
  setReports(List<Report> reports) {
    _store.setReports(reports);
  }
}
