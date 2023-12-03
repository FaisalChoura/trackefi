import 'package:Trackefi/features/settings/data/database/import_settings_database.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';

class ImportSettingsRepositoryImpl implements ImportSettingsRepository {
  ImportSettingsRepositoryImpl(this._database);
  final ImportSettingsDatabase _database;

  @override
  Future<CsvImportSettings?> putImportSettings(
      CsvImportSettings importSettings) async {
    return await _database.putCategory(importSettings);
  }

  @override
  Future<bool> deleteImportSettings(int id) async {
    return await _database.delete(id);
  }

  @override
  Future<CsvImportSettings?> getImportSettings(int id) async {
    return await _database.get(id);
  }

  @override
  Future<List<CsvImportSettings>> getAllImportSettings() async {
    return await _database.getAll();
  }
}
