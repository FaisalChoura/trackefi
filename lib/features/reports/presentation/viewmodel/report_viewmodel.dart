import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/features/categories/domain/usecase/put_category_usecase.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/put_report_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/uncategories_row_data.dart';
import '../../../categories/domain/domain_module.dart';
import '../../domain/usecase/update_categories_from_data_usecase.dart';
import '../../domain/model/report.dart';

final reportViewModel =
    StateNotifierProvider<ReportViewModel, AsyncValue<Report?>>((ref) =>
        ReportViewModel(
            ref.watch(buildReportUseCaseProvider),
            ref.watch(convertCsvFileUseCaseProvider),
            ref.watch(categoriseTransactionsUseCaseProvider),
            ref.watch(updateCategoriesFromRowDataProvider),
            ref.watch(putCategoriesUseCaseProvider),
            ref.watch(putReportUseCaseProvider)));

class ReportViewModel extends StateNotifier<AsyncValue<Report?>> {
  final BuildReportUseCase _buildReportUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;
  final CategoriseTransactionsUseCase _categoriseTransactionsUseCase;
  final UpdateCategoriesFromRowData _updateCategoriesFromRowData;
  final PutCategoryUseCase _putCategoryUseCase;
  final PutReportUseCase _putReportUseCase;

  ReportViewModel(
      this._buildReportUseCase,
      this._convertCsvFileUseCase,
      this._categoriseTransactionsUseCase,
      this._updateCategoriesFromRowData,
      this._putCategoryUseCase,
      this._putReportUseCase)
      : super(const AsyncValue.data(null));

  void buildReport(List<ReportCategorySnapshot> categorisedTransactions) {
    state = const AsyncValue.loading();
    final report = _buildReportUseCase.execute(categorisedTransactions);
    state = AsyncValue.data(report);
  }

  Future<List<ReportCategorySnapshot>> categoriseTransactions(
      List<CsvFileData> filesData) async {
    try {
      final filesList = await _convertCsvFileUseCase.execute(filesData);
      if (filesList.isEmpty) {
        return [];
      }

      // if header row is one chunck that means the separation failed
      if (filesList[0]![0].length <= 1) {
        throw IncorrectFeildSeparatorException();
      }

      return
          // TODO handle multiple files
          await _categoriseTransactionsUseCase.execute(
              filesList[0]!, filesData[0].importSettings);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return [];
    }
  }

  bool hasUncategorisedTransactions(
      List<ReportCategorySnapshot> categorisedTransactions) {
    return categorisedTransactions.isNotEmpty
        ? categorisedTransactions[0].transactions.isNotEmpty
        : false;
  }

  Future<void> updateCategoriesFromRowData(
      List<UncategorisedRowData> values) async {
    final updatedCategories = _updateCategoriesFromRowData.execute(values);
    // TODO loops over multiple times if same cateogry is chosen for different keywords
    for (var category in updatedCategories) {
      await _putCategoryUseCase.execute(category);
    }
  }

  Future<void> putReport(Report report) async {
    await _putReportUseCase.execute(report);
  }
}
