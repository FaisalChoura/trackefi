import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../core/data/database/database_model.dart';

class ReportsDatabase extends DatabaseModel<Report> {
  ReportsDatabase(super.schema);

  // Returns category or null if not found
  Future<Report?> get(int id) async {
    await checkDbConnection();

    return await isar!.reports.get(id);
  }

  // Returns category or null if not found
  Future<List<Report>> getAll() async {
    await checkDbConnection();

    return await isar!.reports.where().findAll();
  }

  Future<Report?> putCategory(Report category) async {
    await checkDbConnection();

    return await isar?.writeTxn(() async {
      await isar!.reports.put(category);
      return category;
    });
  }

  // Returns bool of status of task
  Future<bool> delete(int id) async {
    await checkDbConnection();

    return await isar!.writeTxn(() async {
      return await isar!.reports.delete(id);
    });
  }
}

final reportRepository =
    Provider<ReportsDatabase>((ref) => ReportsDatabase(ReportSchema));
