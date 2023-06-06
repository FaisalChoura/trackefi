import 'package:expense_categoriser/features/reports/domain/model/report.dart';

abstract class ReportsListStoreRepository {
  addReport(Report report);
  removeReport(Report report);
  setReports(List<Report> reports);
}
