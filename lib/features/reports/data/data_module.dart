import 'package:Trackefi/core/data/database/database_manager.dart';
import 'package:Trackefi/features/reports/data/reports_database.dart';
import 'package:Trackefi/features/reports/data/repository/reports_list_store_repository_impl.dart';
import 'package:Trackefi/features/reports/data/repository/reports_repository_impl.dart';
import 'package:Trackefi/features/reports/data/repository/selected_report_repository_impl.dart';
import 'package:Trackefi/features/reports/data/store/reports_list_store.dart';
import 'package:Trackefi/features/reports/data/store/selected_report_store.dart';
import 'package:Trackefi/features/reports/data/store/selected_report_transaction_events.dart';
import 'package:Trackefi/features/reports/domain/model/transaction_event.dart';
import 'package:Trackefi/features/reports/domain/repository/reports_list_store_repository.dart';
import 'package:Trackefi/features/reports/domain/repository/reports_repositry.dart';
import 'package:Trackefi/features/reports/domain/repository/selected_report_store_repository.dart';
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

final selectedReportStoreProvider =
    NotifierProvider<SelectedReportStore, Report?>(() {
  return SelectedReportStore();
});

final selectedReportStoreRepositoryProvider =
    Provider<SelectedReportStoreRepository>((ref) =>
        SelectedReportRepositoryImpl(
            ref.watch(selectedReportStoreProvider.notifier)));

final selectedReportTransactionEvents = NotifierProvider<
    SelectedReportTransactionEventsStore, List<TransactionEvent>>(() {
  return SelectedReportTransactionEventsStore();
});
