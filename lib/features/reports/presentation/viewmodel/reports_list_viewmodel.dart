import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/features/categories/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/model/uncategories_row_data.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/get_all_reports_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/put_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/remove_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/update_categories_from_data_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportsListViewModel =
    StateNotifierProvider<ReportsListViewModel, AsyncValue<List<Report>>>(
        (ref) => ReportsListViewModel(
            ref.watch(
              getAllReportsUseCaseProvider,
            ),
            ref.watch(removeReportUseCaseProvider),
            ref.watch(buildReportUseCaseProvider),
            ref.watch(convertCsvFileUseCaseProvider),
            ref.watch(categoriseTransactionsUseCaseProvider),
            ref.watch(updateCategoriesFromRowDataProvider),
            ref.watch(putReportUseCaseProvider)));

class ReportsListViewModel extends StateNotifier<AsyncValue<List<Report>>> {
  ReportsListViewModel(
    this._getAllReportsUseCase,
    this._removeReportUseCase,
    this._buildReportUseCase,
    this._convertCsvFileUseCase,
    this._categoriseTransactionsUseCase,
    this._updateCategoriesFromRowData,
    this._putReportUseCase,
  ) : super(const AsyncValue.data([])) {
    getList();
  }

  final GetAllReportsUseCase _getAllReportsUseCase;
  final RemoveReportUseCase _removeReportUseCase;
  final BuildReportUseCase _buildReportUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;
  final CategoriseTransactionsUseCase _categoriseTransactionsUseCase;
  final UpdateCategoriesFromRowData _updateCategoriesFromRowData;
  final PutReportUseCase _putReportUseCase;

  void getList() async {
    state = const AsyncValue.loading();
    final reports = await _getAllReportsUseCase.execute();
    state = AsyncValue.data(reports);
  }

  void removeReport(int id) {
    _removeReportUseCase.execute(id);
  }

  Report buildReport(List<ReportCategorySnapshot> categorisedTransactions) {
    return _buildReportUseCase.execute(categorisedTransactions);
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
        ? categorisedTransactions[0].expensesTransactions.isNotEmpty ||
            categorisedTransactions[0].incomeTransactions.isNotEmpty
        : false;
  }

  Future<void> updateCategoriesFromRowData(
      List<UncategorisedRowData> values) async {
    _updateCategoriesFromRowData.execute(values);
  }

  Future<void> putReport(Report report) async {
    await _putReportUseCase.execute(report);
  }
}
