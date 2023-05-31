import 'package:expense_categoriser/features/reports/domain/model/report.dart';

abstract class ReportsRepository {
  Future<Report?> putReport(Report category);

  Future<bool> deleteReport(int id);

  Future<Report?> getReport(int id);
  Future<List<Report>> getAllReports();
}
