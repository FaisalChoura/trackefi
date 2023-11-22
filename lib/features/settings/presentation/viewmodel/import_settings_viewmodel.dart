import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/get_all_import_settings_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/put_import_settings_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsViewModel extends StateNotifier<List<CsvImportSettings>> {
  final PutImportSettingsUseCase _putImportSettingsUseCase;
  final GetAllImportSettingsUseCase _getAllImportSettingsUseCase;
  ImportSettingsViewModel(
    this._putImportSettingsUseCase,
    this._getAllImportSettingsUseCase,
  ) : super([]);

  Future<CsvImportSettings?> putImportSettings(
      CsvImportSettings importSettings) async {
    final addedImportSetting =
        await _putImportSettingsUseCase.execute(importSettings);
    // TODO handle if not found
    if (addedImportSetting != null) {
      state = [...state, importSettings];
    }
    return addedImportSetting;
  }

  Future<List<CsvImportSettings>?> getImportSettings() async {
    return await _getAllImportSettingsUseCase.execute();
  }
}

final importSettingsViewModelProvider =
    StateNotifierProvider((ref) => ImportSettingsViewModel(
          ref.watch(putImportSettingsUseCase),
          ref.watch(getAllImportSettingsUseCase),
        ));
