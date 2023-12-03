import 'package:Trackefi/features/reports/data/store/selected_report_store.dart';
import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/domain/repository/selected_report_store_repository.dart';

class SelectedReportRepositoryImpl implements SelectedReportStoreRepository {
  SelectedReportRepositoryImpl(this._store);
  final SelectedReportStore _store;

  @override
  updateReport(Report report) {
    _store.updateReport(report);
  }
}
