import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/models/import_settings.dart';
import '../../../categories/domain/model/category.dart';
import '../../domain/model/report.dart';
import '../../domain/model/transaction.dart';

final reportViewModel =
    StateNotifierProvider<ReportViewModel, AsyncValue<Report?>>(
        (ref) => ReportViewModel(
              ref.watch(buildReportUseCaseProvider),
              ref.watch(convertCsvFileUseCaseProvider),
              ref.watch(categoriseTransactionsUseCaseProvider),
            ));

class ReportViewModel extends StateNotifier<AsyncValue<Report?>> {
  final BuildReportUseCase _buildReportUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;
  final CategoriseTransactionsUseCase _categoriseTransactionsUseCase;
  ReportViewModel(
    this._buildReportUseCase,
    this._convertCsvFileUseCase,
    this._categoriseTransactionsUseCase,
  ) : super(const AsyncValue.data(null));

  void buildReport(Map<String, List<Transaction>> categorisedTransactions) {
    state = const AsyncValue.loading();
    final report = _buildReportUseCase.execute(categorisedTransactions);
    state = AsyncValue.data(report);
  }

  Future<Map<String, List<Transaction>>> categoriseTransactions(
      List<PlatformFile> files, List<Category> categories) async {
    final data = await _convertCsvFileUseCase.execute(files);
    return
        // TODO handle multiple files
        await _categoriseTransactionsUseCase.execute(
            data[0]!, CsvImportSettings());
  }

  bool hasUncategorisedTransactions(categorisedTransactions) {
    return categorisedTransactions['Uncategorised']!.isNotEmpty;
  }
}
