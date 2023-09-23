import 'package:Trackefi/features/reports/domain/model/report.dart';

abstract class ReportsListStoreRepository {
  addReport(Report report);
  removeReport(int id);
  setReports(List<Report> reports);
}
