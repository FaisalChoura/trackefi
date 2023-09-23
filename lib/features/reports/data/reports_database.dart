import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:isar/isar.dart';

class ReportsDatabase {
  ReportsDatabase(this._isar);
  final Isar _isar;

  // Returns category or null if not found
  Future<Report?> get(int id) async {
    return await _isar.reports.get(id);
  }

  // Returns category or null if not found
  Future<List<Report>> getAll() async {
    return await _isar.reports.where().findAll();
  }

  Future<Report?> putCategory(Report category) async {
    return await _isar.writeTxn(() async {
      await _isar.reports.put(category);
      return category;
    });
  }

  // Returns bool of status of task
  Future<bool> delete(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.reports.delete(id);
    });
  }
}
