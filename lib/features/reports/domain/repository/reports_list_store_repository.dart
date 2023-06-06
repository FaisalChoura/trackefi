import 'package:expense_categoriser/features/reports/domain/model/report.dart';

abstract class ReportsListStoreRepository {
  addReport(Report report);
  removeReport(int id);
  setReports(List<Report> reports);
}
