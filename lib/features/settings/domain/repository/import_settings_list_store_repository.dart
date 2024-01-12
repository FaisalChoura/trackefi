import 'package:Trackefi/features/settings/domain/model/import_settings.dart';

abstract class ImportSettingListStoreRepository {
  putImportSetting(CsvImportSettings setting);
  removeImportSetting(int id);
  setImportSettings(List<CsvImportSettings> settings);
}
