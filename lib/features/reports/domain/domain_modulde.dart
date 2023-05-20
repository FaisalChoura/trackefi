import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
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
