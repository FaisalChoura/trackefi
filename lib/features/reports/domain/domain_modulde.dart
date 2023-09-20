import 'package:expense_categoriser/core/data/data_module.dart';
import 'package:expense_categoriser/features/reports/data/data_module.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_currency_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/filter_csv_data_by_date_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/get_all_reports_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/move_transaction_between_category_snapshots.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/put_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/remove_report_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../categories/data/data_module.dart';

final buildReportUseCaseProvider =
    Provider<BuildReportUseCase>((ref) => BuildReportUseCase());

final categoriseTransactionsUseCaseProvider =
    Provider<CategoriseTransactionsUseCase>(
  (ref) =>
      CategoriseTransactionsUseCase(ref.watch(categoriesRepositoryProvider)),
);

final convertCsvFileUseCaseProvider =
    Provider<ConvertCsvFileUseCase>((ref) => ConvertCsvFileUseCase());

final getAllReportsUseCaseProvider =
    Provider<GetAllReportsUseCase>((ref) => GetAllReportsUseCase(
          ref.watch(reportsRepositoryProvider),
          ref.watch(reportsListStoreRepositoryProvider),
        ));

final putReportUseCaseProvider =
    Provider<PutReportUseCase>((ref) => PutReportUseCase(
          ref.watch(reportsRepositoryProvider),
          ref.watch(reportsListStoreRepositoryProvider),
        ));

final removeReportUseCaseProvider =
    Provider<RemoveReportUseCase>((ref) => RemoveReportUseCase(
          ref.watch(reportsRepositoryProvider),
          ref.watch(reportsListStoreRepositoryProvider),
        ));

final moveTransactionBetweenCategorySnapshots =
    Provider<MoveTransactionBetweenCategorySnapshots>(
        (ref) => MoveTransactionBetweenCategorySnapshots());

final convertCurrencyUseCaseProvider = Provider<ConvertCurrencyUseCase>(
    (ref) => ConvertCurrencyUseCase(ref.watch(currencyDataRepositoryProvider)));

final filterCsvDataByDate =
    Provider<FilterCsvDataByDateUseCase>((ref) => FilterCsvDataByDateUseCase());
