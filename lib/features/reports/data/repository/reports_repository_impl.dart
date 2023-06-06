import 'package:expense_categoriser/features/reports/data/reports_database.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  ReportsRepositoryImpl(this._reportsDatabase);
  final ReportsDatabase _reportsDatabase;

  @override
  Future<Report?> putReport(Report report) async {
    return await _reportsDatabase.putCategory(report);
  }

  @override
  Future<bool> deleteReport(int id) async {
    return await _reportsDatabase.delete(id);
  }

  @override
  Future<Report?> getReport(int id) async {
    return await _reportsDatabase.get(id);
  }

  @override
  Future<List<Report>> getAllReports() async {
    return await _reportsDatabase.getAll();
  }
}
