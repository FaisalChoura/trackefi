import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/data/repository/import_settings_list_store_repository_impl.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_list_store_repository.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteImportSettingsUseCase {
  DeleteImportSettingsUseCase(
      this._importSettingsRepository, this._importSettingsListStoreRepository);

  final ImportSettingsRepository _importSettingsRepository;
  final ImportSettingListStoreRepository _importSettingsListStoreRepository;

  Future<bool?> execute(id) async {
    await _importSettingsRepository.deleteImportSettings(id);
    return _importSettingsListStoreRepository.removeImportSetting(id);
  }
}

final deleteImportSettingsUseCaseProvider =
    Provider((ref) => DeleteImportSettingsUseCase(
          ref.watch(importSettingsRepositoryProivder),
          ref.watch(importSettingsListStoreRepositoryProvider),
        ));
