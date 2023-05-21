import 'package:expense_categoriser/features/categories/domain/usecase/put_category_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/uncategories_row_data.dart';
import '../../../categories/domain/domain_module.dart';
import '../../domain/usecase/update_categories_from_data_usecase.dart';
import '../../domain/model/import_settings.dart';
import '../../domain/model/report.dart';
import '../../domain/model/transaction.dart';

final reportViewModel =
    StateNotifierProvider<ReportViewModel, AsyncValue<Report?>>((ref) =>
        ReportViewModel(
            ref.watch(buildReportUseCaseProvider),
            ref.watch(convertCsvFileUseCaseProvider),
            ref.watch(categoriseTransactionsUseCaseProvider),
            ref.watch(updateCategoriesFromRowDataProvider),
            ref.watch(putCategoriesUseCaseProvider)));

class ReportViewModel extends StateNotifier<AsyncValue<Report?>> {
  final BuildReportUseCase _buildReportUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;
  final CategoriseTransactionsUseCase _categoriseTransactionsUseCase;
  final UpdateCategoriesFromRowData _updateCategoriesFromRowData;
  final PutCategoryUseCase _putCategoryUseCase;

  ReportViewModel(
      this._buildReportUseCase,
      this._convertCsvFileUseCase,
      this._categoriseTransactionsUseCase,
      this._updateCategoriesFromRowData,
      this._putCategoryUseCase)
      : super(const AsyncValue.data(null));

  void buildReport(Map<String, List<Transaction>> categorisedTransactions) {
    state = const AsyncValue.loading();
    final report = _buildReportUseCase.execute(categorisedTransactions);
    state = AsyncValue.data(report);
  }

  Future<Map<String, List<Transaction>>> categoriseTransactions(
      List<PlatformFile> files) async {
    final data = await _convertCsvFileUseCase.execute(files);
    return
        // TODO handle multiple files
        await _categoriseTransactionsUseCase.execute(
            data[0]!, CsvImportSettings());
  }

  bool hasUncategorisedTransactions(categorisedTransactions) {
    return categorisedTransactions['Uncategorised']!.isNotEmpty;
  }

  Future<void> updateCategoriesFromRowData(
      List<UncategorisedRowData> values) async {
    final updatedCategories = _updateCategoriesFromRowData.execute(values);
    // TODO loops over multiple times if same cateogry is chosen for different keywords
    for (var category in updatedCategories) {
      await _putCategoryUseCase.execute(category);
    }
  }
}
