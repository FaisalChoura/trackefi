import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/data/repository/import_settings_list_store_repository_impl.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_list_store_repository.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PutImportSettingsUseCase {
  PutImportSettingsUseCase(
      this._importSettingsRepository, this._importSettingsListStoreRepository);

  final ImportSettingsRepository _importSettingsRepository;
  final ImportSettingListStoreRepository _importSettingsListStoreRepository;

  Future<CsvImportSettings?> execute(CsvImportSettings settings) async {
    final savedImportSetting =
        await _importSettingsRepository.putImportSettings(settings);
    _importSettingsListStoreRepository.addImportSetting(settings);
    return savedImportSetting;
  }
}

final putImportSettingsUseCase = Provider((ref) => PutImportSettingsUseCase(
      ref.watch(importSettingsRepositoryProivder),
      ref.watch(importSettingsListStoreRepositoryProvider),
    ));
