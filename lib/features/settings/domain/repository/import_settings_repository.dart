import 'package:Trackefi/features/settings/domain/model/import_settings.dart';

abstract class ImportSettingsRepository {
  Future<CsvImportSettings?> putImportSettings(CsvImportSettings settings);

  Future<bool> deleteImportSettings(int id);

  Future<CsvImportSettings?> getImportSettings(int id);
  Future<List<CsvImportSettings>> getAllImportSettings();
}
