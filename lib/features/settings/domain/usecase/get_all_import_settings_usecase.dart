import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/data/repository/import_settings_list_store_repository_impl.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_list_store_repository.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllImportSettingsUseCase {
  GetAllImportSettingsUseCase(
      this._importSettingsRepository, this._importSettingsListStoreRepository);

  final ImportSettingsRepository _importSettingsRepository;
  final ImportSettingListStoreRepository _importSettingsListStoreRepository;

  Future<List<CsvImportSettings>?> execute() async {
    final allImportSettings =
        await _importSettingsRepository.getAllImportSettings();
    _importSettingsListStoreRepository.setImportSettings(allImportSettings);
    return allImportSettings;
  }
}

final getAllImportSettingsUseCase =
    Provider((ref) => GetAllImportSettingsUseCase(
          ref.watch(importSettingsRepositoryProivder),
          ref.watch(importSettingsListStoreRepositoryProvider),
        ));
