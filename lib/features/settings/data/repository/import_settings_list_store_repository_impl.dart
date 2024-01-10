import 'package:Trackefi/features/settings/data/store/import_settings_list_store.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_list_store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsListStoreRepositoryImpl
    implements ImportSettingListStoreRepository {
  ImportSettingsListStoreRepositoryImpl(this._store);
  final ImportSettingsListStore _store;

  @override
  addImportSetting(CsvImportSettings report) {
    _store.addImportSetting(report);
  }

  @override
  removeImportSetting(int id) {
    _store.removeImportSetting(id);
  }

  @override
  setImportSettings(List<CsvImportSettings> reports) {
    _store.setSettingsList(reports);
  }
}

final importSettingsListStoreRepositoryProvider =
    Provider<ImportSettingListStoreRepository>((ref) =>
        ImportSettingsListStoreRepositoryImpl(
            ref.watch(importSettingsListProvider.notifier)));
