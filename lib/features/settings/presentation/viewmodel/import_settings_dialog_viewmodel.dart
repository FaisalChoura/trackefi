import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/get_currencies_usecase.dart';
import 'package:Trackefi/features/csv_files/presentation/viewmodel/csv_files_viewmodel.dart';
import 'package:Trackefi/features/reports/domain/domain_modulde.dart';
import 'package:Trackefi/features/reports/domain/enum/csv_file_chunk_size_enum.dart';
import 'package:Trackefi/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importSettingsDialogViewModelProvider =
    StateNotifierProvider<ImportSettingsDialogViewModel, AsyncValue<void>>(
        (ref) => ImportSettingsDialogViewModel(
              ref.watch(getCurrenciesUseCaseProvider),
              ref.watch(convertCsvFileUseCaseProvider),
            ));

class ImportSettingsDialogViewModel extends StateNotifier<AsyncValue<void>> {
  final GetCurrenciesUseCase _getCurrenciesUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;

  ImportSettingsDialogViewModel(
      this._getCurrenciesUseCase, this._convertCsvFileUseCase)
      : super(const AsyncValue.data(null));

  List<Currency> getCurrencies() {
    return _getCurrenciesUseCase.execute();
  }

  Future<HeaderFirstRowData> getHeaderAndFirstRow(CsvFileData file) async {
    final data = await _convertCsvFileUseCase
        .execute([file], CsvFileChunkSizeEnum.small);
    final headerRow = data[0]![0].map((e) => e.toString()).toList();
    final firstRow = data[0]![1].map((e) => e.toString()).toList();
    return HeaderFirstRowData(headerRow, firstRow);
  }
}
