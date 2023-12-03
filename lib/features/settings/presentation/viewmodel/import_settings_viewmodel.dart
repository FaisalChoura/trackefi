import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/delete_import_settings_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/get_all_import_settings_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsViewModel extends StateNotifier<List<CsvImportSettings>> {
  final GetAllImportSettingsUseCase _getAllImportSettingsUseCase;
  final DeleteImportSettingsUseCase _deleteImportSettingsUseCase;
  ImportSettingsViewModel(
      this._getAllImportSettingsUseCase, this._deleteImportSettingsUseCase)
      : super([]);

  Future<List<CsvImportSettings>?> getImportSettings() async {
    return await _getAllImportSettingsUseCase.execute();
  }

  Future<bool?> deleteImportSettings(id) async {
    return await _deleteImportSettingsUseCase.execute(id);
  }
}

final importSettingsViewModelProvider = StateNotifierProvider((ref) =>
    ImportSettingsViewModel(ref.watch(getAllImportSettingsUseCase),
        ref.watch(deleteImportSettingsUseCaseProvider)));
