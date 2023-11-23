import 'package:Trackefi/core/domain/model/currency.dart';
import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/get_currencies_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final importSettingsDialogViewModelProvider =
    StateNotifierProvider<ImportSettingsDialogViewModel, AsyncValue<void>>(
        (ref) => ImportSettingsDialogViewModel(
              ref.watch(getCurrenciesUseCaseProvider),
            ));

class ImportSettingsDialogViewModel extends StateNotifier<AsyncValue<void>> {
  final GetCurrenciesUseCase _getCurrenciesUseCase;

  ImportSettingsDialogViewModel(this._getCurrenciesUseCase)
      : super(const AsyncValue.data(null));

  List<Currency> getCurrencies() {
    return _getCurrenciesUseCase.execute();
  }
}
