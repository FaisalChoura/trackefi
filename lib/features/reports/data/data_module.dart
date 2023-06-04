import 'package:expense_categoriser/core/data/database/database_manager.dart';
import 'package:expense_categoriser/features/reports/data/reports_database.dart';
import 'package:expense_categoriser/features/reports/data/reports_repository_impl.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportsDatabaseProvider =
    Provider<ReportsDatabase>((_) => ReportsDatabase(DBManager.isntance.isar));
final reportsRepositoryProvider = Provider<ReportsRepository>(
    (ref) => ReportsRepositoryImpl(ref.watch(reportsDatabaseProvider)));
