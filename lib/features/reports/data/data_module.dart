import 'package:expense_categoriser/core/data/database/database_manager.dart';
import 'package:expense_categoriser/features/reports/data/reports_database.dart';
import 'package:expense_categoriser/features/reports/data/repository/reports_list_store_repository_impl.dart';
import 'package:expense_categoriser/features/reports/data/repository/reports_repository_impl.dart';
import 'package:expense_categoriser/features/reports/data/store/reports_list_store.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_list_store_repository.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/model/report.dart';

final reportsDatabaseProvider =
    Provider<ReportsDatabase>((_) => ReportsDatabase(DBManager.isntance.isar));
final reportsListStoreProvider =
    StateNotifierProvider<ReportsListStore, List<Report>>(
        (ref) => ReportsListStore());

final reportsRepositoryProvider = Provider<ReportsRepository>(
    (ref) => ReportsRepositoryImpl(ref.watch(reportsDatabaseProvider)));

final reportsListStoreRepositoryProvider = Provider<ReportsListStoreRepository>(
    (ref) => ReportsListStoreRepositoryImpl(
        ref.watch(reportsListStoreProvider.notifier)));
