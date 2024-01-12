import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportSettingsListStore extends StateNotifier<List<CsvImportSettings>> {
  ImportSettingsListStore() : super([]);

  void setSettingsList(List<CsvImportSettings> setting) {
    state = setting;
  }

  void putImportSetting(CsvImportSettings setting) {
    final index = state.indexOf(setting);
    if (index < 0) {
      state = [...state, setting];
    } else {
      state[index] = setting;
      state = [...state];
    }
  }

  void removeImportSetting(int id) {
    state = state.where((f) => f.id != id).toList();
  }
}

final importSettingsListProvider =
    StateNotifierProvider<ImportSettingsListStore, List<CsvImportSettings>>(
        (ref) => ImportSettingsListStore());
