import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/get_currencies_usecase.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/put_import_settings_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importSettingsDialogViewModelProvider =
    StateNotifierProvider<ImportSettingsDialogViewModel, AsyncValue<void>>(
        (ref) => ImportSettingsDialogViewModel(
            ref.watch(getCurrenciesUseCaseProvider),
            ref.watch(putImportSettingsUseCase)));

class ImportSettingsDialogViewModel extends StateNotifier<AsyncValue<void>> {
  final GetCurrenciesUseCase _getCurrenciesUseCase;
  final PutImportSettingsUseCase _putImportSettingsUseCase;

  ImportSettingsDialogViewModel(
    this._getCurrenciesUseCase,
    this._putImportSettingsUseCase,
  ) : super(const AsyncValue.data(null));

  List<Currency> getCurrencies() {
    return _getCurrenciesUseCase.execute();
  }

  Future<CsvImportSettings?> putImportSettings(
      CsvImportSettings importSettings) async {
    final addedImportSetting =
        await _putImportSettingsUseCase.execute(importSettings);
    return addedImportSetting;
  }
}
