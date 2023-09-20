import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/core/domain/model/currency.dart';
import 'package:expense_categoriser/features/categories/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/get_currencies_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_settings.dart';
import 'package:expense_categoriser/features/reports/domain/model/uncategories_row_data.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/build_report_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/categorise_transactions_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_currency_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/filter_csv_data_by_date_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/get_all_reports_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/move_transaction_between_category_snapshots.dart';
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
            ref.watch(putReportUseCaseProvider),
            ref.watch(moveTransactionBetweenCategorySnapshots),
            ref.watch(getCurrenciesUseCaseProvider),
            ref.watch(convertCurrencyUseCaseProvider),
            ref.watch(filterCsvDataByDate)));

class ReportsListViewModel extends StateNotifier<AsyncValue<List<Report>>> {
  ReportsListViewModel(
      this._getAllReportsUseCase,
      this._removeReportUseCase,
      this._buildReportUseCase,
      this._convertCsvFileUseCase,
      this._categoriseTransactionsUseCase,
      this._updateCategoriesFromRowData,
      this._putReportUseCase,
      this._moveTransactionBetweenCategorySnapshots,
      this._getCurrenciesUseCase,
      this._convertCurrencyUseCase,
      this._filterCsvDataByDateUseCase)
      : super(const AsyncValue.data([])) {
    getList();
  }

  final GetAllReportsUseCase _getAllReportsUseCase;
  final RemoveReportUseCase _removeReportUseCase;
  final BuildReportUseCase _buildReportUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;
  final CategoriseTransactionsUseCase _categoriseTransactionsUseCase;
  final UpdateCategoriesFromRowData _updateCategoriesFromRowData;
  final PutReportUseCase _putReportUseCase;
  final MoveTransactionBetweenCategorySnapshots
      _moveTransactionBetweenCategorySnapshots;
  final GetCurrenciesUseCase _getCurrenciesUseCase;
  final ConvertCurrencyUseCase _convertCurrencyUseCase;
  final FilterCsvDataByDateUseCase _filterCsvDataByDateUseCase;

  void getList() async {
    state = const AsyncValue.loading();
    final reports = await _getAllReportsUseCase.execute();
    state = AsyncValue.data(reports);
  }

  void removeReport(int id) {
    _removeReportUseCase.execute(id);
  }

  Report buildReport(List<ReportCategorySnapshot> categorisedTransactions,
      ReportSettings reportSettings) {
    return _buildReportUseCase.execute(categorisedTransactions, reportSettings);
  }

  Future<List<ReportCategorySnapshot>> unifyTransactionCurrencies(
      List<ReportCategorySnapshot> categorisedTransactions,
      String toCurrencyId) async {
    // TODO optimise
    for (var snapshot in categorisedTransactions) {
      for (var i = 0; i < snapshot.expensesTransactions.length; i++) {
        final transaction = snapshot.expensesTransactions[i];
        if (transaction.currencyId != toCurrencyId) {
          // TODO add currency to income
          final conversion = await _convertCurrencyUseCase.execute(
              transaction.currencyId, toCurrencyId);
          transaction.amount = double.parse(
              (transaction.amount * conversion.val).toStringAsFixed(2));
          transaction.currencyId = toCurrencyId;
          snapshot.expensesTransactions[i] = transaction;
        }
      }

      for (var i = 0; i < snapshot.incomeTransactions.length; i++) {
        final transaction = snapshot.incomeTransactions[i];
        if (transaction.currencyId != toCurrencyId) {
          final conversion = await _convertCurrencyUseCase.execute(
              transaction.currencyId, toCurrencyId);
          transaction.amount = double.parse(
              (transaction.amount * conversion.val).toStringAsFixed(2));
          transaction.currencyId = toCurrencyId;
          snapshot.incomeTransactions[i] = transaction;
        }
      }
      snapshot.recalculate();
    }
    return categorisedTransactions;
  }

  Future<List<ReportCategorySnapshot>> categoriseTransactions(
      List<CsvFileData> filesData, ReportSettings reportSettings) async {
    try {
      final filesList = await _convertCsvFileUseCase.execute(filesData);
      if (filesList.isEmpty) {
        return [];
      }

      // if header row is one chunck that means the separation failed
      if (filesList[0]![0].length <= 1) {
        throw IncorrectFeildSeparatorException();
      }

      List<Map<String, ReportCategorySnapshot>> categorySnapshots = [];

      for (var i = 0; i < filesData.length; i++) {
        final csvData = _filterCsvDataByDateUseCase.execute(
            filesList[i]!, filesData[i].importSettings, reportSettings);
        // TODO Handle this case with an error box
        if (csvData.isEmpty) {
          return [];
        }
        final categoriesMap = await _categoriseTransactionsUseCase.execute(
            csvData, filesData[i].importSettings);
        categorySnapshots.add(categoriesMap);
      }

      return _mergeCatengorySnapshots(categorySnapshots);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return [];
    }
  }

  List<ReportCategorySnapshot> _mergeCatengorySnapshots(
      List<Map<String, ReportCategorySnapshot>> listMap) {
    List<String> categoryNames = listMap[0].keys.toList();
    for (var categoryName in categoryNames) {
      for (var i = 1; i < listMap.length; i++) {
        listMap[0][categoryName]!.merge(listMap[i][categoryName]!);
      }
    }

    return listMap[0].values.toList();
  }

  bool hasUncategorisedTransactions(
      List<ReportCategorySnapshot> categorisedTransactions) {
    return categorisedTransactions.isNotEmpty
        ? categorisedTransactions[0].expensesTransactions.isNotEmpty ||
            categorisedTransactions[0].incomeTransactions.isNotEmpty
        : false;
  }

  List<Currency> getCurrencies() {
    return _getCurrenciesUseCase.execute();
  }

  Future<void> updateCategoriesFromRowData(
      List<UncategorisedRowData> values) async {
    _updateCategoriesFromRowData.execute(values);
  }

  Future<void> putReport(Report report) async {
    await _putReportUseCase.execute(report);
  }

  List<ReportCategorySnapshot> moveTransactionToCategory(
    ReportCategorySnapshot fromCategory,
    ReportCategorySnapshot toCategory,
    Transaction transaction,
    List<ReportCategorySnapshot> categorySnapshots,
  ) {
    return _moveTransactionBetweenCategorySnapshots.execute(
      fromCategory,
      toCategory,
      transaction,
      categorySnapshots,
    );
  }
}
