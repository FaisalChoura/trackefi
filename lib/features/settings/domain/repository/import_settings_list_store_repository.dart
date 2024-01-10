import 'package:Trackefi/features/settings/domain/model/import_settings.dart';

abstract class ImportSettingListStoreRepository {
  addImportSetting(CsvImportSettings setting);
  removeImportSetting(int id);
  setImportSettings(List<CsvImportSettings> settings);
}
